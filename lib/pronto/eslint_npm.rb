require 'pronto'
require 'shellwords'

module Pronto
  class ESLintNpm < Runner
    class << self
      attr_writer :eslint_executable, :files_to_lint

      def eslint_executable
        @eslint_executable || 'eslint'.freeze
      end

      def files_to_lint
        @files_to_lint || /(\.js|\.es6)$/
      end
    end

    def run
      return [] unless @patches

      @patches
        .select { |patch| patch.additions > 0 }
        .select { |patch| js_file?(patch.new_file_full_path) }
        .map { |patch| inspect(patch) }
        .flatten.compact
    end

    private

    def inspect(patch)
      @_repo_path ||= @patches.first.repo.path

      offences = run_eslint(patch)
      clean_up_eslint_output(offences)
        .map do |offence|
          patch
            .added_lines
            .select { |line| line.new_lineno == offence['line'] }
            .map { |line| new_message(offence, line) }
        end
    end

    def new_message(offence, line)
      path = line.patch.delta.new_file[:path]
      level = :warning

      Message.new(path, line, level, offence['message'], nil, self.class)
    end

    def js_file?(path)
      self.class.files_to_lint =~ path.to_s
    end

    def run_eslint(patch)
      Dir.chdir(@_repo_path) do
        escaped_file_path = Shellwords.escape(patch.new_file_full_path.to_s)
        JSON.parse(
          `#{self.class.eslint_executable} #{escaped_file_path} -f json`
        )
      end
    end

    def clean_up_eslint_output(output)
      # 1. Filter out offences without a warning or error
      # 2. Get the messages for that file
      # 3. Ignore errors without a line number for now
      output
        .select { |offence| offence['errorCount'] + offence['warningCount'] > 0 }
        .map { |offence| offence['messages'] }
        .flatten.select { |offence| offence['line'] }
    end
  end
end
