class Tasu < Formula
  desc "A terminal todo list that ages"
  homepage "https://github.com/mancuoj-collective/tasu"
  version "0.14.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.14.0/tasu-aarch64-apple-darwin.tar.xz"
      sha256 "91292ef926de97e250b1be1eef4f7c60073d7924b9d92a52207d83c3857f9361"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.14.0/tasu-x86_64-apple-darwin.tar.xz"
      sha256 "f57237a7b2a76a86fa6860a87970ceff583e284357bc0638760e8bbfb020f16b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.14.0/tasu-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "061b0f0e7eff01cb10d4b2660ec71616c94a681b3adaa2d43129959b8dcf2afd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.14.0/tasu-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "720d00634dd2865fad7e089761e6defb0c4f3257677056f0b8831c7436c21e26"
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
