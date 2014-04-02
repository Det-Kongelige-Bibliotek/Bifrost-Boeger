Before do |scenario|

  if scenario.title == 'Search for E-book'
    # ingest testbook
    b = Book.new
    b.title = 'Testbog1'
    b.author = ["Anders And"]
    b.save
  end

end