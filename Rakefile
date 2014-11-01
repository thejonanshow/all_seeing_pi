require 'rake/testtask'
require 'bundler'

Bundler.require

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end
