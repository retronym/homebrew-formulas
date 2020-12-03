class Jitwatch < Formula
  desc "Log analyser / visualiser for Java HotSpot JIT compiler"
  homepage "https://github.com/AdoptOpenJDK/jitwatch/wiki"
  url "https://github.com/AdoptOpenJDK/jitwatch/releases/download/1.4.0/jitwatch-ui-1.4.0-shaded-mac.jar"
  sha256 "967dca94319e5ccc1f4c89bb6c5950c7299509294f0d90307ef93f4125760de9"
  version "1.4.0"

  bottle :unneeded

  depends_on "openjdk@11"

  def install
    libexec.install "jitwatch-ui-1.4.0-shaded-mac.jar"

    (bin/"jitwatch").write <<~EOS
      #!/bin/sh
      export JAVA_HOME="${JAVA_HOME:-#{Formula["openjdk"].opt_prefix}}"
      "$JAVA_HOME/bin/java" $JAVA_OPTS -classpath '#{libexec}/*' "$@" org.adoptopenjdk.jitwatch.launch.LaunchUI
    EOS
    (bin/"jitwatch-headless").write <<~EOS
      #!/bin/sh
      export JAVA_HOME="${JAVA_HOME:-#{Formula["openjdk"].opt_prefix}}"
      "$JAVA_HOME/bin/java" $JAVA_OPTS -classpath '#{libexec}/*' org.adoptopenjdk.jitwatch.launch.LaunchHeadless "$@"
    EOS
  end

  test do
    assert_match "Usage: LaunchHeadless", shell_output("#{bin}/jitwatch-headless -help")
  end
end
