/*
    Map country codes to IETF language codes, so we can use the system's keyboard layouts with the virtual keyboard
    The keyboard layout isn't detected under Wayland, so I'm still not sure if that's a good idea.

    Avaialble layouts   -> https://doc.qt.io/qt-6/qtvirtualkeyboard-layouts.html
    Language labels     -> https://en.wikipedia.org/wiki/IETF_language_tag

    https://github.com/qt/qtvirtualkeyboard/blob/16fbddbbc03777e0a006daa998eda14624d62268/src/virtualkeyboard/configure.cmake
    https://github.com/qt/qtvirtualkeyboard/blob/16fbddbbc03777e0a006daa998eda14624d62268/tests/manual/x11vkbtest/testlanguagechange.cpp
    https://github.com/qt/qtvirtualkeyboard/blob/16fbddbbc03777e0a006daa998eda14624d62268/cmake/QtVirtualKeyboardSetup.cmake
*/

pragma Singleton
import QtQuick

QtObject {
    property var layouts: {
        "ar": {
            // Arabic
            "label": "العربية",
            "kb_code": "ar_AR"
        },
        "bg": {
            // Bulgarian
            "label": "български",
            "kb_code": "bg_BG"
        },
        "cz": {
            // Czech
            "label": "Čeština ",
            "kb_code": "cs_CZ"
        },
        "dk": {
            // Danish
            "label": "Dansk",
            "kb_code": "da_DK"
        },
        "de": {
            // German
            "label": "Deutsch",
            "kb_code": "de_DE"
        },
        "gr": {
            // Greek
            "label": "Ελληνικά",
            "kb_code": "el_GR"
        },
        "gb": {
            "label": "British English",
            "kb_code": "en_GB"
        },
        "us": {
            "label": "American English",
            "kb_code": "en_US"
        },
        "es": {
            // Spanish
            "label": "Español",
            "kb_code": "es_ES"
        },
        "mx": {
            // Mexican spanish
            "label": "Español (México)",
            "kb_code": "es_MX"
        },
        "ee": {
            // Estonian
            "label": "Eesti",
            "kb_code": "et_EE"
        },
        "fa": {
            // Persian (Farsi)
            "label": "فارسى",
            "kb_code": "fa_FA"
        },
        "fi": {
            // Finnish
            "label": "Suomi",
            "kb_code": "fi_FI"
        },
        "ca": {
            // French Canada
            "label": "Français (Canada)",
            "kb_code": "fr_CA"
        },
        "fr": {
            // French
            "label": "Français",
            "kb_code": "fr_FR"
        },
        "il": {
            // Hebrew
            "label": "עברית",
            "kb_code": "he_IL"
        },
        "in": {
            // Hindi
            "label": "हिंदी",
            "kb_code": "hi_IN"
        },
        "hr": {
            // Croatian
            "label": "Hrvatski ",
            "kb_code": "hr_HR"
        },
        "hu": {
            // Hungarian
            "label": "Magyar ",
            "kb_code": "hu_HU"
        },
        "id": {
            // Indonesian
            "label": "Bahasa Indonesia",
            "kb_code": "id_ID"
        },
        "it": {
            // Italian
            "label": "Italiano",
            "kb_code": "it_IT"
        },
        "lv": {
            // Latvian
            "label": "latviešu ",
            "kb_code": "lv_LV"
        },
        "jp": {
            // Japanese
            "label": "日本語",
            "kb_code": "ja_JP"
        },
        "kr": {
            // Korean
            "label": "한국어",
            "kb_code": "ko_KR"
        },
        "my": {
            // Malay
            "label": "Bahasa Malaysia",
            "kb_code": "ms_MY"
        },
        "no": {
            // Norwegian
            "label": "Norsk ",
            "kb_code": "nb_NO"
        },
        "nl": {
            // Dutch
            "label": "Nederlands",
            "kb_code": "nl_NL"
        },
        "pl": {
            // Polish
            "label": "Polski",
            "kb_code": "pl_PL"
        },
        "br": {
            // Portuguese (Brazil)
            "label": "Português (Brasil)",
            "kb_code": "pt_BR"
        },
        "pt": {
            // Portuguese (Europe)
            "label": "Português (Portugal)",
            "kb_code": "pt_PT"
        },
        "ro": {
            // Romanian
            "label": "Română",
            "kb_code": "ro_RO"
        },
        "ru": {
            // Russian
            "label": "Русский",
            "kb_code": "ru_RU"
        },
        "sk": {
            // Slovak
            "label": "Slovenčina",
            "kb_code": "sk_SK"
        },
        "si": {
            // Slovenian
            "label": "Slovenski",
            "kb_code": "sl_SI"
        },
        "al": {
            // Albanian
            "label": "Shqip",
            "kb_code": "sq_AL"
        },
        "sp": {
            // Serbian
            "label": "Srpski/Српски",
            "kb_code": "sr_SP"
        },
        "se": {
            // Swedish
            "label": "Svenska",
            "kb_code": "sv_SE"
        },
        "th": {
            // Thai
            "label": "ไทย",
            "kb_code": "th_TH"
        },
        "tr": {
            // Turkish
            "label": "Türkçe",
            "kb_code": "tr_TR"
        },
        "ua": {
            // Ukrainian
            "label": "Українська",
            "kb_code": "uk_UA"
        },
        "vn": {
            // Vietnamese
            "label": "Tiếng Việt",
            "kb_code": "vi_VN"
        },
        "cn": {
            // Simplified Chinese
            "label": "简体中文",
            "kb_code": "zh_CN"
        },
        "tw": {
            // Traditional Chinese
            "label": "繁體中文",
            "kb_code": "zh_TW"
        }
        // FIXME: Missing layout for "zh_HK" (HongKong Chinese). This might be yet another SDDM bug.
    }

    function getKBCodeFor(country) {
        // FIX: Parameter null safety
        return country && layouts[country] ? layouts[country]["kb_code"] : "";
    }

    function getLabelFor(country) {
        // FIX: Parameter null safety + return consistency
        return country && layouts[country] ? layouts[country]["label"] : "";
    }
}
