require 'rails_helper'

RSpec.describe HomeController do
  describe 'GET index' do
    it 'renders the index template' do
      get :index

      expect(response).to render_template('index')
    end
  end

  describe 'GET get_processed_dataset' do
    let(:users_collection) { double(collection: [], count: 0) }
    let(:params) {{ 'search' => { 'value' => '' }}}

    it 'renders the index template' do
      allow(User).to receive(:datatable_filter).and_return(users_collection)

      get :get_processed_dataset, params: params

      response_body = JSON.parse(response.body)
      expect(response_body['users']).to eq []
      expect(response_body['draw']).to eq 0
      expect(response_body['recordsTotal']).to eq 0
      expect(response_body['recordsFiltered']).to eq 0
    end
  end
end
