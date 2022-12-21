///This is a 3D array describing the grid structure of the [PostCard] widget by giving how many grids should each photo take in x and y directions.
///The first dimension is the number of photos in the post.
///Every entry in the second dimensions represents a photo
///Every entry in the third dimension represents the number of grids the photo should take in x and y directions. for example [2, 3] means the photo should take 2 grids in x direction and 3 grids in y direction.
///Total size of the grid is 6x6
///Works beatifully so maybe do not change?

List<List<List<int>>> GRID_STRUCTURE = [
  [
    [6, 6]
  ],
  [
    [3, 6],
    [3, 6]
  ],
  [
    [3, 3],
    [3, 3],
    [6, 3]
  ],
  [
    [3, 3],
    [3, 3],
    [3, 3],
    [3, 3]
  ],
  [
    [4, 2],
    [2, 4],
    [2, 4],
    [2, 2],
    [4, 2]
  ],
  [
    [4, 2],
    [2, 2],
    [2, 2],
    [4, 2],
    [4, 2],
    [2, 2]
  ],
  [
    [4, 2],
    [2, 2],
    [2, 2],
    [2, 2],
    [2, 4],
    [2, 2],
    [2, 2]
  ],
  [
    [4, 2],
    [2, 2],
    [2, 2],
    [2, 2],
    [2, 2],
    [2, 2],
    [2, 2],
    [2, 2]
  ],
  [
    [2, 2],
    [2, 2],
    [2, 2],
    [2, 2],
    [2, 2],
    [2, 2],
    [2, 2],
    [2, 2],
    [2, 2]
  ],
];
