require 'rails_helper'

RSpec.describe Professor, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :specialty}
  end

  describe 'relationships' do
    it {should have_many :professor_students}
    it {should have_many(:students).through(:professor_students)}
  end

  describe 'class methods' do
    let!(:professor1) { create(:professor) } 
    let!(:professor2) { create(:professor, name: 'Taylor Phillips') } 

    let!(:student1) { create(:student) } 
    let!(:student2) { create(:student, name: "Ron Weasley", age: 14) } 
    let!(:student3) { create(:student, name: "Luna Lovegood") } 

    let!(:professor_student1) { create(:professor_student, professor_id: professor1.id, student_id: student1.id) } 
    let!(:professor_student2) { create(:professor_student, professor_id: professor1.id, student_id: student2.id) } 
    let!(:professor_student3) { create(:professor_student, professor_id: professor2.id, student_id: student3.id) } 

    it '.students' do
      expect(professor1.students).to eq([student1, student2])
    end

    it '.average_student_age' do
      expect(professor1.average_student_age).to eq(13)
    end
  end
end
