FactoryBot.define do
    factory :task do
      
      name { 'test_name1' }
      content { 'test_content1' }
      deadline{'2001-1-1'}
    end
    factory :second_task, class: Task do
      name { 'test_name2' }
      content { 'test_content2' }
      deadline{'2002-2-2'}
    end
  end