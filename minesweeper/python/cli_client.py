from Minesweeper import Minesweeper

def print_commands():
    print('Command Usage:')
    print('---Reveal a cell---')
    print('r <row> <column>')
    print('---Mass reveal a cell---')
    print('lr <row> <column>')
    print('---Mark/unmark a mine---')
    print('m <row> <column>')
    print('---Start a new game---')
    print('s')

def process_input(input):
    split_input = input.split()
    try:
        if len(split_input) == 1:
            command = split_input[0]
            if command == 'h':
                print_commands()
            elif command == 's':
                minesweeper.new_game()
            else:
                raise Error('Invalid Command')
        elif len(split_input) == 3:
            command = split_input[0]
            row = int(split_input[1])
            col = int(split_input[2])
            if command == 'r':
                minesweeper.reveal({'row':row,'col':col})
            elif command == 'lr':
                minesweeper.mass_reveal({'row':row,'col':col})
            elif command == 'm':
                minesweeper.toggle_mine_marking({'row':row,'col':col})
            else:
                raise Error('Invalid Command')
        else:
            raise Error('Command should have either 1 or 3 arguments')
    except:
        print("Didn't understand that command")
        print_commands()


def pretty_print_board(board):
    horizontal_padding = ' '
    column_label = horizontal_padding
    for i in range(len(board[0])):
        column_label += horizontal_padding
        column_label += str(i)

    print(column_label)

    for vertical_index, row in enumerate(board):
        result = ''
        result += str(vertical_index)
        for col in row:
            result += horizontal_padding
            result += str(col)
        print(result)


minesweeper = Minesweeper()
minesweeper.new_game()
print('Welcome to Minesweeper')
print_commands()
while minesweeper.status() == 'Playing':
    print('Game Status:', minesweeper.status())
    print('Mines left:', minesweeper.mines_remaining())
    print('Time Elapsed:', minesweeper.time_elapsed())
    pretty_print_board(minesweeper.view_board())
    process_input(input())

if minesweeper.status() == 'Lose':
    pretty_print_board(minesweeper.view_board())
    print('Mines left:', minesweeper.mines_remaining())
    print('Time Elapsed:', minesweeper.time_elapsed())
    print('BOOM')

if minesweeper.status() == 'Win':
    pretty_print_board(minesweeper.view_board())
    print('You beat the game in', minesweeper.time_elapsed(), 'seconds')


