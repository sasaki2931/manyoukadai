FactoryBot.define do
    factory :task do
      
      name { 'test_name1' }
      content { 'test_content1' }
      deadline{'2001-01-01'}
      status{'未着手'}

    end
    factory :second_task, class: Task do
      name { 'test_name2' }
      content { 'test_content2' }
      deadline{'2002-02-02'}
      status{'未着手'}
    end
  end