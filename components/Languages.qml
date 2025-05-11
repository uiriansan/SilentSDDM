pragma Singleton
import QtQuick

/*
    Map country codes to language codes, so we can use the system's keyboard layouts with the virtual keyboard

    Avaialble layouts   -> https://doc.qt.io/qt-6/qtvirtualkeyboard-layouts.html
    Language codes      -> http://www.lingoes.net/en/translator/langcode.htm
*/

QtObject {
    property var langs: {
        "br": {
            "loc_name": "Protuguês Brasileiro",
            "kb_code": "pt_BR"
        },
        "us": {
            "loc_name": "English (US)",
            "kb_code": "en_US"
        },
        "gb": {
            "loc_name": "English (GB)",
            "kb_code": "en_GB"
        }
    }

    function getKBCodeFor(country) {
        return langs[country]["kb_code"];
    }
}
