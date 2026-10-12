--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.mk_verkauf_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
CREATE TABLE DBP_ETL.mk_verkauf_2  (
      mandant_id BYTEINT,
      wup_id INTEGER,
      art_id INTEGER,
      nb_id INTEGER,
      aktion_fg BYTEINT,
      dat DATE,
      wtag_id BYTEINT,
      zeitfenster_id BYTEINT)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Schema 'KFL_DEVELOPMENT.DBP_ODS' does not exist or not authorized.
INSERT INTO DBP_ETL.mk_verkauf_2 (
  mandant_id
  , wup_id
  , art_id
  , nb_id
  , aktion_fg
  , dat
  , wtag_id
  , zeitfenster_id)
  
SELECT        t01.mandant_id
            , t01.wup_id
            , t03.art_id
            , t02.nb_id
            , t02.aktion_fg
            , t01.bon_dat AS dat
            , t02.wtag_id
            , CASE
                WHEN EXTRACT(HOUR FROM bon_booking) <= 11 THEN 1
                WHEN EXTRACT(HOUR FROM bon_booking) BETWEEN 12 AND 17 THEN 2
                WHEN EXTRACT(HOUR FROM bon_booking) >= 18 THEN 3
                END AS zeitfenster_id
FROM      DBP_ODS.ods_bon_kopf_2 AS t01 -- Tabellen angepaßt
INNER JOIN
          DBP_ODS.ods_bon_verkauf_2 AS t05
ON        t01.mandant_id = t05.mandant_id
AND       t01.wup_id = t05.wup_id
AND       t01.bon_id = t05.bon_id
AND       t01.bon_dat = t05.bon_dat

INNER JOIN
            akt_zeitfenster_$_2{TRANSIENT_TABLE_SUFFIX} AS t04
  ON      t01.bon_dat = t04.dat
  AND     t01.mandant_id = t04.mandant_id
  AND     t01.wup_id = t04.wup_id
INNER JOIN     
      (
        SELECT  kl_art_id, mandant_id, MAX(art_id) AS art_id
        FROM DBP_DATA.art_2
        GROUP BY kl_art_id, mandant_id
       ) AS t03
ON        t05.mandant_id = t03.mandant_id
AND     t05.kl_art_id = t03.kl_art_id
        
INNER JOIN
     DBP_DATA.mk_art_wup_auswahl_2 t02
ON       t02.mandant_id = t05.mandant_id
AND    t05.wup_id = t02.wup_id
AND    t02.art_id = t03.art_id
AND    t04.dat BETWEEN t02.dat_von AND t02.dat_bis
AND    t04.wtag_id = t02.wtag_id
WHERE     t02.aktiv_fg = 1
GROUP BY 1,2,3,4,5,6,7,8
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.mk_absatz_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.mk_absatz_2  (
      mandant_id BYTEINT NOT NULL,
      art_id INTEGER,
      wup_id INTEGER,
      dat_bon DATE,
      zeit_bon INTEGER,
      sum_abs_stck DECIMAL(18,4))
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Schema 'KFL_DEVELOPMENT.DBP_ODS' does not exist or not authorized.
INSERT INTO DBP_ETL.mk_absatz_2
(
    mandant_id
   ,art_id                        
   ,wup_id                        
   ,dat_bon                       
   ,zeit_bon                      
   ,sum_abs_stck                      

)
SELECT
            t01.mandant_id
          , a.art_id
          , t01.wup_id
          , t01.bon_dat
          , EXTRACT(HOUR FROM t01.bon_booking) * 10000 
            + EXTRACT(MINUTE FROM t01.bon_booking) *100 
            + EXTRACT(SECOND FROM t01.bon_booking)
          , SUM(menge) 
FROM  DBP_ODS.ods_bon_kopf_2 AS t01 
INNER JOIN
       DBP_ODS.ods_bon_verkauf_2 AS t05
ON  t01.mandant_id = t05.mandant_id
AND t01.wup_id = t05.wup_id
AND t01.bon_id = t05.bon_id
AND t01.bon_dat = t05.bon_dat
INNER JOIN
      (
       SELECT kl_art_id, MAX(art_id)  art_id
       FROM  DBP_DATA.art_2
       WHERE mandant_id = 1 
       GROUP BY kl_art_id
       ) a
ON t05.kl_art_id =  a.kl_art_id
WHERE
 (t01.wup_id)  IN 
       (  SELECT wup_id FROM DBP_MSI_DATA.l_mk_wup_2)
AND t01.bon_dat= CURRENT_DATE
AND t05.bon_dat= CURRENT_DATE 
AND t01.mandant_id=1
GROUP BY 1,2,3,4,5
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.tmp_mk_marktbestand_erp_delta_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
CREATE TABLE DBP_ETL.tmp_mk_marktbestand_erp_delta_2  (
      art_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL  ,
      wup_id INTEGER NOT NULL,
      cal_menge_lgbest DECIMAL(18,3) NOT NULL,
      lgbest_erp_frei_bme DECIMAL(18,3) NOT NULL  )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.tmp_mk_marktbestand_erp_delta_2 
(
  mandant_id
, art_id
, wup_id 
, cal_menge_lgbest
, lgbest_erp_frei_bme
)

SELECT 
      
  tt01.mandant_id 
, tt01.art_id 
, tt01.wup_id 
, SUM(tt01.menge_lgbest_erp_frei_bme) - ZEROIFNULL(SUM(tt02.sum_abs_stck)) AS cal_menge_lgbest
, SUM(tt01.menge_lgbest_erp_frei_bme) AS  lgbest_erp_frei_bme   

 FROM DBP_DATA.marktbestand_erp_delta_2 tt01
 
 INNER JOIN DBP_MSI_DATA.l_mk_wup_2 tt03
 ON tt01.wup_id = tt03.wup_id
 
 LEFT OUTER JOIN 
 (
  SELECT 
   art_id
 , wup_id
 , mandant_id
 , SUM (sum_abs_stck) sum_abs_stck 
 FROM DBP_ETL.mk_absatz_2
   GROUP BY 1,2,3 
 ) tt02 
 ON    tt01.art_id = tt02.art_id
 AND   tt01.wup_id = tt02.wup_id
 AND   tt01.mandant_id = tt02.mandant_id
 
GROUP BY 1,2,3 ;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE    DBX_DATA.mk_zeroverkauf_2
--WHERE (zeitfenster_id, dat, mandant_id, wup_id) IN
--
--      (SELECT zeitfenster_id, dat, mandant_id, wup_id
--        FROM akt_zeitfenster_$_2{TRANSIENT_TABLE_SUFFIX}
--      )
--;
--
--Comment from validation checker
--error line 1 at position 29 unexpected 'DBP_DATA_2'.
--DELETE    DBP_DATA.mk_zerover ^^^> kauf
--translated statement
DELETE  FROM  DBP_DATA.mk_zeroverkauf_2
WHERE (zeitfenster_id, dat, mandant_id, wup_id) IN

      (SELECT zeitfenster_id, dat, mandant_id, wup_id
        FROM akt_zeitfenster_$_2{TRANSIENT_TABLE_SUFFIX}
      )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.mk_zeroverkauf_2 (
    mandant_id
  , art_id
  , aktion_fg
  , dat
  , zeitfenster_id
  , wup_id
  , nb_id
  , art_fehlgrund_id
  , menge_lgbest
  , datzeit_letzter_abverkauf
  , art_fehlgrund_text
  , dat_erfasst
  , melde_fg
  )
  
  SELECT    t01.mandant_id
            , t01.art_id
            , t01.aktion_fg
            , t01.dat
            , t02.zeitfenster_id
            , t01.wup_id
            , t01.nb_id
			, NULL AS art_fehlgrund_id
            , ZEROIFNULL( 
		      CASE WHEN t02.zeitfenster_id = 2 THEN t07.cal_menge_lgbest 
		      ELSE t07.lgbest_erp_frei_bme
		      END )  AS menge_lgbest
			, NULL AS datzeit_letzter_abverkauf
            , NULL AS art_fehlgrund_text
            , NULL AS dat_erfasst
			, CASE WHEN t08.mandant_id IS NULL
              THEN 0
              ELSE 1
              END   AS melde_fg	
  FROM      DBP_ETL.mk_wupartcal_2 AS t01
  INNER JOIN
            DBP_DATA.l_zeitfenster_2 AS t02
  ON        t01.mandant_id = t02.mandant_id
  INNER JOIN
            akt_zeitfenster_$_2{TRANSIENT_TABLE_SUFFIX} AS t03
  ON        t02.zeitfenster_id = t03.zeitfenster_id
  AND       t01.dat = t03.dat
  AND       t01.mandant_id = t03.mandant_id
  AND       t01.wup_id = t03.wup_id
  
 INNER JOIN DBP_DATA.mk_art_wup_auswahl_2 t06
 ON t01.wup_id = t06.wup_id
 AND t01.art_id = t06.art_id
 AND t01.wtag_id = t06.wtag_id
 AND t01.aktion_fg = t06.aktion_fg
 AND t01.dat BETWEEN t06.dat_von AND t06.dat_bis

 
 LEFT OUTER JOIN DBP_ETL.tmp_mk_marktbestand_erp_delta_2 t07
  ON t01.wup_id = t07.wup_id
 AND t01.art_id = t07.art_id
 AND t01.mandant_id = t07.mandant_id

 LEFT OUTER JOIN
     DBP_DATA.mk_art_wup_zeitfenster_2 AS t08
 ON  t01.mandant_id     = t08.mandant_id
 AND t01.wup_id         = t08.wup_id
 AND t01.art_id         = t08.art_id
 AND t01.aktion_fg      = t08.aktion_fg
 AND t01.wtag_id        = t08.wtag_id
 AND t02.zeitfenster_id = t08.zeitfenster_id
 AND t01.dat BETWEEN t08.dat_von AND t08.dat_bis 

 
  WHERE     (t01.mandant_id, t01.wup_id, t01.art_id, t01.aktion_fg, t01.dat, t02.zeitfenster_id) NOT IN (
              SELECT    t04.mandant_id
                        , t04.wup_id
                        , t04.art_id
                        , t04.aktion_fg
                        , t04.dat
                        , t04.zeitfenster_id
              FROM      DBP_ETL.mk_verkauf_2 AS t04
              )
  AND       (t01.mandant_id, t01.wup_id, t01.art_id, t01.aktion_fg, t01.wtag_id) NOT IN (
              SELECT    t05.mandant_id
                        , t05.wup_id
                        , t05.art_id
                        , t05.aktion_fg
                        , t05.wtag_id					
              FROM      DBP_DATA.mk_art_wup_auswahl_2 AS t05
              WHERE CURRENT_DATE-1 BETWEEN t05.dat_von AND t05.dat_bis
              AND     t05.anz_tage_0verkauf  >= 3
              )
-- Anheben Qaulifizierung für die Meldung in die Tagesliste bis avg_menge > 8
   AND (melde_fg = 1 OR melde_fg=0 AND t06.avg_menge > 8)
   
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13;

