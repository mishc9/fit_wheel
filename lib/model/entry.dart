class Entry {
  bool saved;
  String entryName;

  Entry({
    this.saved = false,
    this.entryName = "",
  });

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        saved: json["saved"],
        entryName: json["entryName"],
      );

  Map<String, dynamic> toJson() => {
        "entryName": entryName,
        "saved": saved,
      };

  @override
  String toString() {
    return """
    id: $entryName,
    status: $saved
    ---------------------------
    """;
  }
}
