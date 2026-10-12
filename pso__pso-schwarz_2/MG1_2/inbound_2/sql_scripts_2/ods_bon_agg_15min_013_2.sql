--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.bon_agg_kassierzeiten_2;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE TABLE DBP_ETL.bon_agg_kassierzeiten_2  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL,
      kasse_typ_id BYTEINT ,
      bon_dat DATE NOT NULL,
      bon_beginn TIMESTAMP(6),
      bon_ende TIMESTAMP(6),
      scan_ende TIMESTAMP(6)
)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_ETL.bon_agg_kassierzeiten_2
(
mandant_id 
,wup_id 
,kassensystem_name
,kasse_nr 
,kasse_typ_id 
,bon_dat 
,bon_beginn 
,bon_ende
,scan_ende 
)

SELECT 
 k.mandant_id
,k.wup_id
,t.kassensystem_name
,k.kasse_nr
,k.kasse_typ_id
,k.bon_dat
,Cast(k.bon_beginn AS TIMESTAMP(6)) AS bon_beginn
,Cast(k.bon_ende AS TIMESTAMP(6)) AS bon_ende
,Max(Coalesce(Coalesce(Coalesce(v.start_bon_zeile,r.start_bon_zeile),f.start_bon_zeile),k.bon_beginn)) AS scan_ende
FROM DBP_ODS.ods_bon_kopf_2 k

LEFT JOIN DBP_ODS.ods_bon_transaction_2 t
ON t.bon_id = k.bon_id
AND t.wup_id = k.wup_id
AND t.mandant_id = k.mandant_id

LEFT JOIN DBP_ODS.ods_bon_verkauf_2 v
ON v.bon_id = k.bon_id
AND v.wup_id = k.wup_id
AND v.mandant_id = k.mandant_id

LEFT JOIN DBP_ODS.ods_bon_retoure_2 r
ON r.bon_id = k.bon_id
AND r.wup_id = k.wup_id
AND r.mandant_id = k.mandant_id

LEFT JOIN DBP_ODS.ods_bon_financial_2 f
ON f.bon_id = k.bon_id
AND f.wup_id = k.wup_id 
AND f.mandant_id = k.mandant_id

WHERE k.reactivated_fg = 0 AND 
      k.bon_dat BETWEEN CURRENT_DATE-15 AND CURRENT_DATE-1 AND
      v.bon_dat BETWEEN CURRENT_DATE-15 AND CURRENT_DATE-1 AND
      t.bon_dat BETWEEN CURRENT_DATE-15 AND CURRENT_DATE-1 AND
     (k.mandant_id,k.wup_id,t.kassensystem_name,k.kasse_nr,k.bon_dat) IN
(SELECT
    mandant_id
   ,wup_id
   ,kassensystem_name
   ,kasse_nr
   ,bon_dat
FROM DBP_ETL.bon_agg_kassenberichte_2)

GROUP BY 1,2,3,4,5,6,7,8
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO  DBP_ETL.bon_agg_kassierzeiten_2
(
mandant_id 
,wup_id
,kassensystem_name 
,kasse_nr 
,kasse_typ_id 
,bon_dat
,bon_beginn 
,scan_ende
,bon_ende 
)
SELECT mandant_id
,wup_id
,kassensystem_name
,kasse_nr
,kasse_typ_id
,bon_dat
,bon_beginn
,to_timestamp(to_char(bon_beginn, 'YYYY-MM_2-DD') || ' 23:59:59' ) AS scan_ende
,bon_ende
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
FROM  DBP_ETL.bon_agg_kassierzeiten_2
WHERE Cast(scan_ende AS DATE) > Cast(bon_beginn AS DATE)
) s1

UNION ALL

SELECT mandant_id
,wup_id
,kassensystem_name
,kasse_nr
,kasse_typ_id
,bon_dat
,to_timestamp(to_char(scan_ende , 'YYYY-MM_2-DD') || ' 00:00:00' ) AS bon_beginn
,scan_ende
,bon_ende
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
FROM DBP_ETL.bon_agg_kassierzeiten_2
WHERE Cast(scan_ende AS DATE) > Cast(bon_beginn AS DATE)
) s1

UNION ALL

SELECT mandant_id
,wup_id
,kassensystem_name
,kasse_nr
,kasse_typ_id
,bon_dat
,bon_beginn
,scan_ende
,to_timestamp(to_char(scan_ende, 'YYYY-MM_2-DD') || ' 23:59:59') AS bon_ende
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
FROM DBP_ETL.bon_agg_kassierzeiten_2
WHERE Cast(scan_ende AS DATE) < Cast(bon_ende AS DATE)
) s1

UNION ALL

SELECT mandant_id
,wup_id
,kassensystem_name
,kasse_nr
,kasse_typ_id
,bon_dat
,bon_beginn
,to_timestamp(to_char(bon_ende , 'YYYY-MM_2-DD') || ' 00:00:00' ) AS scan_ende
,bon_ende
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
FROM DBP_ETL.bon_agg_kassierzeiten_2
WHERE Cast(scan_ende AS DATE) < Cast(bon_ende AS DATE)
) s1;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE OR REPLACE TRANSIENT TABLE _zeit_$_2{TRANSIENT_TABLE_SUFFIX} AS (
SELECT 
      zeit_stunde
     ,zeit_minute
     ,CASE WHEN zeit_stunde<10
           THEN '0' || Trim(zeit_stunde)
           ELSE Trim(zeit_stunde)
      END || ':' ||
      CASE WHEN zeit_minute<10
           THEN '0' || Trim(zeit_minute)
           ELSE Trim(zeit_minute)
      END || ':00' start_time
     ,CASE WHEN zeit_stunde<10
           THEN '0' || Trim(zeit_stunde)
           ELSE Trim(zeit_stunde)
      END || ':' ||
      CASE WHEN zeit_minute = 0 THEN '14:59'
           WHEN zeit_minute = 15 THEN '29:59'
           WHEN zeit_minute = 30 THEN '44:59'
           WHEN zeit_minute = 45 THEN '59:59'
      END AS end_time
  FROM DBP_DATA.zeit_2
);

