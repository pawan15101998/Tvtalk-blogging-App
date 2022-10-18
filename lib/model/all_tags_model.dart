// To parse this JSON data, do
//
//     final allTagsModel = allTagsModelFromJson(jsonString);

import 'dart:convert';

List<AllTagsModel> allTagsModelFromJson(String str) => List<AllTagsModel>.from(json.decode(str).map((x) => AllTagsModel.fromJson(x)));

String allTagsModelToJson(List<AllTagsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllTagsModel {
    AllTagsModel({
        this.id,
        this.activetag,
        this.count,
        this.description,
        this.link,
        this.name,
        this.slug,
        this.taxonomy,
        this.meta,
        this.links,
    });

    int? id;
    bool? activetag;
    int? count;
    String? description;
    String? link;
    String? name;
    String? slug;
    String? taxonomy;
    List<dynamic>? meta;
    Links? links;

    factory AllTagsModel.fromJson(Map<String, dynamic> json) => AllTagsModel(
        id: json["id"],
        activetag: json["activetag"],
        count: json["count"],
        description: json["description"],
        link: json["link"],
        name: json["name"],
        slug: json["slug"],
        taxonomy: json["taxonomy"],
        meta: List<dynamic>.from(json["meta"].map((x) => x)),
        links: Links.fromJson(json["_links"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "description": description,
        "link": link,
        "name": name,
        "slug": slug,
        "taxonomy": taxonomy,
        "meta": List<dynamic>.from(meta!.map((x) => x)),
        "_links": links!.toJson(),
    };
}

class Links {
    Links({
        this.self,
        this.collection,
        this.about,
        this.wpPostType,
        this.curies,
    });

    List<About>? self;
    List<About>? collection;
    List<About>? about;
    List<About>? wpPostType;
    List<Cury>? curies;

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
        collection: List<About>.from(json["collection"].map((x) => About.fromJson(x))),
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
        wpPostType: List<About>.from(json["wp:post_type"].map((x) => About.fromJson(x))),
        curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection!.map((x) => x.toJson())),
        "about": List<dynamic>.from(about!.map((x) => x.toJson())),
        "wp:post_type": List<dynamic>.from(wpPostType!.map((x) => x.toJson())),
        "curies": List<dynamic>.from(curies!.map((x) => x.toJson())),
    };
}

class About {
    About({
        this.href,
    });

    String? href;

    factory About.fromJson(Map<String, dynamic> json) => About(
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "href": href,
    };
}

class Cury {
    Cury({
        this.name,
        this.href,
        this.templated,
    });

    String? name;
    String? href;
    bool? templated;

    factory Cury.fromJson(Map<String, dynamic> json) => Cury(
        name: json["name"],
        href: json["href"],
        templated: json["templated"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "href": href,
        "templated": templated,
    };
}
