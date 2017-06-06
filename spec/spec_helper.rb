require 'fileutils'
require 'byebug'
require 'rspec'
require 'pronto/tslint_npm'

%w(test tslintignore).each do |repo_name|
  RSpec.shared_context "#{repo_name} repo" do
    let(:git) { "spec/fixtures/#{repo_name}.git/git" }
    let(:dot_git) { "spec/fixtures/#{repo_name}.git/.git" }

    before { FileUtils.mv(git, dot_git) }
    let(:repo) { Pronto::Git::Repository.new("spec/fixtures/#{repo_name}.git") }
    after { FileUtils.mv(dot_git, git) }
  end
end

RSpec.shared_context 'with config', config: true do
  requested_config = metadata[:config].to_yaml

  let(:config_path) { File.join(repo.path.to_s, Pronto::TSLintNpm::CONFIG_FILE) }

  before(:each) { File.write(config_path, requested_config) }
  after(:each) { FileUtils.rm(config_path) }
end
