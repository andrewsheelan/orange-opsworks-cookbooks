name 'clockwork'

%w{ deploy god }.each do |cb|
  depends cb
end
