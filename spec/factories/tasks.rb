FactoryBot.define do
    factory :task do
      
      name { 'test_name1' }
      content { 'test_content1' }
    end
    factory :second_task, class: Task do
      name { 'test_name2' }
      content { 'test_content2' }
    end
  end