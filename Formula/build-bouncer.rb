class BuildBouncer < Formula
  desc "Run project quality checks before Git pushes"
  homepage "https://github.com/berniemackie97/build-bouncer"
  url "https://github.com/berniemackie97/build-bouncer/releases/download/v0.1.1/build-bouncer_0.1.1_source.tar.gz"
  sha256 "564e307daebd34ed0d3917b2d8086b53a1707d912618adb618ab5267f4a2a0df"
  license "MIT"
  version "0.1.1"

  depends_on "go" => :build
  deny_network_access!

  def fetch
    system "go", "mod", "download"
  end

  def install
    system "go", "build", *std_go_args(
      output: bin/"build-bouncer",
      ldflags: "-X main.version=v#{version} -X main.commit=3b2c46f11a7323f5e65a0fdf3c8f7385621bef21"
    ), "./cmd/build-bouncer"
  end

  test do
    assert_equal "build-bouncer v#{version} (3b2c46f11a7323f5e65a0fdf3c8f7385621bef21)", shell_output("#{bin}/build-bouncer --version").strip
    assert_match "Usage:", shell_output("#{bin}/build-bouncer --help")
  end
end
