--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'T01' does not exist or not authorized.
UPDATE  DBP_DATA.mk_art_wup_auswahl  t01
SET       anz_tage_0verkauf  = 0
FROM	akt_zeitfenster_${TRANSIENT_TABLE_SUFFIX}  t02

WHERE     (t01.mandant_id, t01.wup_id, t01.art_id) IN (
              SELECT    t02.mandant_id
                        , t02.wup_id
                        , t02.art_id
              FROM      DBP_ETL.mk_verkauf AS t02)
AND t02.dat BETWEEN t01.dat_von AND t01.dat_bis
AND t02.mandant_id = t01.mandant_id
AND t02.wup_id = t01.wup_id
and t02.wtag_id = t01.wtag_id
AND t01.aktiv_fg = 1
AND t01.aktion_fg = 0;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'T01' does not exist or not authorized.
UPDATE   DBP_DATA.mk_art_wup_auswahl t01
SET      anz_tage_0verkauf  = t01.anz_tage_0verkauf  + 1
FROM	akt_zeitfenster_${TRANSIENT_TABLE_SUFFIX} AS t02 

WHERE     (t01.mandant_id, t01.wup_id, t01.art_id) NOT IN (
              SELECT    t02.mandant_id
                        , t02.wup_id
                        , t02.art_id
              FROM      DBP_ETL.mk_verkauf AS t02)
AND       (t01.mandant_id, t01.wup_id, t01.art_id) IN (
              SELECT    t03.mandant_id
                        , t03.wup_id
                        , t03.art_id
              FROM      DBP_ETL.mk_wupartcal AS t03
              WHERE     t03.dat IN (
                          SELECT    t04.dat
                          FROM      akt_zeitfenster_${TRANSIENT_TABLE_SUFFIX} AS t04))
AND t02.dat BETWEEN t01.dat_von AND t01.dat_bis
AND t02.mandant_id = t01.mandant_id
AND t02.wup_id = t01.wup_id
and t02.wtag_id = t01.wtag_id
AND t01.aktiv_fg = 1
AND t01.aktion_fg = 0;

