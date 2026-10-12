CREATE OR REPLACE FUNCTION KFL_PRODUCTION_DBP_ETL_PROCESS.transcriptc(str STRING)
RETURNS STRING
LANGUAGE js AS """
  var answer = "";
  var a = {
    "Ё":"YO","Й":"J","Ц":"Z","У":"U","К":"K","Е":"E","Н":"N","Г":"G","Ш":"Sh","Щ":"Sch","З":"Z","Х":"Ch","Ъ":"A",
    "ё":"yo","й":"j","ц":"z","у":"u","к":"k","е":"e","н":"n","г":"g","ш":"sh","щ":"sch","з":"z","х":"ch","ъ":"a",
    "Ф":"F","Ы":"I","В":"V","А":"A","П":"P","Р":"R","О":"O","Л":"L","Д":"D","Ж":"Sch","Э":"E",
    "ф":"f","ы":"i","в":"v","а":"a","п":"p","р":"r","о":"o","л":"l","д":"d","ж":"sch","э":"e",
    "Я":"Ja","Ч":"Tsch","С":"S","М":"M","И":"I","Т":"T","Ь":"''","Б":"B","Ю":"Yu",
    "я":"ja","ч":"tsch","с":"s","м":"m","и":"i","т":"t","ь":"''","б":"b","ю":"yu"
  };

  for (var i = 0; i < str.length; i++) {
    var ch = str[i];
    answer += (a[ch] !== undefined) ? a[ch] : ch;
  }
  return answer;
""";

