class Animal
  attr_accessor :type, :name, :age

  def initialize(type, name, age)
    @type = type
    @name = name
    @age = age
  end

  def clone
    self.dup
  end
end

# создаем экземпляр класса Animal
animal1 = Animal.new("собака", "Бобик", 3)

# клонируем объект
animal2 = animal1.clone

# изменяем имя у клонированного объекта
animal2.name = "Шарик"

# выводим информацию о объектах
puts "Оригинал: #{animal1.name}, #{animal1.type}, #{animal1.age}"
puts "Клон: #{animal2.name}, #{animal2.type}, #{animal2.age}"
