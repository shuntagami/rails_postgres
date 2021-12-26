namespace :spec do
  desc 'Run spec with coverage'
  task :coverage do
    ENV['COVERAGE'] = 'true'
    Rake::Task['spec'].execute
  end
end
