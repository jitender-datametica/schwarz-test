--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.ods_bon_agg_15min_kassierzeit;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE TABLE DBP_ETL.ods_bon_agg_15min_kassierzeit  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      kassensystem_name CHAR(10),
      wup_id INTEGER NOT NULL,
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL,
      kassierzeit INTEGER NOT NULL)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE OR REPLACE TRANSIENT TABLE _track_it_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT
     mandant_id
	,kassensystem_name
    ,wup_id
    ,kasse_nr
    ,kasse_typ_id
    ,zeit_stunde
    ,zeit_minute
    ,Cast(t1.start_time AS DATE) bon_dat
    ,to_timestamp(to_date(t1.start_time) || ' ' || t2.start_time) zeit_scheibe_start
    ,to_timestamp(to_date(t1.start_time) || ' ' || t2.end_time) + INTERVAL '1 SECOND'   zeit_scheibe_ende
    ,t1.start_time
    ,t1.end_time
 FROM DBP_ETL.ods_bon_sign_on_off_time t1
    INNER JOIN
 (
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
  FROM DBP_DATA.zeit
 ) t2
  ON  to_timestamp(to_date(t1.start_time) || ' ' || t2.end_time) + INTERVAL '1 SECOND'  >= t1.start_time 
  AND to_timestamp(to_date(t1.start_time) || ' ' || t2.start_time) <= t1.end_time
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM _track_it_${TRANSIENT_TABLE_SUFFIX}
WHERE LPad(Cast(HOUR   ( end_time) AS VARCHAR(2)),2,'0')||':'||
      LPad(Cast(MINUTE ( end_time) AS VARCHAR(2)),2,'0')||':'||
      LPad(Cast(SECOND ( end_time) AS VARCHAR(2)),2,'0') = '23:59:59'
;


--[OK] statement is translated correctly-----------------------------------------------------------------
INSERT INTO DBP_ETL.ods_bon_agg_15min_kassierzeit
(
    dat
   ,zeit_stunde
   ,zeit_15min
   ,mandant_id
   ,kassensystem_name
   ,wup_id
   ,kasse_nr
   ,kasse_typ_id
   ,kassierzeit
 )

SELECT
    bon_dat
   ,zeit_stunde
   ,zeit_minute
   ,mandant_id
   ,kassensystem_name
   ,wup_id
   ,kasse_nr
   ,kasse_typ_id
   ,Sum( timestampdiff(second,
                      CASE WHEN zeit_scheibe_start>=start_time THEN zeit_scheibe_start ELSE start_time END, 
                      CASE WHEN zeit_scheibe_ende<=end_time THEN zeit_scheibe_ende ELSE end_time END
                     )
   )
   AS kassierzeit
FROM _track_it_${TRANSIENT_TABLE_SUFFIX}
GROUP BY 1,2,3,4,5,6,7,8
;

