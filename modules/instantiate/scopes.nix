{ backendType }:
let taxonomy = import ../package-governance/taxonomy.nix;
in {
  system = taxonomy.hasSystemScope backendType;
  home = taxonomy.hasHomeScope backendType;
}
