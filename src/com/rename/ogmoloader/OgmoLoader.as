package com.rename.ogmoloader
{
	import com.rename.ogmoloader.IOgmoNodeHandler;
    import flash.utils.Dictionary;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Tilemap;
    import net.flashpunk.masks.Grid;
    
    /**
     * Automatic Ogmo editor loader for Flashpunk.
     * @author Jacob Albano
     */
    public class OgmoLoader
    {
        public function OgmoLoader()
        {
            types = new Dictionary();
            tilemaps = new Dictionary();
            grids = new Dictionary();
        }
        
        /**
         * Create an array of entities from an Ogmo level file.
         * @param    oel The XML document representing your oel.
         * @param    autoLayer If each entity's layer should be set based on its order in the oel. Only values of 0 will be overwritten.
         * @return The list of entities.
         */
        public function buildLevelAsArray(oel:XML, autoLayer:Boolean = true):Array
        {
            var result:Array = [];
            var layerNodes:Array = [];
            var layerIndex:Dictionary = new Dictionary();
            var layerCount:int = 0;
            
            function add(e:Entity):void {
                if (e == null) return;
                if (autoLayer)
                    e.layer = e.layer || layerCount;
                
                result.push(e);
            }
            
            for each (var layerNode:XML in oel.children())
            {
                layerNodes.push(layerNode);
            }
            
            for each (var layer:XML in layerNodes.reverse())
            {
                layerIndex[layer.name()] = ++layerCount;
                
                if (layer.@tileset != undefined)
                {
                    add(tilemapLayer(oel, layer));
                }
                else if (layer.@exportMode != undefined)
                {
                    add(gridLayer(oel, layer));
                }
                else
                {
                    for each (var entity:XML in layer.children())
                    {
                        var type:Class = types[entity.name()];
                        if (!type)
                        {
                            trace("No entity type registered for", entity.name());
                            continue;
                        }
                        
                        var ent:Entity = new type();
                        setProperties(ent, entity);
                        
                        if (ent is com.rename.ogmoloader.IOgmoNodeHandler)
                            com.rename.ogmoloader.IOgmoNodeHandler(ent).nodeHandler(entity);
                        
                        add(ent);
                    }
                }
            }
            
            return result;
        }
        
        /**
         * Register a class with the level builder.
         * @param    type The Entity class to register.
         * @param    name The name of the class as it appears in Ogmo. Only required if the actionscript class has a different name.
         */
        public function registerEntityType(type:Class, name:String = null):void
        {
            name = name || getName(type);
            types[name] = type;
        }
        
        /**
         * Register the information needed to create a tilemap.
         * The entity created will have its name property set to the layer's name, so you can find it with getInstance()
         * @param    tilemapName The name of the tilemap defined in your Ogmo project.
         * @param    source The BitmapData or Class to use as a source image.
         * @param    tileWidth The width of a tile in the resulting Tilemap.
         * @param    tileHeight The height of a tile in the resulting Tilemap.
         */
        public function registerTilemapType(tilemapName:String, source:*, tileWidth:int, tileHeight:int):void
        {
            tilemaps[tilemapName] = {
                source : source,
                tileWidth : tileWidth,
                tileHeight : tileHeight
            };
        }
        
        /**
         * Register the information needed to create a grid.
         * @param    layerName The name of the Ogmo layer to build from.
         * @param    collisionType The collision type for the entity that owns this mask to use.
         * @param    cellWidth The width of a cell in the resulting Grid.
         * @param    cellHeight The height of a cell in the resulting Grid.
         */
        public function registerGridType(layerName:String, collisionType:String, cellWidth:int, cellHeight:int):void
        {
            grids[layerName] = {
                collisionType : collisionType,
                cellWidth : cellWidth,
                cellHeight : cellHeight
            };
        }
        
        private function setProperties(e:Entity, x:XML):void 
        {
            for each (var att:XML in x.attributes()) 
            {
                var name:String = att.name();
            
                var value:* = att;
                if (att == "True" || att == "False")
                    value = (att == "True");
                    
                if (e.hasOwnProperty(name))
                    e[name] = value;
            }
        }
        
        private function getName(type:Class):String
        {
            return String(type).slice(7, -1);
        }
        
        private function gridLayer(oel:XML, layer:XML):Entity 
        {
            var def:Object = grids[layer.name()];
            if (def == null)
                return null;
                
            var text:String = String(layer.text());
            
            var tileWidth:int = def.cellWidth;
            var tileHeight:int = def.cellHeight;
            
            var grid:Grid = null;
            
            var mode:String = String(layer.@exportMode);
            switch (mode) 
            {
                case "Bitstring":
                case "TrimmedBitstring":
                    grid = gridLoadBitstring(oel, layer, mode, tileWidth, tileHeight);
                    break;
                case "Rectangles":
                case "GridRectangles":
                    grid = gridLoadRectangles(oel, layer, mode, tileWidth, tileHeight);
                    break;
                default:
            }
            
            var e:Entity = new Entity(0, 0, null, grid);
            e.type = def.collisionType;
            
            return e;
        }
        
        public function gridLoadBitstring(oel:XML, layer:XML, mode:String, tileWidth:int, tileHeight:int):Grid 
        {
            var width:int = int(oel.@width);
            var height:int = int(oel.@height);
            var text:String = layer.text();
            
            var grid:Grid = new Grid(width * tileWidth, height * tileHeight, tileWidth, tileHeight);
            grid.loadFromString(text, "", "\n");
            
            return grid;
        }
        
        private function gridLoadRectangles(oel:XML, layer:XML, mode:String, tileWidth:int, tileHeight:int):Grid 
        {
            var width:int = int(oel.@width);
            var height:int = int(oel.@height);
            
            var grid:Grid = new Grid(width, height, tileWidth, tileHeight);
            
            if (mode == "Rectangles")
                grid.usePositions = true;
            
            for each (var rect:XML in layer.rect)
                grid.setRect(rect.@x, rect.@y, rect.@w, rect.@h, true);
            
            return grid;
        }
        
        private function tilemapLayer(oel:XML, layer:XML):Entity
        {
            var def:Object = tilemaps[String(layer.@tileset)];
            if (def == null)
                return null;
                
            var tileWidth:int = def.tileWidth, tileHeight:int = def.tileHeight;
            var tilemap:Tilemap = null;
            
            var mode:String = String(layer.@exportMode);
            switch (mode) 
            {
                case "CSV":
                case "TrimmedCSV":
                    tilemap = tilemapLoadCSV(oel, layer, mode, def.source, tileWidth, tileHeight);    
                    break;
                case "XML":
                case "XMLCoords":
                    tilemap = tilemapLoadXML(oel, layer, mode, def.source, tileWidth, tileHeight);
                    break;
                default:
            }
            
            var e:Entity = new Entity(0, 0, tilemap);
            e.name = layer.name();
			e.layer = 1;
            
            return e;
        }
        
        private function tilemapLoadCSV(oel:XML, layer:XML, mode:String, source:*, tileWidth:int, tileHeight:int):Tilemap 
        {
            var width:int = int(oel.@width);
            var height:int = int(oel.@height);
            var text:String = layer.text();
            
            var tilemap:Tilemap = new Tilemap(source, width, height, tileWidth, tileHeight);
            
            var r:Array = text.split("\n");
            for (var i:int = 0; i < r.length; i++) 
            {
                var c:Array = r[i].split(",");
                for (var j:int = 0; j < c.length; j++)
                {
                    var id:int = int(c[j]);
                    if (id >= 0)
                        tilemap.setTile(j, i, id);
                }
            }
            
            return tilemap;
        }
        
        private function tilemapLoadXML(oel:XML, layer:XML, mode:String, source:*, tileWidth:int, tileHeight:int):Tilemap 
        {
            var width:int = int(oel.@width);
            var height:int = int(oel.@height);
            
            var tilemap:Tilemap = new Tilemap(source, width, height, tileWidth, tileHeight);
            
            if (mode == "XMLCoords")
            {
                for each (var node:XML in layer.children())
                {
                    var id:int = tilemap.getIndex(node.@tx, node.@ty)
                    tilemap.setTile(node.@x, node.@y, id);
                }
            }
            else
            {
                for each (node in layer.children())
                {
                    tilemap.setTile(node.@x, node.@y, node.@id);
                }
            }
            
            
            return tilemap;
        }
        
        private var types:Dictionary, tilemaps:Dictionary, grids:Dictionary;
    }

}