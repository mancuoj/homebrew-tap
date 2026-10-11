class Tasu < Formula
  desc "A terminal todo list that ages"
  homepage "https://github.com/mancuoj-collective/tasu"
  version "0.16.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.16.0/tasu-aarch64-apple-darwin.tar.xz"
      sha256 "cf1197de0002c59de5e99549aa6cdbf23f226874c69a863fd0cdd26b3155f948"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.16.0/tasu-x86_64-apple-darwin.tar.xz"
      sha256 "19ac9c93887261143828e306ce4c8b4d2c04e3e08a3dbac70c15a426fd97ec10"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.16.0/tasu-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b37c2b825af16818054e6260a934918b7f3a47477419a4105b4695ccce69c77f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.16.0/tasu-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0cf8230fca4d5f7de6a44158de6b53b592d4215b558994ab6058733e08a5f350"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "tasu"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tasu"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "tasu"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tasu"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
