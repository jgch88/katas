var {Shop, Item} = require('../src/gilded_rose.js');
describe("Gilded Rose", function() {

  it("should foo", function() {
    // Michael Feathers, Working with Legacy Code says
    // just focus on PRESERVING existing behaviour.
    // that includes bugs!
    // These are slightly different from TDD tests, in that
    // they are called "Characterisation Tests".
    // Only after we have Characterised the current behaviour,
    // can we show the results to the client and then decide
    // if the specs need to be changed
    //
    // Definition of Legacy code = code WITHOUT tests
    const gildedRose = new Shop([ new Item("foo", 0, 0) ]);
    const items = gildedRose.updateQuality();
    expect(items[0].name).toEqual("foo");
    expect(items[0].quality).toEqual(0);
    expect(items[0].sellIn).toEqual(-1);
  });

  it("should degrade a Normal Item quality by 1 a day", function() {
    const gildedRose = new Shop([ new Item("Normal Item", 10, 10) ]);
    const items = gildedRose.updateQuality();
    expect(items[0].name).toEqual("Normal Item");
    expect(items[0].quality).toEqual(9);
    expect(items[0].sellIn).toEqual(9);
  });

});
