describe GildedRose do
  describe "#update_quality" do
    context "Normal" do
      context "when the sell_in value has not yet been reached" do
        it "lowers the quality by 1" do
          item = Item.new("Normal Item", 5, 10)
          gilded_rose = GildedRose.new([item])

          gilded_rose.update_quality

          expect(item.quality).to eq 9
        end

        it "decreases the sell_in value by 1" do
          item = Item.new("Normal Item", 5, 10)
          gilded_rose = GildedRose.new([item])

          gilded_rose.update_quality

          expect(item.sell_in).to eq 4
        end
      end

      context "when the sell_in value has been reached" do
        it "decreases the quality by 2" do
          sell_in_value_reached = 0
          item = Item.new("Normal Item", sell_in_value_reached, 10)
          gilded_rose = GildedRose.new([item])

          gilded_rose.update_quality

          expect(item.quality).to eq 8
        end
      end
    end

    context "Aged Brie" do
      it "increases the quality as the sell_in date approaches" do
        sell_in_value_reached = 0
        item = Item.new("Aged Brie", sell_in_value_reached, 10)
        gilded_rose = GildedRose.new([item])

        gilded_rose.update_quality

        expect(item.quality).to eq 12
      end

      it "cannot increase the quality of Aged Brie to more than 50" do
        item = Item.new("Aged Brie", 5, 50)
        gilded_rose = GildedRose.new([item])

        gilded_rose.update_quality

        expect(item.quality).to eq 50
      end
    end

    context "Sulfuras" do
      it "does not change the quality" do
        item = Item.new("Sulfuras, Hand of Ragnaros", 5, 80)
        gilded_rose = GildedRose.new([item])

        gilded_rose.update_quality

        expect(item.quality).to eq 80
      end

      it "does not change the sell in value" do
        item = Item.new("Sulfuras, Hand of Ragnaros", 5, 80)
        gilded_rose = GildedRose.new([item])

        gilded_rose.update_quality

        expect(item.sell_in).to eq 5
      end
    end

    context "Backstage Passes" do
      it "increases the quality by 1 as the sell_in value approaches" do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 1)
        gilded_rose = GildedRose.new([item])

        gilded_rose.update_quality

        expect(item.quality).to eq 2
      end

      context "when there are 10 days left until sell_in value" do
        it "increases the quality by 2" do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 1)
          gilded_rose = GildedRose.new([item])

          gilded_rose.update_quality

          expect(item.quality).to eq 3
        end
      end

      context "when there are 5 days left until sell_in value" do
        it "increases the quality by 3" do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 1)
          gilded_rose = GildedRose.new([item])

          gilded_rose.update_quality

          expect(item.quality).to eq 4
        end
      end

      it "cannot increase the quality of Backstage Passes to more than 50" do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 50)
        gilded_rose = GildedRose.new([item])

        gilded_rose.update_quality

        expect(item.quality).to eq 50
      end

      it "drops quality to zero when the sell_in value is below 0" do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 5)
        gilded_rose = GildedRose.new([item])

        gilded_rose.update_quality

        expect(item.quality).to eq 0
      end
    end

    context "Conjured" do
      xit "before sell date" do
        item = Item.new("Conjured Mana Cake", days_remaining: 5, quality: 10)
        gilded_rose = GildedRose.new([item])

        gilded_rose.update_quality

        expect(gilded_rose).to have_attributes(days_remaining: 4, quality: 8)
      end

      xit "before sell date at zero quality" do
        item = Item.new("Conjured Mana Cake", days_remaining: 5, quality: 0)
        gilded_rose = GildedRose.new([item])

        gilded_rose.update_quality

        expect(gilded_rose).to have_attributes(days_remaining: 4, quality: 0)
      end

      xit "on sell date" do
        item = Item.new("Conjured Mana Cake", days_remaining: 0, quality: 10)
        gilded_rose = GildedRose.new([item])

        gilded_rose.update_quality

        expect(gilded_rose).to have_attributes(days_remaining: -1, quality: 6)
      end

      xit "on sell date at zero quality" do
        item = Item.new("Conjured Mana Cake", days_remaining: 0, quality: 0)
        gilded_rose = GildedRose.new([item])

        gilded_rose.update_quality

        expect(gilded_rose).to have_attributes(days_remaining: -1, quality: 0)
      end

      xit "after sell date" do
        item = Item.new("Conjured Mana Cake", days_remaining: -10, quality: 10)
        gilded_rose = GildedRose.new([item])

        gilded_rose.update_quality

        expect(gilded_rose).to have_attributes(days_remaining: -11, quality: 6)
      end

      xit "after sell date at zero quality" do
        item = Item.new("Conjured Mana Cake", days_remaining: -10, quality: 0)
        gilded_rose = GildedRose.new([item])

        gilded_rose.update_quality

        expect(gilded_rose).to have_attributes(days_remaining: -11, quality: 0)
      end
    end
  end
end
