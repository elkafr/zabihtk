class Option {
    int optionsId;
    String optionsName;
    int optionsPrice;
    String optionsPhoto;
    bool isSelected;

    Option({
        this.optionsId,
        this.isSelected: false,
        this.optionsName,
        this.optionsPrice,
        this.optionsPhoto,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        optionsId: json["options_id"],
        optionsName: json["options_name"],
        optionsPhoto: json["options_photo"],
        optionsPrice: json["options_price"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "options_id": optionsId,
        "options_name": optionsName,
        "options_photo": optionsPhoto,
        "options_price": optionsPrice ?? 0,
    };
}
