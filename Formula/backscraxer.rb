class Backscraxer < Formula
  desc "CLI tool for ingesting twitterapi.io tweets and media into local SQLite"
  homepage "https://github.com/0xsend/backscraXer"
  version "0.0.2"
  license "UNLICENSED"

  on_macos do
    on_arm do
      url "https://github.com/0xsend/backscraXer/releases/download/v0.0.2/backscraxer-darwin-arm64"
      sha256 "3b1dfa4662e352c9c48abf28f37fb616607334d42014991a3b429ae19cd4fec6"
    end

    on_intel do
      url "https://github.com/0xsend/backscraXer/releases/download/v0.0.2/backscraxer-darwin-x64"
      sha256 "6761be914ae139f193175dee822364312a31437cb255426e52b899ae2808a7ac"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/0xsend/backscraXer/releases/download/v0.0.2/backscraxer-linux-x64"
      sha256 "52142dfa9931bfef8e480e920a778c4976d4735ae0a3e2853ff9255036b7c617"
    end
  end

  def install
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "backscraxer-darwin-arm64" : "backscraxer-darwin-x64"
    else
      "backscraxer-linux-x64"
    end

    bin.install binary_name => "backscraxer"
  end

  test do
    output = shell_output("#{bin}/backscraxer docs:get-endpoints --format json")
    json = JSON.parse(output)
    assert_operator json.length, :>, 0
    assert_includes json.map { |e| e["key"] }, "user.info"
  end

  def caveats
    <<~EOS
      First-run setup:
        backscraxer setup

      Install agent skill files:
        backscraxer install --target codex
        backscraxer install --target claude
        backscraxer install --target cursor
    EOS
  end
end
