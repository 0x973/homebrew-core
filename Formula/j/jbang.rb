class Jbang < Formula
  desc "Tool to create, edit and run self-contained source-only Java programs"
  homepage "https://jbang.dev/"
  url "https://github.com/jbangdev/jbang/releases/download/v0.114.0/jbang-0.114.0.zip"
  sha256 "660c7eb2eda888897f20aa5c5927ccfed924f3b86d5f2a2477a7b0235cdc94bb"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "4bcbc43c79b9e4ca7a36a2bd4492adf172fc41aeee86a6415b8a87e33bfd43e0"
  end

  depends_on "openjdk"

  def install
    libexec.install Dir["*"]
    inreplace "#{libexec}/bin/jbang", /^abs_jbang_dir=.*/, "abs_jbang_dir=#{libexec}/bin"
    bin.install_symlink libexec/"bin/jbang"
  end

  test do
    system "#{bin}/jbang", "init", "--template=cli", testpath/"hello.java"
    assert_match "hello made with jbang", (testpath/"hello.java").read
    assert_match version.to_s, shell_output("#{bin}/jbang --version 2>&1")
  end
end
