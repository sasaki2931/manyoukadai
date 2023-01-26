FactoryBot.define do
    factory :task do
      
      name { 'test' }
      content { 'test' }
      deadline{'2001-01-01'}
      status{'未着手'}

      after(:build) do |task|
        label = create(:label)
        task.labellings << build(:labelling, task: task, label: label)
      end

    end
    factory :second_task, class: Task do
      name { 'test_name2' }
      content { 'test_content2' }
      deadline{'2002-02-02'}
      status{'未着手'}

      association :user
    end
  end