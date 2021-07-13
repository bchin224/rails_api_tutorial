class BookRepresenter
    def initialize(book)
        @book = book
    end

    def as_json
        {
            id: book.id,
            title: book.title,
            author_name: author_name(book),
            author_ageL: book.author.age
        }
    end

    private

    attr_reader :book

    def author_name(book)
        "#{book.author_first_name} #{book.author_last_name}"
    end
end