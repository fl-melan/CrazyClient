﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.outgoing.PlayerText

package kabam.rotmg.messaging.impl.outgoing
{
import flash.utils.IDataOutput;

public class PlayerText extends OutgoingMessage
    {

        public var text_:String = new String();

        public function PlayerText(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function writeToOutput(_arg_1:IDataOutput):void
        {
            _arg_1.writeUTF(this.text_);
        }

        override public function toString():String
        {
            return (formatToString("PLAYERTEXT", "text_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

