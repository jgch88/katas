var {Shop, Item} = require('../src/gilded_rose.js');
describe("Gilded Rose Characterisation Tests", function() {

  it("should foo", () => {
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

  it("should degrade a Normal Item quality by 1 a day", () => {
    const gildedRose = new Shop([ new Item("Normal Item", 10, 10) ]);
    const items = gildedRose.updateQuality();
    expect(items[0].name).toEqual("Normal Item");
    expect(items[0].quality).toEqual(9);
    expect(items[0].sellIn).toEqual(9);
  });

  it("should increase Aged Brie quality by 1 a day", () => {
    const gildedRose = new Shop([ new Item("Aged Brie", 10, 10) ]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toEqual(11);
    expect(items[0].sellIn).toEqual(9);
  });

  it("should not change Sulfuras quality or sell in", () => {
    const gildedRose = new Shop([ new Item("Sulfuras, Hand of Ragnaros", 1, 80) ]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toEqual(80);
    expect(items[0].sellIn).toEqual(1);
  });

  it("increases backstage pass value by 1 when more than 10 days to sell in", () => {
    const gildedRose = new Shop([ new Item("Backstage passes to a TAFKAL80ETC concert", 30, 10) ])
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toEqual(11);
  });

  it("increases backstage pass value by 2 when 10 or less days to sell in", () => {
    const gildedRose = new Shop([ new Item("Backstage passes to a TAFKAL80ETC concert", 10, 10) ])
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toEqual(12);
  });

  it("increases backstage pass value by 3 when 5 or less days to sell in", () => {
    const gildedRose = new Shop([ new Item("Backstage passes to a TAFKAL80ETC concert", 5, 10) ])
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toEqual(13);
  });

  it("changes backstage pass value to 0 after sell by date is reached", () => {
    const gildedRose = new Shop([ new Item("Backstage passes to a TAFKAL80ETC concert", 0, 10) ])
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toEqual(0);
  });

  it("Aged Brie cannot increase above 50 in quality", () => {
    const gildedRose = new Shop([ new Item("Aged Brie", 10, 50) ]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toEqual(50);
  });

  it("Aged Brie quality increases faster after sell by date", () => {
    const gildedRose = new Shop([ new Item("Aged Brie", 0, 10) ]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toEqual(12);
  });

  it("decreases Normal item quality faster after sell by date", () => {
    const gildedRose = new Shop([ new Item("Normal Item", -1, 10),
      new Item("Sulfuras, Hand of Ragnaros", -1, 80), // for line 45's else branch
      new Item("Aged Brie", -1, 50), // for line 53's else branch
    ]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toEqual(8);
    expect(items[1].quality).toEqual(80);
    expect(items[2].quality).toEqual(50);
  });

  it("Backstage pass cannot increase above 50 in quality", () => {
    const gildedRose = new Shop([ new Item("Backstage passes to a TAFKAL80ETC concert", 5, 49) ])
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toEqual(50);
  });

  it("Shop creates empty list", () => {
    const gildedRose = new Shop();
    const items = gildedRose.updateQuality();
    expect(items).toEqual([]);
  });

});
