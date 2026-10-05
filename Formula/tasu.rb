class Tasu < Formula
  desc "A terminal todo list that ages"
  homepage "https://github.com/mancuoj-collective/tasu"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.7.0/tasu-aarch64-apple-darwin.tar.xz"
      sha256 "27eb725ad7f4ad38d6cd1f1b225b7f9a024df98af8df4dbf97c3f866f486ac82"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.7.0/tasu-x86_64-apple-darwin.tar.xz"
      sha256 "69067586330c3afdad8d4a46c7e68d509f6cb775a54439ef26fa7201204bd138"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.7.0/tasu-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a05a4f8bc4b5e853cec19c66fc973441124c7d383d3d7b98f7ce05a4a55da601"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.7.0/tasu-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e601c186362153246fd5094047e3b7e55d9862a8471905935db966eb9cffbb76"
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
