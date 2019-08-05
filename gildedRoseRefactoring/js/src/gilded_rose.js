class Item {
  constructor(name, sellIn, quality){
    this.name = name;
    this.sellIn = sellIn;
    this.quality = quality;
  }
}

class Shop {
  constructor(items=[]){
    this.items = items;
  }
  updateQuality() {
    for (var i = 0; i < this.items.length; i++) {
      const decreaseSellIn = () => {
        this.items[i].sellIn -= 1;
      }

      const increaseQualityByOneToMaxOf50 = () => {
        if (this.items[i].quality < 50) {
          this.items[i].quality = this.items[i].quality + 1;
        }
      }
      
      if (this.items[i].name === 'Sulfuras, Hand of Ragnaros') {
        // do nothing
      } else if (this.items[i].name === 'Aged Brie') {
        decreaseSellIn();
        increaseQualityByOneToMaxOf50();
        if (this.items[i].sellIn < 0) {
          increaseQualityByOneToMaxOf50();
        }
      } else if (this.items[i].name === 'Backstage passes to a TAFKAL80ETC concert') {
        decreaseSellIn();
        increaseQualityByOneToMaxOf50();
        if (this.items[i].sellIn < 11) {
          increaseQualityByOneToMaxOf50();
        }
        if (this.items[i].sellIn < 6) {
          increaseQualityByOneToMaxOf50();
        }
        if (this.items[i].sellIn < 0) {
          this.items[i].quality = this.items[i].quality - this.items[i].quality;
        }
      } else {
        decreaseSellIn();
        if (this.items[i].quality > 0) {
          if (this.items[i].name != 'Sulfuras, Hand of Ragnaros') {
            this.items[i].quality = this.items[i].quality - 1;
          }
        }
        if (this.items[i].sellIn < 0) {
          if (this.items[i].quality > 0) {
            this.items[i].quality = this.items[i].quality - 1;
          }
        }
      }
    }

    return this.items;
  }
}
module.exports = {
  Item,
  Shop
}
