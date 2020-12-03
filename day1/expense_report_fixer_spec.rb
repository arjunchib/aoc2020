require_relative 'expense_report_fixer'
describe ExpenseReportFixer do
  let(:fixer) { ExpenseReportFixer.new }

  describe 'process' do
    it 'can solve the example' do
      expect(fixer.process('expense-report-example.txt')).to eq 514579
      expect(fixer.process3('expense-report-example.txt')).to eq 241861950
      # puts fixer.process('expense-report.txt')
      # puts fixer.process3('expense-report.txt')
    end
  end

end

