from Minesweeper import Minesweeper

def process_input(input):
    split_input = input.split()
    command = split_input[0]
    row = int(split_input[1])
    col = int(split_input[2])
    if command == 'h':
        print('Command Usage:')
        print('---Reveal a cell---')
        print('r <row> <column>')
        print('---Mass reveal a cell---')
        print('lr <row> <column>')
        print('---Mark/unmark a mine---')
        print('m <row> <column>')
        print('---Start a new game---')
        print('s')
    elif command == 'r':
        minesweeper.reveal({'row':row,'col':col})
    elif command == 'lr':
        minesweeper.mass_reveal({'row':row,'col':col})
    elif command == 'm':
        minesweeper.toggle_mine_marking({'row':row,'col':col})
    elif command == 's':
        minesweeper.new_game()
    else:
        print("Didn't understand that command")
        print('Command Usage:')
        print('---Reveal a cell---')
        print('r <row> <column>')
        print('---Mass reveal a cell---')
        print('m <row> <column>')
        print('---Toggle mine marking---')
        print('t <row> <column>')
        print('---Start a new game---')
        print('s')


def pretty_print_board(board):
    for row in board:
        result = ''
        for col in row:
            result += str(col)
        print(result)


minesweeper = Minesweeper()
minesweeper.new_game()
print('Welcome to Minesweeper')
print('type h for help')
while minesweeper.status() == 'Playing':
    print('Game Status:', minesweeper.status())
    print('Mines left:', minesweeper.mines_remaining())
    print('Time Elapsed:', minesweeper.time_elapsed())
    pretty_print_board(minesweeper.view_board())
    process_input(input())

if minesweeper.status() == 'Lose':
    pretty_print_board(minesweeper.view_board())
    print('BOOM')

if minesweeper.status() == 'Win':
    pretty_print_board(minesweeper.view_board())
    print('You beat the game in', minesweeper.time_elapsed(), 'seconds')


