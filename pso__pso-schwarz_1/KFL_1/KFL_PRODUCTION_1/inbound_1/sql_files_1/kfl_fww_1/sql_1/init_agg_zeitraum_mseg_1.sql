/*
###########################################################################
#   1.) Erstellen der temporaeren Tabellen
#       Vor dem Löschen wird geprüft ob die Tabelle vorhanden ist
###########################################################################
*/

CREATE TABLE IF NOT EXISTS ${KFL_SNFLK_COMMON_DBP_LOAD}.zeitraum_mseg_1
     (
      mandant_id        BYTEINT,
      min_dat           DATE,
      max_dat           DATE,
      ranking           INTEGER
     )
;

/*
###########################################################################
#   2.) Beladung Rankingtabelle
###########################################################################
*/
INSERT INTO ${KFL_SNFLK_COMMON_DBP_LOAD}.zeitraum_mseg_1
(
         mandant_id
        ,min_dat
        ,max_dat
        ,ranking
)
SELECT
          c.mandant_id
        , b.min_dat
        , b.max_dat 
        , RANK () OVER (PARTITION BY c.mandant_id ORDER BY b.min_dat DESC)  AS ranking

FROM ${KFL_SNFLK_COMMON_DBP_DATA}.tag_1 a

INNER JOIN ${KFL_SNFLK_COMMON_DBP_DATA}.monat_1 b
        ON a.kjmo = b.kjmo

CROSS JOIN ${KFL_SNFLK_COMMON_DBP_DATA}.mandant_1 c 

WHERE a.dat BETWEEN   ${DAT_START} AND CURRENT_DATE
AND c.mandant_id IN  (${MANDANT_1})
GROUP BY 1,2,3

QUALIFY ranking <= ${ZEITRAUM}
;
