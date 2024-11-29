let
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMJa2RJ2JPbrzRobFcYsjFo9S0LIfvOml4LUzRfvVNN4 cat@aubrey.rs";
  systems = [ user ];
in
{
  "wifi-password.age".publicKeys = systems;
}