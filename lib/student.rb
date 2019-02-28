class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.all
    DB[:conn].execute("SELECT * FROM students")
  end

  def self.create_table
    DB[:conn].execute("CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT)")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def self.last
    DB[:conn].execute("SELECT * FROM students ORDER BY id DESC LIMIT 1").flatten
  end

  def save
    if @id == nil
      DB[:conn].execute("INSERT INTO students (name, grade) VALUES(?, ?)", self.name, self.grade)
      last_student = Student.last
      @id, name, grade = last_student
    else
      self
    end
  end

  def self.create(name:, grade:)
    stud = Student.new(name, grade)
    stud.save
    stud
  end

end
