class Cell {
  String _value;
  bool _revealed = false;
  bool _marked = false;

  Cell(String value) {
    this._value = value;
  }

  String display_value() {
    if (this._marked) {
      return '^';
    }

    if (!this._revealed) {
      return ' ';
    }

    if (this._value == ' ') {
      return '.';
    }

    return this._value;
  }

  void reveal() {
    this._revealed = true;
  }

  bool is_revealed() {
    return this._revealed;
  }

  bool is_marked() {
    return this._marked;
  }

  bool is_bomb() {
    return this._value == '*';
  }

  void set_display_value(String display_value) {
    this._value = display_value;
  }

  void toggle_mine_marking() {
    if (this._marked) {
      this._marked = false;
    } else {
      this._marked = true;
    }
  }

  String actual_value() {
    return this._value;
  }

  // for debugging
  toString() {
    return this._value;
  }

}
