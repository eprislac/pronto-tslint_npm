require 'spec_helper'
require 'byebug'

module Pronto
  describe TSLintNpm do
    let(:tslint) { TSLintNpm.new(patches) }
    let(:patches) { [] }

    describe '#run' do
      subject(:run) { tslint.run }

      context 'patches are nil' do
        let(:patches) { nil }

        it 'returns an empty array' do
          expect(run).to eql([])
        end
      end

      context 'no patches' do
        let(:patches) { [] }

        it 'returns an empty array' do
          expect(run).to eql([])
        end
      end

      context 'patches with a one and a four warnings' do
        include_context 'test repo'

        let(:patches) { repo.diff('master') }

        it 'returns correct number of errors' do
          expect(run.count).to eql(5)
        end

        xit 'has correct first message' do
          expect(run.first.msg).to eql("'foo' is not defined.")
        end

        context(
          'with files to lint config that never matches',
          config: { 'files_to_lint' => 'will never match' }
        ) do
          xit 'returns zero errors' do
            expect(run.count).to eql(0)
          end
        end

        context(
          'with files to lint config that matches only .ts',
          config: { 'files_to_lint' => '\.ts$' }
        ) do
          xit 'returns correct amount of errors' do
            expect(run.count).to eql(2)
          end
        end

        context(
          'with different tslint executable',
          config: { 'tslint_executable' => './custom_tslint.sh' }
        ) do
          xit 'calls the custom tslint tslint_executable' do
            expect { run }.to raise_error(JSON::ParserError, /custom tslint called/)
          end
        end
      end

      context 'repo with ignored and not ignored file, each with three warnings' do
        include_context 'tslintignore repo'

        let(:patches) { repo.diff('master') }

        xit 'returns correct number of errors' do
          expect(run.count).to eql(3)
        end

        xit 'has correct first message' do
          expect(run.first.msg).to eql("'HelloWorld' is defined but never used.")
        end
      end
    end

    describe '#files_to_lint' do
      subject(:files_to_lint) { tslint.files_to_lint }

      xit 'matches .ts by default' do
        expect(files_to_lint).to match('my_ts.ts')
      end
    end

    describe '#tslint_executable' do
      subject(:tslint_executable) { tslint.tslint_executable }

      xit 'is `tslint` by default' do
        expect(tslint_executable).to eql('tslint')
      end
    end
  end
end
