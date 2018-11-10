class HomeController < ApplicationController
	def index
	end

  def get_processed_dataset
    users = User.datatable_filter(
    	search: params['search']['value'],
    	columns: params['columns'],
    	order: params['order'],
    	start: params['start'].to_i,
    	length: params['length'].to_i
    )

    render json: { users: users.collection,
                   	draw: params['draw'].to_i,
                   	recordsTotal: users.count,
                   	recordsFiltered: users.count }
  end
end
