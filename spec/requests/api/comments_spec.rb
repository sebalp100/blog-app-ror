require 'swagger_helper'

describe 'Comments API' do

  path '/api/v1/posts/{postId}/comments' do
    post 'Creates a comment' do
      tags 'Comments'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :postId, in: :path, type: :integer, description: 'ID of the post to add a comment to'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: [ 'text' ]
      }
  
      response '201', 'comment created' do
        let(:postId) { Post.create(title: 'My post', content: 'Lorem ipsum').id }
        let(:comment) { { text: 'Great post!' } }
        run_test!
      end
  
      response '400', 'bad request' do
        let(:postId) { Post.create(title: 'My post', content: 'Lorem ipsum').id }
        let(:comment) { { text: nil } }
        run_test!
      end
  
      response '404', 'post not found' do
        let(:postId) { 0 }
        let(:comment) { { text: 'Great post!' } }
        run_test!
      end
    end
  end
end
