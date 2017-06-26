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

      context 'patches with 6 errors' do
        include_context 'test repo'
        let(:patches) { repo.diff('master') }

        it 'returns correct number of errors' do
          expect(run.count).to eql(7)
        end

        it 'has correct first message' do
          expect(run.first.msg).to eql("Forbidden 'var' keyword, use 'let' or 'const' instead")
        end

        it 'has correct first line number' do
          expect(run.first.line.new_lineno).to eql(5)
        end

        context(
          'with files to lint config that never matches',
          config: { 'files_to_lint' => 'will never match' }
        ) do
          it 'returns zero errors' do
            expect(run.count).to eql(0)
          end
        end
      end
    end

    describe '#files_to_lint' do
      subject(:files_to_lint) { tslint.files_to_lint }

      it 'matches .ts by default' do
        expect(files_to_lint).to match('my_ts.ts')
      end
    end

    describe '#tslint_executable' do
      subject(:tslint_executable) { tslint.tslint_executable }

      it 'is `tslint` by default' do
        expect(tslint_executable).to eql('tslint')
      end
    end
  end
end
