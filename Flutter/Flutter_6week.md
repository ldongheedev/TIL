void main() {
  var size = 70;
  for(var i = 0; i < size; i++){
    printSharp(size, i);
  }
}

void printSharp(int size, int y){
  var result = "";
  for(var x = 0;  x < size; x++){
    var condition = 
      x == y ||
      size - 1 - x == y;
    if(condition){
      result += "#";
    }else {
      result += '.';
    }
  }
  print(result);

===========================

void main() {
  int n = 40;

  for (int i = 0; i < n; i++) {
    String line = '';
    for (int j = 0; j < n; j++) {
      if (i == j || i + j == n - 1) {
        line += '#';
      } else {
        line += '.';
      }
    }
    print(line);
  }
}

=========================================

/*void main() {
  int count = 5;

  for (int i = 0; i < count; i++) {
    String line = '';
    for (int k = 0; k < count; k++) {
      for (int j = 0; j < count * 2 - 1; j++) {
        if (j == i || j == (count * 2 - 2 - i)) {
          line += '#';
        } else {
          line += ' ';
        }
      }
      line += ' '; 
    }
    print(line);
  }
}
*/

void main() {
  int count = 1;  

  for (int i = 0; i < count; i++) {
    String line = '';
    for (int k = 0; k < count; k++) {
      for (int j = 0; j < count * 2 - 1; j++) {
        if (j == count - 1 - i || j == count - 1 + i) {
          line += '#';
        } else {
          line += ' ';
        }
      }
      line += ' ';
    }
    print(line);
  }
}
