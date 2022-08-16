import std.stdio: writeln, write, readln, readf;

import std.string: strip;

void main() {
    char[3][3] board = ' ';

    bool player_one_move = true;

    bool game_over = main_menu();

    while (!game_over) {
        print(board);

        int x = 0;
        read_user_input(x, "X");

        int y = 0;
        read_user_input(y, "Y");

        if (board[y][x] == ' ') {
            if (player_one_move) {
                board[y][x] = 'X';
            } else {
                board[y][x] = 'O';
            }

            player_one_move = !player_one_move;
        } else {
            writeln("**************************************");   
            writeln("Position ", x, ", ", y, " is occupied! Try again.");   
            writeln("**************************************");   
        }

        check(board, game_over);
    }

    print(board);
    if (player_one_move) {
        writeln("Player O won!");
    } else {
        writeln("Player X won!");
    }

    writeln("Thanks for playing!");
}

bool main_menu() {
    writeln("Hello! Welcome to tic tac toe");
    writeln("1 - Play");
    writeln("2 - Exit");

    string line = strip(readln());

    if (line == "play" || line == "Play" || line == "1" || line == "p") {
        return false;
    }

    return true;
}

void read_user_input(ref int value, string axis) {
    write(axis, ":_");
    readf(" %s", value);
}

void print(char[3][3] array) {
    writeln();
    writeln();

    for (int i = 0; i < array.length; i++) {
        if (i == 0) {
            write("         ", i, "   ");
        } else {
            write("  ", i, "   ");
        }
        
    }

    writeln();

    writeln("_____________________________");
    for (int i = 0; i < array.length; i++) {
        write(i, "   ");

        for (int j = 0; j < array[i].length; j++) {
            write("  |  ", array[i][j]);
        }

        writeln();
        writeln("_____________________________");
    }

    writeln();
    writeln();
}

void check(char[3][3] array, ref bool game_over) {
    for (int i = 0; i < array.length; i++) {

        if (check_neighbors_right(array, i) || check_neighbors_down(array, i)) {
            game_over = true;
        }
    }

    if (check_neighbors_diagonal(array)) {
        game_over = true;
    }
}

bool check_neighbors_right(char[3][3] array, int init_pos) {
    char neighbor_right = array[init_pos][1];

    if (array[init_pos][0] != ' ' && array[init_pos][0] == neighbor_right && neighbor_right == array[init_pos][2]) {
        return true;
    }

    return false;
}

bool check_neighbors_down(char[3][3] array, int init_pos) {
    char neighbor_down = array[1][init_pos];

    if (array[0][init_pos] != ' ' && array[0][init_pos] == neighbor_down && neighbor_down == array[2][init_pos]) {
        return true;
    }

    return false;
}

bool check_neighbors_diagonal(char[3][3] array) {
    char neighbor_diagonal = array[1][1];

    if (array[0][0] != ' ' && array[0][0] == neighbor_diagonal && neighbor_diagonal == array[2][2]) {
        return true;
    }

    if (array[0][2] != ' ' && array[0][2] == neighbor_diagonal && neighbor_diagonal == array[2][0]) {
        return true;
    }

    return false;
}