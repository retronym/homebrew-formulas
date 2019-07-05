class Jitwatch < Formula
  desc "Log analyser / visualiser for Java HotSpot JIT compiler"
  homepage "https://github.com/AdoptOpenJDK/jitwatch/wiki"
  url "https://github.com/AdoptOpenJDK/jitwatch/archive/adbea1d984774bdf6afdca164ba9f6ff35803f89.zip"
  sha256 "c6b9877b6b5e1c6440d3eb604263793559c9ab70f318e9ae89a9d5286038b4e8"
  version "2019.04.27" # the upstream repo hasn't been tagging releases recently.

  bottle :unneeded

  depends_on "maven" => :build
  depends_on :java => "1.8+"

  def install
    system "mvn", "versions:set", "-DnewVersion=#{version}", "-B"
    system "mvn", "install", "dependency:copy-dependencies", "-Djdk.version=8", "-DskipTests=true", "-Dmaven.javadoc.skip=true", "-B"
    libexec.install Dir["ui/target/dependency/*.jar"]
    libexec.install "ui/target/jitwatch-ui-#{version}.jar"

    (bin/"jitwatch").write <<~EOS
      #!/bin/sh
      java $JAVA_OPTS -classpath '#{libexec}/*':"$JAVA_HOME/jre/lib/jfxrt.jar" "$@" org.adoptopenjdk.jitwatch.launch.LaunchUI
    EOS
    (bin/"jitwatch-headless").write <<~EOS
      #!/bin/sh
      java $JAVA_OPTS -classpath '#{libexec}/*' org.adoptopenjdk.jitwatch.launch.LaunchHeadless "$@"
    EOS
  end

  test do
    assert_match "Usage: LaunchHeadless", shell_output("#{bin}/jardiff -help")
  end
end
