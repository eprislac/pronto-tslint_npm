require 'pronto'
require 'shellwords'

module Pronto
  class TSLintNpm < Runner
    CONFIG_FILE = '.pronto_tslint_npm.yml'.freeze
    CONFIG_KEYS = %w(tslint_executable files_to_lint).freeze

    attr_writer :tslint_executable

    def tslint_executable
      @tslint_executable || 'tslint'.freeze
    end

    def files_to_lint
      @files_to_lint || /(.*\.ts)$/
    end

    def files_to_lint=(regexp)
      @files_to_lint = regexp.is_a?(Regexp) && regexp || Regexp.new(regexp)
    end

    def read_config
      config_file = File.join(repo_path, CONFIG_FILE)
      return unless File.exist?(config_file)
      config = YAML.load_file(config_file)

      CONFIG_KEYS.each do |config_key|
        next unless config[config_key]
        send("#{config_key}=", config[config_key])
      end
    end

    def run
      return [] if !@patches || @patches.count.zero?
      read_config
      @patches
        .select { |patch| patch.additions > 0 }
        .select { |patch| ts_file?(patch.new_file_full_path) }
        .map { |patch| inspect(patch) }
        .flatten.compact
    end

   # private

    def repo_path
      @_repo_path ||= @patches.first.repo.path
    end

    def inspect(patch)
      offences = run_tslint(patch)
      clean_up_tslint_output(offences)
        .map do |offence|
          patch
            .added_lines
            .select { |line| line.new_lineno == offence[:line] }
            .map { |line| new_message(offence[:msg], line) }
        end
    end

    def new_message(offence, line)
      path = line.patch.delta.new_file[:path]
      level = :warning
      Message.new(path, line, level, offence, nil, self.class)
    end

    def ts_file?(path)
      !!(files_to_lint =~ path.to_s)
    end

    def run_tslint(patch)
      Dir.chdir(repo_path) do
        escaped_file_path = Shellwords.escape(patch.new_file_full_path.to_s)
        JSON.parse(
          `#{tslint_executable} #{escaped_file_path} -t json`
        )
      end
    end

    def clean_up_tslint_output(output)
      # 1. Filter out offences without a warning or error
      # 2. Get the messages for that file
      # 3. Ignore errors without a line number for now
      return [] unless output.count > 0
      output.map do |offence|
        {
          msg: offence['failure'],
          line: offence['startPosition']['line']
        }
      end

    end
  end
end
