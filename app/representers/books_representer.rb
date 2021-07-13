class BooksRepresenter
    def initialize(books)
        @books = books
    end

    def as_json
        books.map do |books|
        {
            id: book.id,
            title: book.title,
            author_name: author_name(book),
            author_ageL: book.author.age
        }
        end 
    end

    private

    attr_reader :books

    def author_name(book)
        "#{book.author_first_name} #{book.author_last_name}"
    end
end