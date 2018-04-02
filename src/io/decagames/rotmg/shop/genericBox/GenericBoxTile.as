﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.genericBox.GenericBoxTile

package io.decagames.rotmg.shop.genericBox
{
import io.decagames.rotmg.shop.ShopBoxTag;
import io.decagames.rotmg.shop.ShopBuyButton;
import io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.gird.UIGridElement;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.spinner.FixedNumbersSpinner;
import io.decagames.rotmg.ui.texture.TextureParser;

public class GenericBoxTile extends UIGridElement
    {

        protected var background:SliceScalingBitmap;
        protected var backgroundTitle:SliceScalingBitmap;
        protected var buyButtonBitmapBackground:String;
        protected var backgroundButton:SliceScalingBitmap;
        protected var titleLabel:UILabel;
        protected var _buyButton:ShopBuyButton;
        protected var _infoButton:SliceScalingButton;
        protected var tags:Vector.<ShopBoxTag>;
        protected var _spinner:FixedNumbersSpinner;
        protected var _boxInfo:GenericBoxInfo;
        protected var _endTimeLabel:UILabel;
        protected var originalPriceLabel:SalePriceTag;
        protected var _isPopup:Boolean;

        public function GenericBoxTile(_arg_1:GenericBoxInfo, _arg_2:Boolean=false)
        {
            this._boxInfo = _arg_1;
            this._isPopup = _arg_2;
            this.background = TextureParser.instance.getSliceScalingBitmap("UI", "shop_box_background", 10);
            if (!_arg_2)
            {
                this.backgroundTitle = TextureParser.instance.getSliceScalingBitmap("UI", "shop_title_background", 10);
                this._infoButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "tab_info_button"));
            };
            if (this.buyButtonBitmapBackground)
            {
                this.backgroundButton = TextureParser.instance.getSliceScalingBitmap("UI", this.buyButtonBitmapBackground, 10);
            };
            this._spinner = new FixedNumbersSpinner(TextureParser.instance.getSliceScalingBitmap("UI", "spinner_up_arrow"), 0, new <int>[1, 2, 3, 5, 10], "x");
            this._spinner.y = 131;
            this._spinner.x = 43;
            this.titleLabel = new UILabel();
            this.titleLabel.text = _arg_1.title;
            DefaultLabelFormat.shopBoxTitle(this.titleLabel);
            if (_arg_1.isOnSale())
            {
                this._buyButton = new ShopBuyButton(_arg_1.saleAmount, _arg_1.saleCurrency);
            }
            else
            {
                this._buyButton = new ShopBuyButton(_arg_1.priceAmount, _arg_1.priceCurrency);
            };
            this._buyButton.width = 95;
            if (_arg_1.unitsLeft == 0)
            {
                this._buyButton.disabled = true;
            };
            this.tags = new Vector.<ShopBoxTag>(0);
            addChild(this.background);
            this.createBoxBackground();
            if (this.backgroundTitle)
            {
                addChild(this.backgroundTitle);
            };
            if (this.backgroundButton)
            {
                addChild(this.backgroundButton);
            };
            addChild(this.titleLabel);
            if (_arg_1.isOnSale())
            {
                this.originalPriceLabel = new SalePriceTag(_arg_1.priceAmount, _arg_1.priceCurrency);
                addChild(this.originalPriceLabel);
            };
            addChild(this._buyButton);
            addChild(this._spinner);
            if (!_arg_2)
            {
                addChild(this._infoButton);
            };
            if (_arg_1.isNew())
            {
                this.addTag(new ShopBoxTag(ShopBoxTag.BLUE_TAG, "NEW"));
            };
            this._endTimeLabel = new UILabel();
            this._endTimeLabel.y = 28;
            addChild(this._endTimeLabel);
            DefaultLabelFormat.mysteryBoxEndsIn(this._endTimeLabel);
            this.updateTimeEndString();
        }

        protected function createBoxBackground():void
        {
        }

        protected function updateTimeEndString():void
        {
            var _local_1:String = this.boxInfo.getEndTimeString();
            if (_local_1)
            {
                this._endTimeLabel.text = _local_1;
                this._endTimeLabel.x = ((this.background.width - this._endTimeLabel.width) / 2);
            };
        }

        override public function get height():Number
        {
            return (this.background.height);
        }

        override public function resize(_arg_1:int, _arg_2:int=-1):void
        {
            this.background.width = _arg_1;
            this.backgroundTitle.width = _arg_1;
            this.backgroundButton.width = _arg_1;
            this.background.height = 184;
            this.backgroundTitle.y = 2;
            this.titleLabel.x = Math.round(((_arg_1 - this.titleLabel.textWidth) / 2));
            this.titleLabel.y = 6;
            if (this.backgroundButton)
            {
                this.backgroundButton.y = 133;
                this._buyButton.y = (this.backgroundButton.y + 4);
                this._buyButton.x = (_arg_1 - 110);
            }
            else
            {
                this._buyButton.y = 137;
                this._buyButton.x = (_arg_1 - 110);
            };
            if (this._infoButton)
            {
                this._infoButton.x = 130;
                this._infoButton.y = 45;
            };
            this.updateTimeEndString();
            this.updateSaleLabel();
        }

        protected function updateSaleLabel():void
        {
            if (this.originalPriceLabel)
            {
                this.originalPriceLabel.y = (this._buyButton.y - 23);
                this.originalPriceLabel.x = (((this._buyButton.x + this._buyButton.width) - this.originalPriceLabel.width) - 13);
            };
        }

        override public function update():void
        {
            this.updateTimeEndString();
        }

        public function addTag(_arg_1:ShopBoxTag):void
        {
            addChild(_arg_1);
            _arg_1.y = (33 + (this.tags.length * 20));
            _arg_1.x = -5;
            this.tags.push(_arg_1);
        }

        public function get spinner():FixedNumbersSpinner
        {
            return (this._spinner);
        }

        public function get buyButton():ShopBuyButton
        {
            return (this._buyButton);
        }

        public function get boxInfo():GenericBoxInfo
        {
            return (this._boxInfo);
        }

        override public function dispose():void
        {
            var _local_1:ShopBoxTag;
            this.background.dispose();
            if (this.backgroundTitle)
            {
                this.backgroundTitle.dispose();
            };
            this.backgroundButton.dispose();
            this._buyButton.dispose();
            if (this._infoButton)
            {
                this._infoButton.dispose();
            };
            this._spinner.dispose();
            if (this.originalPriceLabel)
            {
                this.originalPriceLabel.dispose();
            };
            for each (_local_1 in this.tags)
            {
                _local_1.dispose();
            };
            this.tags = null;
            super.dispose();
        }

        public function get infoButton():SliceScalingButton
        {
            return (this._infoButton);
        }

        public function get isPopup():Boolean
        {
            return (this._isPopup);
        }


    }
}//package io.decagames.rotmg.shop.genericBox

