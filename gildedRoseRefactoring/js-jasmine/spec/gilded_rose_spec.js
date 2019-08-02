var {Shop, Item} = require('../src/gilded_rose.js');
describe("Gilded Rose", function() {

  it("should foo", function() {
    const gildedRose = new Shop([ new Item("foo", 0, 0) ]);
    const items = gildedRose.updateQuality();
    expect(items[0].name).toEqual("foo");
  });

  it("should degrade a Normal Item quality by 1 a day", function() {
    const gildedRose = new Shop([ new Item("Normal Item", 10, 10) ]);
    const items = gildedRose.updateQuality();
    expect(items[0].name).toEqual("Normal Item");
    expect(items[0].quality).toEqual(9);
    expect(items[0].sellIn).toEqual(9);
  });

});
