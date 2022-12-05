MATRIX_ROW = 9          
MATRIX_COLUMN = 9       
SUB_MATRIX = 3 # 3*3 box

#Function checks whether the given matrix is a valid sudoku or not. 
def is_conditions_meet (matrix, row, column, inumber)

    #Check if this row contains the insertig number
    for i in 0..MATRIX_ROW - 1 do 
        if matrix[row][i] == inumber
            return false
        end
    end

    #Check if this column contains the insertig number
    for i in 0..MATRIX_COLUMN - 1 do
        if matrix[i][column] == inumber
            return false
        end
    end

    # Check if we find the same num
    # in the particular 3*3 matrix
    startRow = row - row % SUB_MATRIX
    startCol = column - column % SUB_MATRIX
    for i in 0..SUB_MATRIX - 1 do
        for j in 0..SUB_MATRIX - 1 do
            if (matrix[i + startRow][j + startCol] == inumber)
                return false
            end
        end
    end

    # all condition are meet :)
    true
end

def solve_sudoky(matrix, row, column)

    #if we have reached the 8th row and 9th column
    # Exit condition
    if (row == MATRIX_ROW-1 && column == MATRIX_COLUMN)
        return true
    end

    if column == MATRIX_COLUMN 
        column = 0
        row += 1
    end

    if (matrix[row][column] != 0)
        return solve_sudoky(matrix, row, column + 1)
    end

    for digit in 1..9 do
        if (is_conditions_meet(matrix, row, column, digit))
            matrix[row][column] = digit

            if (solve_sudoky(matrix, row, column + 1))
                return true
            end
        end

        # removing the assigned num , since our
        # assumption was wrong , and we go for next
        # assumption with diff num value
        matrix[row][column] = 0
    end
    
    # not found assumption
    false
end

def print_matrix(matrix)
    for i in 0..MATRIX_ROW - 1 do
        for j in 0..MATRIX_COLUMN - 1 do
            print "#{matrix[i][j]} "
        end
        puts 
    end
    puts
end


grid = [[ 5, 3, 0, 0, 7, 0, 0, 0, 0 ],
        [ 6, 0, 0, 1, 9, 5, 0, 0, 0 ],
        [ 0, 9, 8, 0, 0, 0, 0, 6, 0 ],
        [ 8, 0, 0, 0, 6, 0, 0, 0, 3 ],
        [ 4, 0, 0, 8, 0, 3, 0, 0, 1 ],
        [ 7, 0, 0, 0, 2, 0, 0, 0, 6 ],
        [ 0, 6, 0, 0, 0, 0, 2, 8, 0 ],
        [ 0, 0, 0, 4, 1, 9, 0, 0, 5 ],
        [ 0, 0, 0, 0, 8, 0, 0, 7, 9 ] ]

print_matrix(grid)
puts
solve_sudoky(grid, 0, 0)
print_matrix(grid)

