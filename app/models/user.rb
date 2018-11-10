class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Datatable

  field :first_name, type: String
  field :last_name, type: String
  field :birthday, type: Date
  field :address, type: String

  DATATABLE_COLUMNS = %i[first_name last_name birthdayString address].freeze

  class << self
	  private

	  def aggregation_pipeline(filter_params)
	  	pipeline = [{ '$project' => aggregator_project }]
  		pipeline << { '$match' => { '$or' => searchable_columns(filter_params) }} if filter_params[:search]
	  	pipeline + default_aggregation_pipeline(filter_params)
	  end

	  def aggregator_project
	  	{
				first_name: '$first_name',
				last_name: '$last_name',
				birthday: '$birthday',
				address: '$address',
				birthdayString: {
					'$dateToString' => {
						format: '%Y-%m-%d',
						date: "$birthday"
					}
				} 
			}
	  end
	end
end
