class Jardiff < Formula
  desc "Diff tool for Java classes or classpaths"
  homepage "https://github.com/scala/jardiff"
  url "https://github.com/scala/jardiff/releases/download/v1.5.0/jardiff.jar" #, using => :nounzip
  sha256 "9dbc17f4d72ec27b7b7c68775fa9e05d8b7b1a5694405dec5e1060c7f5bbedb9"

  bottle :unneeded

  depends_on :java => "1.8+"

  def install
    libexec.install "jardiff.jar"

    (bin/"jardiff").write <<~EOS
      #!/bin/sh
      java $JAVA_OPTS -jar "#{libexec}/jardiff.jar" "$@"
    EOS
  end

  test do
    assert_match "usage: jardiff", shell_output("#{bin}/jardiff -help")
  end
end
