module Datatable
	extend ActiveSupport::Concern

  module ClassMethods
    def datatable_filter(filter_params)
		  aggregation = User.collection.aggregate(aggregation_pipeline(filter_params))
			datatable_data(filter_params[:search], aggregation)
	  end

	  private

	  def default_aggregation_pipeline(filter_params)
	  	[
	  		{ '$sort' => datatable_sort(filter_params[:order]) },
				{ '$facet' => {
						paginatedResults: [
							{ '$skip' => filter_params[:start] },
							{ '$limit' => filter_params[:length] }
						],
						totalCount: [{ '$count' => 'count' }]
					}
				}
			]
	  end

	  def searchable_columns(filter_params)
      searchable_columns = []

	    filter_params[:columns].each do |key, value|
	    	next unless value['searchable']
	    	searchable_columns << searchable_column(key, filter_params[:search])
	    end
	    searchable_columns
	  end

	  def searchable_column(key, search_value)
 			{ "#{self::DATATABLE_COLUMNS[key.to_i]}": /#{search_value}/i }
	  end

	  def datatable_sort(order)
	  	column = self::DATATABLE_COLUMNS[order['0']['column'].to_i]
			order_params = {}
	  	order_params[column.to_s] = sort_dir(order['0']['dir'])
	  	order_params
	  end

	  def sort_dir(dir)
	  	dir == 'desc' ? -1 : 1
	  end

	  def datatable_data(search_value, aggregation)
	  	OpenStruct.new(
	  		collection: datatable_collection(aggregation),
	  		count: datatable_count(aggregation, search_value)
	  	)
	  end

	  def datatable_collection(aggregation)
			aggregation.to_a[0]['paginatedResults'].map do |u|
	    	self.new(u.reject { |k| !self.attribute_method?(k) })
	    end
	  end

	  def datatable_count(aggregation, search_value)
			if search_value.blank?
				count
			else
				aggregation.to_a[0]['totalCount'].try(:[], 0).try(:[], 'count') || 0
			end
	  end
  end
end
