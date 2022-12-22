def heap_sort(array)
  # Превращаем массив в кучу
  n = array.length
  (n / 2 - 1).downto(0) do |i|
    heapify(array, n, i)
  end

  # Сортируем массив
  (n - 1).downto(1) do |i|
    array[0], array[i] = array[i], array[0]
    heapify(array, i, 0)
  end

  array
end

def heapify(array, n, i)
  largest = i
  left = 2 * i + 1
  right = 2 * i + 2

  # Находим наибольший узел из текущего, левого и правого потомка
  largest = left if left < n && array[left] > array[largest]
  largest = right if right < n && array[right] > array[largest]

  # Если наибольший узел не является текущим, меняем их местами
  if largest != i
    array[i], array[largest] = array[largest], array[i]
    heapify(array, n, largest)
  end
end

# Пример использования

array = [4, 10, 3, 5, 1]
puts "Оригинальный массив: #{array}"
sorted_array = heap_sort(array)
puts "Сортированный массив: #{sorted_array}"
