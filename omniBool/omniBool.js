// thought process: thought it was some special primitive value like empty string or empty object, ruled it out
// thought about ==, tried to overload Boolean's equality comparison, but it doesn't exist like Python
// tried some Boolean() prototyping
// learnt about valueOf being used for comparison!
// tried some || && precedence 
// suddenly thought about generators and iterators
// putting valueOf and generators together == Schrodingers Boolean!

let omniBool = {
  // generator IIFE
  it: (function* () {
    yield true;
    yield false;
  })(),
  valueOf: function() {
    return this.it.next().value;
  }
}

console.log(omniBool == true && omniBool == false); // a commenter said that === 'has not been done', seems like can't even overload Boolean()?
