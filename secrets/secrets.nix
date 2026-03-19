# Add your public keys here
let
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID4EsTFEdcfhxIy5Exi3y3ITAtuId+KMcZvGp+OVsDYp aryan@thinkpad";
in
{
  "gpg-key.age".publicKeys = [ user ];
  "gh-token.age".publicKeys = [ user ];
}
