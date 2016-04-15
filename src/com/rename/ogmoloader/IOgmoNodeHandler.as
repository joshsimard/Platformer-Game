package com.rename.ogmoloader  
{
    /**
     * Entities implementing this interface will be passed their source XML node when constructed.
     */
    public interface IOgmoNodeHandler 
    {
        function nodeHandler(node:XML):void;
    }
}