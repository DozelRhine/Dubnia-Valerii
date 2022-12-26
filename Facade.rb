# Интерфейс подсистемы
class Subsystem1
  def operation1
    puts "Subsystem1: Ready!"
  end

  def operation_n
    puts "Subsystem1: Go!"
  end
end

# Интерфейс подсистемы
class Subsystem2
  def operation1
    puts "Subsystem2: Get ready!"
  end

  def operation_z
    puts "Subsystem2: Fire!"
  end
end

# Фасад
class Facade
  # Конструктор фасада создаёт экземпляры подсистем
  def initialize
    @subsystem1 = Subsystem1.new
    @subsystem2 = Subsystem2.new
  end

  # Методы фасада делегируют запросы к подсистемам
  def operation
    puts "Facade: Prepare operation..."
    @subsystem1.operation1
    @subsystem2.operation1
    puts "Facade: Operation completed!"
  end
end

# Клиентский код
facade = Facade.new
facade.operation
