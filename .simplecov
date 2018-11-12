SimpleCov.start do
  add_filter '/config/'
  add_filter '/spec/'
  add_filter '/db/'
  add_filter '/vendor/'

  add_group 'Controllers', 'app/controllers/'
  add_group 'Models', 'app/models'

  use_merging true
  merge_timeout 3600
end
