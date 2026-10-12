--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.ods_bon_agg_15min_scanzeit_1;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE TABLE dbp_etl.ods_bon_agg_15min_scanzeit_1  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL,
      scanzeit INTEGER NOT NULL)
;

--[OK] statement is translated correctly-----------------------------------------------------------------
INSERT INTO dbp_etl.ods_bon_agg_15min_scanzeit_1
(
    dat
   ,zeit_stunde
   ,zeit_15min
   ,mandant_id
   ,wup_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,scanzeit
 )
SELECT
    bon_dat
   ,zeit_stunde
   ,zeit_minute
   ,mandant_id
   ,wup_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   --,Sum(
   --Cast((
   --(CASE WHEN zeit_scheibe_ende<=end_time THEN zeit_scheibe_ende ELSE end_time END-CASE WHEN zeit_scheibe_start>=start_time THEN zeit_scheibe_start ELSE start_time END) Second(4)) AS INTEGER)
   --) AS  scanzeit 


   ,Sum( timestampdiff(second,
                      CASE WHEN zeit_scheibe_start>=start_time THEN zeit_scheibe_start ELSE start_time END, 
                      CASE WHEN zeit_scheibe_ende<=end_time THEN zeit_scheibe_ende ELSE end_time END
                     )
   ) AS  scanzeit 

FROM
(
SELECT 
 t1.mandant_id
,t1.wup_id
,t1.kassensystem_name
,t1.kasse_nr
,t1.kasse_typ_id
,t2.zeit_stunde
,t2.zeit_minute
,Cast(t1.bon_beginn AS DATE) AS bon_dat
,to_timestamp((to_char(t1.bon_beginn, 'YYYY-MM_1-DD') || ' ' || t2.start_time) ) AS zeit_scheibe_start
,to_timestamp((to_char(t1.scan_ende , 'YYYY-MM_1-DD') || ' ' || t2.end_time) ) + INTERVAL '1 SECOND' AS zeit_scheibe_ende
,Cast(Substring(Cast(t1.bon_beginn AS CHAR(26)), 1, 19) AS TIMESTAMP(0)) AS start_time
,Cast(Substring(Cast(t1.scan_ende AS CHAR(26)), 1, 19) AS TIMESTAMP(0)) AS end_time
FROM
(
SELECT 
mandant_id
,wup_id
,kassensystem_name
,kasse_nr
,kasse_typ_id
,bon_dat
,bon_beginn
,scan_ende
,bon_ende
FROM dbp_etl.bon_agg_kassierzeiten_1
WHERE Cast(bon_beginn AS DATE) = Cast(scan_ende AS DATE)
AND bon_beginn < scan_ende
)t1_1
    INNER JOIN _zeit_$_1{TRANSIENT_TABLE_SUFFIX} t2
 ON  ((to_timestamp((to_char(t1.scan_ende , 'YYYY-MM_1-DD') || ' ' || t2.end_time) ) + INTERVAL '1 SECOND') >= t1.scan_ende
 AND to_timestamp((to_char(t1.bon_beginn, 'YYYY-MM_1-DD') || ' ' || t2.start_time) ) <= t1.scan_ende)
 OR ((to_timestamp((to_char(t1.scan_ende , 'YYYY-MM_1-DD') || ' ' || t2.end_time) ) + INTERVAL '1 SECOND') >= t1.bon_beginn
 AND to_timestamp((to_char(t1.bon_beginn, 'YYYY-MM_1-DD') || ' ' || t2.start_time) ) <= t1.bon_beginn)
 WHERE start_time < end_time
 ) dt1
GROUP BY 1,2,3,4,5,6,7,8;



