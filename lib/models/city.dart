class City {
    String cityId;
    String cityName;
    int cityTawsil;

    City({
        this.cityId,
        this.cityName,
        this.cityTawsil,
    });

    factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json["city_id"],
        cityName: json["city_name"],
        cityTawsil: json["city_tawsil"],
    );

    Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "city_name": cityName,
        "city_tawsil": cityTawsil,
    };
}
