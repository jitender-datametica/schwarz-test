--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS dbp_etl.ods_bon_agg_15min_zahlzeit_1;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE TABLE dbp_etl.ods_bon_agg_15min_zahlzeit_1  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL,
      zahlzeit INTEGER NOT NULL)
;

--[OK] statement is translated correctly-----------------------------------------------------------------
INSERT INTO dbp_etl.ods_bon_agg_15min_zahlzeit_1
(
    dat
   ,zeit_stunde
   ,zeit_15min
   ,mandant_id
   ,wup_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,zahlzeit
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
   --(CASE WHEN zeit_scheibe_ende_<=end_time_ THEN zeit_scheibe_ende_ ELSE end_time_ END-CASE WHEN zeit_scheibe_start_>=start_time_ THEN zeit_scheibe_start_ ELSE start_time_ END) Second(4)) AS INTEGER)
   --) AS  zahlzeit 

   ,Sum( timestampdiff(second,
                      CASE WHEN zeit_scheibe_start_>=start_time_ THEN zeit_scheibe_start_ ELSE start_time_ END, 
                      CASE WHEN zeit_scheibe_ende_<=end_time_ THEN zeit_scheibe_ende_ ELSE end_time_ END
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
,Cast(t1.bon_ende AS DATE) AS bon_dat
,to_timestamp((to_char(t1.scan_ende , 'YYYY-MM_1-DD') || ' ' || t2.start_time)) zeit_scheibe_start_
,to_timestamp((to_char(t1.bon_ende , 'YYYY-MM_1-DD') || ' ' || t2.end_time)) + INTERVAL '1 SECOND'   zeit_scheibe_ende_
,Cast(Substring(Cast(t1.scan_ende AS CHAR(26)), 1, 19) AS TIMESTAMP(0)) AS start_time_
,Cast(Substring(Cast(t1.bon_ende AS CHAR(26)), 1, 19) AS TIMESTAMP(0)) AS end_time_
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
WHERE Cast(bon_ende AS DATE) = Cast(scan_ende AS DATE)
)t1_1
    INNER JOIN _zeit_$_1{TRANSIENT_TABLE_SUFFIX} t2
 ON  ((to_timestamp((to_char(t1.bon_ende , 'YYYY-MM_1-DD') || ' ' || t2.end_time)) + INTERVAL '1 SECOND') >= t1.bon_ende
 AND to_timestamp((to_char(t1.scan_ende , 'YYYY-MM_1-DD') || ' ' || t2.start_time)) <= t1.bon_ende)
 OR ((to_timestamp((to_char(t1.bon_ende , 'YYYY-MM_1-DD') || ' ' || t2.end_time)) + INTERVAL '1 SECOND') >= t1.scan_ende
 AND to_timestamp((to_char(t1.scan_ende , 'YYYY-MM_1-DD') || ' ' || t2.start_time)) <= t1.scan_ende)
 WHERE start_time_ < end_time_
 ) dt1
GROUP BY 1,2,3,4,5,6,7,8
;



