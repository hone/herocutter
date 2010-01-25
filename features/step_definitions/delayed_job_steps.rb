When /^I wait for all the jobs to finish processing$/ do
  Delayed::Job.work_off
end
