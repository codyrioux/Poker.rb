require 'rake'
require 'rake/testtask'

desc "Build Documentation"
task :doc do
  # @todo Add a doc building rake task.
end

desc "Run Unit Tests"
Rake::TestTask.new(:test) do |t|
	#t.libs << 'app'
	t.pattern = 'test/test_*.rb'
	t.verbose = true
end
