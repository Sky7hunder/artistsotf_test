require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to be_mongoid_document }

  describe '.datatable_filter' do
		let(:columns) do
			['first_name', 'last_name', 'birthday', 'address'].each_with_index.inject({}) do |hash, (name, index)|
				hash[index.to_s] = datatable_column_hash(name)
				hash
			end
		end
		let(:order) { { '0' => { 'column' => orderable_column, 'dir' => dir }} }
		let(:dir) { 'desc' }
		let(:users_filtered) do
			User.datatable_filter(
	    	search: search,
	    	columns: columns,
	    	order: order,
	    	start: 0,
	    	length: length
			)
		end
		let(:length) { 10 }
		let(:orderable_column) { '0' }

  	context 'without searching' do
  		let(:search) { '' }

  		context 'with pagination' do
		  	before { create_list(:user, 20) }

	  		it 'returns 10 users per page' do
	  			expect(users_filtered.count).to eq 20
	  			expect(users_filtered.collection.count).to eq 10
	  		end

		  	context '25 users per page' do
		  		let(:length) { 25 }

		  		it 'returns 20 objects from 20' do
		  			expect(users_filtered.count).to eq 20
		  			expect(users_filtered.collection.count).to eq 20
		  		end
		  	end
	  	end

	  	context 'sorting returns ordered users' do
				context "by 'first_name'" do
					let!(:user_1) { create(:user, first_name: 'Alex') }
					let!(:user_2) { create(:user, first_name: 'Bob') }

		  		it 'by desc' do
		  			expect(users_filtered.collection).to eq [user_2, user_1]
		  		end

		  		context 'by asc' do
		  			let(:dir) { 'asc' }

		  			it { expect(users_filtered.collection).to eq [user_1, user_2] }
		  		end
		  	end

				context "by 'last_name'" do
					let(:orderable_column) { '1' }
					let!(:user_1) { create(:user, last_name: 'Alex') }
					let!(:user_2) { create(:user, last_name: 'Bob') }

		  		it 'by desc' do
		  			expect(users_filtered.collection).to eq [user_2, user_1]
		  		end

		  		context 'by asc' do
		  			let(:dir) { 'asc' }

		  			it { expect(users_filtered.collection).to eq [user_1, user_2] }
		  		end
		  	end

				context "by 'birthday'" do
					let(:orderable_column) { '2' }
					let!(:user_1) { create(:user, birthday: '2000-01-01') }
					let!(:user_2) { create(:user, birthday: '2000-01-02') }

		  		it 'by desc' do
		  			expect(users_filtered.collection).to eq [user_2, user_1]
		  		end

		  		context 'by asc' do
		  			let(:dir) { 'asc' }

		  			it { expect(users_filtered.collection).to eq [user_1, user_2] }
		  		end
		  	end

				context "by 'address'" do
					let(:orderable_column) { '3' }
					let!(:user_1) { create(:user, address: 'Address 1') }
					let!(:user_2) { create(:user, address: 'Address 2') }

		  		it 'by desc' do
		  			expect(users_filtered.collection).to eq [user_2, user_1]
		  		end

		  		context 'by asc' do
		  			let(:dir) { 'asc' }

		  			it { expect(users_filtered.collection).to eq [user_1, user_2] }
		  		end
		  	end
	  	end
  	end

  	context 'with searching' do
  		let(:search) { 'Ale' }

  		context 'with pagination' do
  			let!(:bob) { create(:user, first_name: 'Bob') }

		  	before do
		  		create_list(
		  			:user,
		  			19,
		  			first_name: 'Alex',
  					last_name: 'L',
  					birthday: Date.current,
  					address: 'Address'
		  		)
		  	end

	  		it 'returns 10 users per page' do
	  			expect(users_filtered.count).to eq 19
	  			expect(users_filtered.collection.count).to eq 10
	  		end

		  	context '25 users per page' do
		  		let(:length) { 25 }

		  		it 'returns 19 objects from 19' do
		  			expect(users_filtered.count).to eq 19
		  			expect(users_filtered.collection.count).to eq 19
		  		end
		  	end

		  	context 'finds 1 record' do
		  		let(:search) { 'Bo' }

		  		it do
		  			expect(users_filtered.count).to eq 1
		  			expect(users_filtered.collection).to eq [bob]
		  		end
		  	end

		  	context 'returns 0 records' do
		  		let(:search) { 'Tim' }

		  		it do
		  			expect(users_filtered.count).to eq 0
		  			expect(users_filtered.collection).to eq []
		  		end
		  	end
	  	end

	  	context 'sorting returns ordered users' do
				context "by 'first_name'" do
					let!(:user_1) { create(:user, first_name: 'Alex1') }
					let!(:user_2) { create(:user, first_name: 'Alex2') }

		  		it 'by desc' do
		  			expect(users_filtered.collection).to eq [user_2, user_1]
		  		end

		  		context 'by asc' do
		  			let(:dir) { 'asc' }

		  			it { expect(users_filtered.collection).to eq [user_1, user_2] }
		  		end
		  	end

				context "by 'last_name'" do
					let(:orderable_column) { '1' }
					let!(:user_1) { create(:user, last_name: 'Alex1') }
					let!(:user_2) { create(:user, last_name: 'Alex2') }

		  		it 'by desc' do
		  			expect(users_filtered.collection).to eq [user_2, user_1]
		  		end

		  		context 'by asc' do
		  			let(:dir) { 'asc' }

		  			it { expect(users_filtered.collection).to eq [user_1, user_2] }
		  		end
		  	end

				context "by 'birthday'" do
					let(:orderable_column) { '2' }
					let!(:user_1) { create(:user, first_name: 'Alex1', birthday: '2000-01-01') }
					let!(:user_2) { create(:user, first_name: 'Alex2', birthday: '2000-01-02') }

		  		it 'by desc' do
		  			expect(users_filtered.collection).to eq [user_2, user_1]
		  		end

		  		context 'by asc' do
		  			let(:dir) { 'asc' }

		  			it { expect(users_filtered.collection).to eq [user_1, user_2] }
		  		end
		  	end

				context "by 'address'" do
					let(:orderable_column) { '3' }
					let!(:user_1) { create(:user, first_name: 'Alex1', address: 'Address 1') }
					let!(:user_2) { create(:user, first_name: 'Alex2', address: 'Address 2') }

		  		it 'by desc' do
		  			expect(users_filtered.collection).to eq [user_2, user_1]
		  		end

		  		context 'by asc' do
		  			let(:dir) { 'asc' }

		  			it { expect(users_filtered.collection).to eq [user_1, user_2] }
		  		end
		  	end
	  	end
  	end
  end
end

def datatable_column_hash(column_name)
	{
		'data' => column_name,
		'name' => '',
		'searchable' => 'true',
		'orderable' => 'true',
		'search' => {
			'value' => '',
			'regex' => 'false'
		}
	}
end
