require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec, :tag) do |t, task_args|
  t.rspec_opts = '-I./lib'
end

task default: :spec
