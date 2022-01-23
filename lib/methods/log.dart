import 'dart:developer' as dev show log;

extension Log on dynamic {
  void devlog() {
    dev.log(toString());
  }
}

void devlog(message) {
  dev.log(message);
}
