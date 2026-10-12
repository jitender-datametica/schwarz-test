CREATE OR REPLACE FUNCTION kfl_production_dbp_etl_process.text_clean(STR STRING)
RETURNS STRING
LANGUAGE js
OPTIONS (description='Schrott to Latin')
AS r"""

   var answer = ""

      , a = {};

      a["©"] ="";
   a["á"] ="a";
   a["â"] ="a";
   a["ä"] ="ä";
   a["Ä"] ="Ä";
   a["Ă"] ="A";
   a["ă"] ="a";
   a["Ã"] ="A";
   a["Å"] ="A";
   a["ą"] ="a";
   a["Å”"] ="A";
   a["Ã¤"]="ä";
   a["Ã¶"] ="ö";
   a["Å•"] ="a";
   a["Å›"] ="A";
   a["ÃŸ"]="ss";
   a["Ã¼"] ="ü";
   a["Ã½"] ="y";
   a["Å½"] ="Z";
   a["Å¾"] ="z";
   a["Ä¹"] ="A";
   a["Ã³"] ="ä";
   a["Äš"] ="I";
   a["ć"] ="c";
   a["č"] ="c";
   a["Č"] ="C";
   a["é"] ="e";
   a["È"] ="E";
   a["ĕ"] ="e";
   a["ę"] ="e";
   a["í"] ="i";
   a["î"] ="i";
   a["Ł"] ="L";
   a["ł"] ="l";
   a["ń"] ="n";
   a["ň"] ="n";
   a["ó"] ="o";
   a["ô"] ="o";
   a["ö"] ="ö";
   a["Ö"] ="Ö";
   a["ř"] ="r";
   a["Ś"] ="S";
   a["ś"] ="s";
   a["š"] ="s";
   a["ș"] ="s";
   a["Ș"] ="S";
   a["Ț"] ="T";
   a["ú"] ="u";
   a["Ü"] ="Ü";
   a["ü"] ="ü";
   a["Ü"] ="Ü";
   a["ů"] ="u";
   a["ý"] ="y";
   a["Ż"] ="Z";
   a["ż"] ="z";
   a["ž"] ="z";
   a["Ž"] ="Z";

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
""";