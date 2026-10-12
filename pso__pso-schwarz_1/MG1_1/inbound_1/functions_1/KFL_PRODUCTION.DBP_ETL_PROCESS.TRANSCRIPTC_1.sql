CREATE OR REPLACE FUNCTION KFL_PRODUCTION.DBP_ETL_PROCESS.TRANSCRIPTC("STR" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
COMMENT='Cyrillic to Latin'
AS '
   var answer = ""
      , a = {};

   a["Ё"]="YO";a["Й"]="J";a["Ц"]="Z";a["У"]="U";a["К"]="K";a["Е"]="E";a["Н"]="N";a["Г"]="G";a["Ш"]="Sh";a["Щ"]="Sch";a["З"]="Z";a["Х"]="Ch";a["Ъ"]="A";
   a["ё"]="yo";a["й"]="j";a["ц"]="z";a["у"]="u";a["к"]="k";a["е"]="e";a["н"]="n";a["г"]="g";a["ш"]="sh";a["щ"]="sch";a["з"]="z";a["х"]="ch";a["ъ"]="a";
   a["Ф"]="F";a["Ы"]="I";a["В"]="V";a["А"]="A";a["П"]="P";a["Р"]="R";a["О"]="O";a["Л"]="L";a["Д"]="D";a["Ж"]="Sch";a["Э"]="E";
   a["ф"]="f";a["ы"]="i";a["в"]="v";a["а"]="a";a["п"]="p";a["р"]="r";a["о"]="o";a["л"]="l";a["д"]="d";a["ж"]="sch";a["э"]="e";
   a["Я"]="Ja";a["Ч"]="Tsch";a["С"]="S";a["М"]="M";a["И"]="I";a["Т"]="T";a["Ь"]="''";a["Б"]="B";a["Ю"]="Yu";
   a["я"]="ja";a["ч"]="tsch";a["с"]="s";a["м"]="m";a["и"]="i";a["т"]="t";a["ь"]="''";a["б"]="b";a["ю"]="yu";

   for (i in STR){
     if (STR.hasOwnProperty(i)) {
       if (a[STR[i]] === undefined){
         answer += STR[i];
       } else {
         answer += a[STR[i]];
       }
     }
   }
   return answer;
   ';