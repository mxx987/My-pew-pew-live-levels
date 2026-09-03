meshes = {
  {
    vertexes = {
{0,0,0}, {1500,0,0}, {1500,1500,0}, {0,1500,0},
{0,0,100}, {1500,0,100}, {1500,1500,100}, {0,1500,100},
{0,0,50}, {1500,0,50}, {1500,1500,50}, {0,1500,50},
{0,0,100}, {1550,0,100}, {1550,1550,100}, {0,1550,100},
{0,0,200}, {1550,0,200}, {1550,1550,200}, {0,1550,200},
{0,0,250}, {1600,0,250}, {1600,1600,250}, {0,1600,250},
{0,0,300}, {1600,0,300}, {1600,1600,300}, {0,1600,300}
},
    colors = {
0xffffffff, 0xffff00ff, 0xffff00ff, 0xffff00ff,
0xffffffff, 0xffff00ff, 0xffff00ff, 0xffff00ff,
0xffffffff,0xffffffff,0xffffffff,0xffffffff,
0xffffffff,0xffffffff,0xffffffff,0xffffffff,
0xffffffff,0xffffffff,0xffffffff,0xffffffff,
0xffffffff, 0xffff00ff, 0xffff00ff, 0xffff00ff,
0xffffffff, 0xffff00ff, 0xffff00ff, 0xffff00ff
},
    segments = {
{0,1,2,3,0}, -- first floor
{0,4}, {1,5}, {2,6}, {3,7},
{4,5,6,7,4},

{8,9,10,11,8}, -- half step

{12,13,14,15,12}, -- second floor
{12,16}, {13,17}, {14,18}, {15,19},
{16,17,18,19,16},

{20,21,22,23,20}, -- final floor
{20,24}, {21,25}, {22,26}, {23,27},
{24,25,26,27,28}
}
  }
}