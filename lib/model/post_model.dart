// To parse this JSON data, do
//
//     final homePagePost = homePagePostFromJson(jsonString);

import 'dart:convert';

List<HomePagePost> homePagePostFromJson(String str) => List<HomePagePost>.from(json.decode(str).map((x) => HomePagePost.fromJson(x)));

String homePagePostToJson(List<HomePagePost> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomePagePost {
    HomePagePost({
        this.id,
        this.date,
        this.dateGmt,
        this.guid,
        this.modified,
        this.modifiedGmt,
        this.slug,
        this.status,
        this.type,
        this.link,
        this.title,
        this.content,
        this.excerpt,
        this.author,
        this.featuredMedia,
        this.commentStatus,
        this.pingStatus,
        this.sticky,
        this.template,
        this.format,
        this.meta,
        this.categories,
        this.tags,
        this.postFormat,
        this.featuredMediaSrcUrl,
        this.postSubtitleFlag,
        this.postSubtitle,
        this.lastEditorUsedJetpack,
        this.thumbnailId,
        this.jnewsPriceLowest,
        this.formatGalleryImages,
        this.enableReview,
        this.name,
        this.summary,
        this.brand,
        this.good,
        this.bad,
        this.price,
        this.jnewsOverrideCounter,
        this.jnewsSinglePost,
        this.jnewsPrimaryCategory,
        this.jnewsCommentsNumber,
        this.jnewsSocialCounterLastUpdate,
        this.editLast,
        this.bunyadReviews,
        this.wpPageTemplate,
        this.wpOldSlug,
        this.wxrImportHasAttachmentRefs,
        this.bunyadFeaturedDisable,
        this.bunyadContentSlider,
        this.bunyadFeaturedVideo,
        this.bunyadReviewItemAuthor,
        this.bunyadReviewItemName,
        this.bunyadReviewHeading,
        this.bunyadReviewVerdict,
        this.bunyadReviewVerdictText,
        this.links,
    });

    int? id;
    DateTime? date;
    DateTime? dateGmt;
    Guid? guid;
    DateTime? modified;
    DateTime? modifiedGmt;
    String? slug;
    String? status;
    String? type;
    String? link;
    Guid? title;
    Content? content;
    Content? excerpt;
    int? author;
    int? featuredMedia;
    String? commentStatus;
    String? pingStatus;
    bool? sticky;
    String? template;
    String? format;
    List<dynamic>? meta;
    List<int>? categories;
    List<int>? tags;
    List<dynamic>? postFormat;
    String? featuredMediaSrcUrl;
    String? postSubtitleFlag;
    String? postSubtitle;
    String? lastEditorUsedJetpack;
    String? thumbnailId;
    String? jnewsPriceLowest;
    dynamic formatGalleryImages;
    String? enableReview;
    dynamic name;
    dynamic summary;
    dynamic brand;
    dynamic good;
    dynamic bad;
    dynamic price;
    dynamic jnewsOverrideCounter;
    dynamic jnewsSinglePost;
    dynamic jnewsPrimaryCategory;
    dynamic jnewsCommentsNumber;
    dynamic jnewsSocialCounterLastUpdate;
    dynamic editLast;
    dynamic bunyadReviews;
    dynamic wpPageTemplate;
    dynamic wpOldSlug;
    dynamic wxrImportHasAttachmentRefs;
    dynamic bunyadFeaturedDisable;
    dynamic bunyadContentSlider;
    dynamic bunyadFeaturedVideo;
    dynamic bunyadReviewItemAuthor;
    dynamic bunyadReviewItemName;
    dynamic bunyadReviewHeading;
    dynamic bunyadReviewVerdict;
    dynamic bunyadReviewVerdictText;
    Links? links;

    factory HomePagePost.fromJson(Map<String, dynamic> json) => HomePagePost(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        dateGmt: DateTime.parse(json["date_gmt"]),
        guid: Guid.fromJson(json["guid"]),
        modified: DateTime.parse(json["modified"]),
        modifiedGmt: DateTime.parse(json["modified_gmt"]),
        slug: json["slug"],
        status: json["status"],
        type: json["type"],
        link: json["link"],
        title: Guid.fromJson(json["title"]),
        content: Content.fromJson(json["content"]),
        excerpt: Content.fromJson(json["excerpt"]),
        author: json["author"],
        featuredMedia: json["featured_media"],
        commentStatus: json["comment_status"],
        pingStatus: json["ping_status"],
        sticky: json["sticky"],
        template: json["template"],
        format: json["format"],
        meta: List<dynamic>.from(json["meta"].map((x) => x)),
        categories: List<int>.from(json["categories"].map((x) => x)),
        tags: List<int>.from(json["tags"].map((x) => x)),
        postFormat: List<dynamic>.from(json["post_format"].map((x) => x)),
        featuredMediaSrcUrl: json["featured_media_src_url"] == null ? null : json["featured_media_src_url"],
        postSubtitleFlag: json["post_subtitle_flag"],
        postSubtitle: json["post_subtitle"],
        lastEditorUsedJetpack: json["_last_editor_used_jetpack"],
        thumbnailId: json["_thumbnail_id"],
        jnewsPriceLowest: json["jnews_price_lowest"],
        formatGalleryImages: json["_format_gallery_images"],
        enableReview: json["enable_review"],
        name: json["name"],
        summary: json["summary"],
        brand: json["brand"],
        good: json["good"],
        bad: json["bad"],
        price: json["price"],
        jnewsOverrideCounter: json["jnews_override_counter"],
        jnewsSinglePost: json["jnews_single_post"],
        jnewsPrimaryCategory: json["jnews_primary_category"],
        jnewsCommentsNumber: json["jnews_comments_number"],
        jnewsSocialCounterLastUpdate: json["jnews_social_counter_last_update"],
        editLast: json["_edit_last"],
        bunyadReviews: json["_bunyad_reviews"],
        wpPageTemplate: json["_wp_page_template"],
        wpOldSlug: json["_wp_old_slug"],
        wxrImportHasAttachmentRefs: json["_wxr_import_has_attachment_refs"],
        bunyadFeaturedDisable: json["_bunyad_featured_disable"],
        bunyadContentSlider: json["_bunyad_content_slider"],
        bunyadFeaturedVideo: json["_bunyad_featured_video"],
        bunyadReviewItemAuthor: json["_bunyad_review_item_author"],
        bunyadReviewItemName: json["_bunyad_review_item_name"],
        bunyadReviewHeading: json["_bunyad_review_heading"],
        bunyadReviewVerdict: json["_bunyad_review_verdict"],
        bunyadReviewVerdictText: json["_bunyad_review_verdict_text"],
        links: Links.fromJson(json["_links"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date!.toIso8601String(),
        "date_gmt": dateGmt!.toIso8601String(),
        "guid": guid!.toJson(),
        "modified": modified!.toIso8601String(),
        "modified_gmt": modifiedGmt!.toIso8601String(),
        "slug": slug,
        "status": status,
        "type": type,
        "link": link,
        "title": title!.toJson(),
        "content": content!.toJson(),
        "excerpt": excerpt!.toJson(),
        "author": author,
        "featured_media": featuredMedia,
        "comment_status": commentStatus,
        "ping_status": pingStatus,
        "sticky": sticky,
        "template": template,
        "format": format,
        "meta": List<dynamic>.from(meta!.map((x) => x)),
        "categories": List<dynamic>.from(categories!.map((x) => x)),
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "post_format": List<dynamic>.from(postFormat!.map((x) => x)),
        "featured_media_src_url": featuredMediaSrcUrl == null ? null : featuredMediaSrcUrl,
        "post_subtitle_flag": postSubtitleFlag,
        "post_subtitle": postSubtitle,
        "_last_editor_used_jetpack": lastEditorUsedJetpack,
        "_thumbnail_id": thumbnailId,
        "jnews_price_lowest": jnewsPriceLowest,
        "_format_gallery_images": formatGalleryImages,
        "enable_review": enableReview,
        "name": name,
        "summary": summary,
        "brand": brand,
        "good": good,
        "bad": bad,
        "price": price,
        "jnews_override_counter": jnewsOverrideCounter,
        "jnews_single_post": jnewsSinglePost,
        "jnews_primary_category": jnewsPrimaryCategory,
        "jnews_comments_number": jnewsCommentsNumber,
        "jnews_social_counter_last_update": jnewsSocialCounterLastUpdate,
        "_edit_last": editLast,
        "_bunyad_reviews": bunyadReviews,
        "_wp_page_template": wpPageTemplate,
        "_wp_old_slug": wpOldSlug,
        "_wxr_import_has_attachment_refs": wxrImportHasAttachmentRefs,
        "_bunyad_featured_disable": bunyadFeaturedDisable,
        "_bunyad_content_slider": bunyadContentSlider,
        "_bunyad_featured_video": bunyadFeaturedVideo,
        "_bunyad_review_item_author": bunyadReviewItemAuthor,
        "_bunyad_review_item_name": bunyadReviewItemName,
        "_bunyad_review_heading": bunyadReviewHeading,
        "_bunyad_review_verdict": bunyadReviewVerdict,
        "_bunyad_review_verdict_text": bunyadReviewVerdictText,
        "_links": links!.toJson(),
    };
}

class Content {
    Content({
        this.rendered,
        this.protected,
    });

    String? rendered;
    bool? protected;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
        protected: json["protected"],
    );

    Map<String, dynamic> toJson() => {
        "rendered": rendered,
        "protected": protected,
    };
}

class Guid {
    Guid({
        this.rendered,
    });

    String? rendered;

    factory Guid.fromJson(Map<String, dynamic> json) => Guid(
        rendered: json["rendered"],
    );

    Map<String, dynamic> toJson() => {
        "rendered": rendered,
    };
}

class Links {
    Links({
        this.self,
        this.collection,
        this.about,
        this.author,
        this.replies,
        this.versionHistory,
        this.predecessorVersion,
        this.wpFeaturedmedia,
        this.wpAttachment,
        this.wpTerm,
        this.curies,
    });

    List<About>? self;
    List<About>? collection;
    List<About>? about;
    List<Author>? author;
    List<Author>? replies;
    List<VersionHistory>? versionHistory;
    List<PredecessorVersion>? predecessorVersion;
    List<Author>? wpFeaturedmedia;
    List<About>? wpAttachment;
    List<WpTerm>? wpTerm;
    List<Cury>? curies;

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
        collection: List<About>.from(json["collection"].map((x) => About.fromJson(x))),
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
        author: List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
        replies: List<Author>.from(json["replies"].map((x) => Author.fromJson(x))),
        versionHistory: List<VersionHistory>.from(json["version-history"].map((x) => VersionHistory.fromJson(x))),
        predecessorVersion: List<PredecessorVersion>.from(json["predecessor-version"].map((x) => PredecessorVersion.fromJson(x))),
        wpFeaturedmedia: List<Author>.from(json["wp:featuredmedia"].map((x) => Author.fromJson(x))),
        wpAttachment: List<About>.from(json["wp:attachment"].map((x) => About.fromJson(x))),
        wpTerm: List<WpTerm>.from(json["wp:term"].map((x) => WpTerm.fromJson(x))),
        curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection!.map((x) => x.toJson())),
        "about": List<dynamic>.from(about!.map((x) => x.toJson())),
        "author": List<dynamic>.from(author!.map((x) => x.toJson())),
        "replies": List<dynamic>.from(replies!.map((x) => x.toJson())),
        "version-history": List<dynamic>.from(versionHistory!.map((x) => x.toJson())),
        "predecessor-version": List<dynamic>.from(predecessorVersion!.map((x) => x.toJson())),
        "wp:featuredmedia": List<dynamic>.from(wpFeaturedmedia!.map((x) => x.toJson())),
        "wp:attachment": List<dynamic>.from(wpAttachment!.map((x) => x.toJson())),
        "wp:term": List<dynamic>.from(wpTerm!.map((x) => x.toJson())),
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

class Author {
    Author({
        this.embeddable,
        this.href,
    });

    bool? embeddable;
    String? href;

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        embeddable: json["embeddable"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "embeddable": embeddable,
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

class PredecessorVersion {
    PredecessorVersion({
        this.id,
        this.href,
    });

    int? id;
    String? href;

    factory PredecessorVersion.fromJson(Map<String, dynamic> json) => PredecessorVersion(
        id: json["id"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "href": href,
    };
}

class VersionHistory {
    VersionHistory({
        this.count,
        this.href,
    });

    int? count;
    String? href;

    factory VersionHistory.fromJson(Map<String, dynamic> json) => VersionHistory(
        count: json["count"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "href": href,
    };
}

class WpTerm {
    WpTerm({
        this.taxonomy,
        this.embeddable,
        this.href,
    });

    String? taxonomy;
    bool? embeddable;
    String? href;

    factory WpTerm.fromJson(Map<String, dynamic> json) => WpTerm(
        taxonomy: json["taxonomy"],
        embeddable: json["embeddable"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "taxonomy": taxonomy,
        "embeddable": embeddable,
        "href": href,
    };
}
