import random

def line(char="="):
    print(char * 50)

ROWS = 7
COLS = 7
ELEMENTS_LIST = ["@", "#", "*", "0", "?"]

# Create a board
board = [[random.choice(ELEMENTS_LIST) for _ in range(COLS)] for _ in range(ROWS)]

def display_board(board):
    for row in board:
        print("  ".join(row))
    print()

def check_matches(board):
    matched = set()

    # Check horizontal matches
    for row in range(ROWS):
        for col in range(COLS - 2):
            if board[row][col] == board[row][col + 1] == board[row][col + 2]:
                matched.update([(row, col), (row, col + 1), (row, col + 2)])

    # Check vertical matches
    for col in range(COLS):
        for row in range(ROWS - 2):
            if board[row][col] == board[row + 1][col] == board[row + 2][col]:
                matched.update([(row, col), (row + 1, col), (row + 2, col)])

    return matched

def remove_matches(board, matched):
    for (row, col) in matched:
        board[row][col] = " "

def drop_elements(board):
    for col in range(COLS):
        empty_slots = [row for row in range(ROWS) if board[row][col] == " "]
        filled_slots = [row for row in range(ROWS) if board[row][col] != " "]

        new_col = [board[row][col] for row in filled_slots] + [" "] * len(empty_slots)

        for row in range(ROWS):
            board[row][col] = new_col[row]

def refill_board(board):
    for row in range(ROWS):
        for col in range(COLS):
            if board[row][col] == " ":
                board[row][col] = random.choice(ELEMENTS_LIST)

def swap(board, r1, c1, r2, c2):
    board[r1][c1], board[r2][c2] = board[r2][c2], board[r1][c1]

def play_game():
    global board

    while True:
        display_board(board)
        matches = check_matches(board)

        if matches:
            print(f"Matches found at: {matches}")
            remove_matches(board, matches)
            drop_elements(board)
            refill_board(board)
        else:
            print("No matches found. Swap elements to create matches.")

        line()
        user_input = input("Enter swap coordinates (row1 col1 row2 col2) or 'quit': ")
        if user_input.lower() == "quit":
            break

        try:
            r1, c1, r2, c2 = map(int, user_input.split())
            if abs(r1 - r2) + abs(c1 - c2) == 1:  # Ensure adjacent swap
                swap(board, r1, c1, r2, c2)
            else:
                print("Invalid swap. Elements must be adjacent.")
        except (ValueError, IndexError):
            print("Invalid input. Please enter valid coordinates.")

if __name__ == "__main__":
    play_game()
