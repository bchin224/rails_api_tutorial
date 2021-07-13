require 'rails_helper'

describe 'Books API', type: :request do
    describe 'GET /books' do
        before do
            FactoryBot.create(:book, title: '1984', author: 'George Orwell')
            FactoryBot.create(:book, title: 'The Time Machine', author: 'H.G. Wells')
        end
        it 'returns all books' do
            get '/api/v1/books'

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2)
        end
    end

    describe 'POST /books' do
        it 'create a new book' do
            expect {
                post '/api/v1/books', params: {
                    book: {title: 'The Martian'},
                    author: {first_name: 'Andy', last_name: 'Weir', age: '48'}
                }
            }.to change { Book.count }.from(0).to(1)

            expect(response).to have_http_status(:created)
            expect(Author.count).to eq(1)
            expect(JSON.parse(response.body)).to eq(
                {
                    'id': 1,
                    'title': 'The Martian',
                    'author_name': 'Andy Weir',
                    'kauthor_age': 48
                }
            )
        end
    end

    describe 'DELETE /books/:id' do
        let!(:book) { FactoryBot.create(:book, title: '1984', author: 'George Orwell') }
        
        it 'deletes a book' do
            expect {
                delete "/api/v1/books/#{book.id}"
            }.to change { Book.count }.from(1).to(0)

            expect(response).to have_http_status(:no_content)
        end
    end

    it 'returns a subset of books based on limit' do
        get '/api/v1/books', params: { limit: 1 }

        expect(response).to have_http_status(:created)
        expect(Author.count).to eq(1)
        expect(JSON.parse(response.body)).to eq(
            {
                'id': 1,
                'title': 'The Martian',
                'author_name': 'Andy Weir',
                'kauthor_age': 48
            }
        )
    end

    it 'returns a subset of books on limit and offset' do
        get '/api/v1/books', params: { limit: 1, offsetL 1 } 

        expect(response).to have_http_status(:created)
        expect(Author.count).to eq(1)
        expect(JSON.parse(response.body)).to eq(
            {
                'id': 2,
                'title': 'The Time Machine',
                'author_name': 'H.G. Wells',
                'kauthor_age': 78
            }
        )
    end


end
