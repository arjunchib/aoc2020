class ExpenseReportFixer

  def process(expense_report)
    expenses = File.readlines(expense_report).map {|line| line.to_i}
    pairs = expenses.product(expenses)
    pair = pairs.find {|a,b| a + b == 2020}
    pair.reduce(1, :*)
  end

  def process3(expense_report)
    expenses = File.readlines(expense_report).map {|line| line.to_i}
    triples = expenses.product(expenses, expenses)
    triple = triples.find {|a,b,c| a + b + c == 2020}
    triple.reduce(1, :*)
  end

end

