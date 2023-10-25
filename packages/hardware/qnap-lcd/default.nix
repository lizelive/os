{ fetchfromgithub }:
let
  owner = "stephenhouser";
  repo = "QnapLCD-Menu";
  src = fetchfromgithub {
    inherit owner repo;
  };
in
{ }
