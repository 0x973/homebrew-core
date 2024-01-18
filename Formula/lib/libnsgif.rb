class Libnsgif < Formula
  desc "Decoding library for the GIF image file format"
  homepage "https://www.netsurf-browser.org/projects/libnsgif/"
  url "https://download.netsurf-browser.org/libs/releases/libnsgif-1.0.0-src.tar.gz"
  sha256 "6014c842f61454d2f5a0f8243d7a8d7bde9b7da3ccfdca2d346c7c0b2c4c061b"
  license "MIT"
  head "https://git.netsurf-browser.org/libnsgif.git", branch: "master"

  depends_on "netsurf-buildsystem" => :build

  def install
    args = %W[
      NSSHARED=#{Formula["netsurf-buildsystem"].opt_pkgshare}
      PREFIX=#{prefix}
    ]

    system "make", "install", "COMPONENT_TYPE=lib-shared", *args
    system "make", "install", "COMPONENT_TYPE=lib-static", *args

    # Adjust and keep a copy of tests for test block
    inreplace "test/nsgif.c", "\"../include/nsgif.h\"", "<nsgif.h>"
    pkgshare.install "test"
  end

  test do
    args = %W[
      -I#{include}
      -L#{lib}
      -lnsgif
      -o test_nsgif
    ]

    system ENV.cc, pkgshare/"test/nsgif.c", *args
    cd pkgshare do
      output = shell_output("test/runtest.sh #{testpath}")
      assert_match "Fail:0 Error:0", output
    end
  end
end
