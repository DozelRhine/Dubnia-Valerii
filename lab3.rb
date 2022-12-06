class TaslSolution
    def simulate(layer_thickness, free_path, scatter_parametr, absorption_probability, size, incidence_angle)
        forward_exit = 0        # частицы, что вышли вперед
        back_exit = 0           # частицы, что вышли назад
        absorbed = 0            # пошлощенные частицы

        (1..size).each do
            x_prev = 0                                      # координата точки взаимодействия с шаром на прошлом шаге
            angle = incidence_angle                         # угол соприкосновения частиц с поверхностью шара
            
            while true do
                if rand() < absorption_probability          # моделирование поглощение частицы
                    absorbed += 1
                    break
                end
                
                # моделирванеи рассеяния частицы ================================================
                w = rand()**(1 / (scatter_parametr + 1))                            # Омега
                fi = Math.sin(2 * Math::PI * rand())                                # Фи
                direction = angle * w - Math.sqrt((1 - angle**2) * (1 - w**2)) * fi # направление
                #================================================================================

                l = -Math.log(rand()) / free_path           # длинна свободного пробега частицы; #free_path - среднее значение
                x = x_prev + l * angle                      # координата точки взаимодействия с шаром
                
                if x < 0                                    # условие вылета частички "назад"
                    back_exit += 1
                    break
                end

                if x > layer_thickness                      # условие вылета частички "вперед"
                    forward_exit += 1
                    break
                end
            
                x_prev = x
                angle = direction       
            end
        end

        round_num = 5
        res = Hash.new

        res.store("forward", (forward_exit.to_f / size.to_f).round(round_num))
        res.store("back", (back_exit.to_f / size.to_f).round(round_num))
        res.store("absorbed", (absorbed.to_f / size.to_f).round(round_num))

        res.store("S_forward", Math.sqrt(res["forward"] * (1 - res["forward"]) / size.to_f).round(round_num + 1))
        res.store("S_back", Math.sqrt(res["back"] * (1 - res["back"]) / size.to_f).round(round_num + 1))
        res.store("S_absorbed", Math.sqrt(res["absorbed"] * (1 - res["absorbed"]) / size.to_f).round(round_num + 1))

        return res
    end

    def execute
        system("cls")

        angle = 90.0
        layer_thickness = 10.0
        free_path = 5.0
        absorption_probability = 0.0
        scatter_parametr = 1.0
        size = 100000

         puts "Введіть кут падіння: "
         angle = gets.chomp.to_f
        incidence_angle = Math.cos(Math::PI * angle / 180)

         puts "Введіть товщину шару: "
         layer_thickness = gets.chomp.to_f

         puts "Введіть середню довжину вільного пробігу часток: "
         free_path = gets.chomp.to_f
        if free_path > 0
            free_path = 1 / free_path
        else 
            free_path = 1
        end

         puts "Введіть ймовірність поглинання часток: "
         absorption_probability = gets.chomp.to_f

         puts "Введіть модельний параметр розсіювання: "
         scatter_parametr = gets.chomp.to_f
        
         puts "Введіть розмір вибірки: "
         size = gets.chomp.to_i


        res = simulate(layer_thickness, free_path, scatter_parametr, absorption_probability, size, incidence_angle)

        puts "===================Результати=симуляції==================="
        printf("|| Частинки, що вилетіли \"вперед\" = %.5f\t\t||\n", res["forward"])
        printf("|| Частинки, що вилетіли \"назад\" = %.5f\t\t||\n", res["back"])
        printf("|| Поглинуті частинки = %.5f\t\t\t\t||\n", res["absorbed"])
        printf("|| Похибка для частинок, що вилетіли \"вперед\" = %.5f\t||\n", res["S_forward"])
        printf("|| Похибка для частинок, що вилетіли \"назад\" = %.5f\t||\n", res["S_back"])
        printf("|| Похибка для поглинутих частинок = %.5f\t\t||\n", res["S_absorbed"])
        puts "=========================================================="
    end
end

sol = TaslSolution.new
sol.execute