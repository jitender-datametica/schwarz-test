CREATE OR REPLACE FUNCTION KFL_PRODUCTION_DBP_ETL_PROCESS.text_clean(str STRING)
RETURNS STRING
LANGUAGE js AS """
  var answer = "";
  var a = {
    "©": "", "á": "a", "â": "a", "ä": "ä", "Ä": "Ä", "Ă": "A", "ă": "a",
    "Ã": "A", "Å": "A", "ą": "a", "Å”": "A", "Ã¤": "ä", "Ã¶": "ö",
    "Å•": "a", "Å": "A", "Ã": "ss", "Ã¼": "ü", "Ã½": "y", "Å½": "Z",
    "Å¾": "z", "Ä¹": "A", "Ã³": "ä", "Äš": "I", "ć": "c", "č": "c",
    "Č": "C", "é": "e", "È": "E", "ĕ": "e", "ę": "e", "í": "i",
    "î": "i", "Ł": "L", "ł": "l", "ń": "n", "ň": "n", "ó": "o",
    "ô": "o", "ö": "ö", "Ö": "Ö", "ř": "r", "Ś": "S", "ś": "s",
    "š": "s", "ș": "s", "Ș": "S", "Ț": "T", "ú": "u", "Ü": "Ü",
    "ü": "ü", "ů": "u", "ý": "y", "Ż": "Z", "ż": "z", "ž": "z",
    "Ž": "Z"
  };

  for (var i = 0; i < str.length; i++) {
    var ch = str[i];
    answer += (a[ch] !== undefined) ? a[ch] : ch;
  }
  return answer;
""";
select KFL_PRODUCTION_DBP_ETL_PROCESS.text_clean("Łódź");
