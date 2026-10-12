--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.ods_bon_sign_on_off_time_1;
--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE TABLE DBP_ETL.ods_bon_sign_on_off_time_1  (
      wup_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT,
      kasse_typ_id BYTEINT,
      start_time TIMESTAMP(0) NOT NULL,
      end_time TIMESTAMP(0) NOT NULL
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : MSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS width PRECEDING)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
INSERT INTO DBP_ETL.ods_bon_sign_on_off_time_1
(
    mandant_id
   ,wup_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,start_time
   ,end_time
)
SELECT
    t1.mandant_id
   ,t1.wup_id
   ,t1.kassensystem_name
   ,t1.kasse_nr
   ,t1.kasse_typ_id
   ,t1.bon_ende AS start_time
   ,Max(Coalesce(t2.bon_ende,t3.bon_ende,to_timestamp(to_date(t1.bon_ende) || ' 23:59:59') )) AS end_time
FROM 
(
 SELECT
     wup_id
    ,bon_dat
    ,mandant_id
	,kassensystem_name
    ,kasse_nr
    ,kasse_typ_id
    ,bon_ende
    ,bon_nr
   -- ,MSum(bon_nr,2,bon_nr DESC)-bon_nr  folgeBon  --original from TD
    ,lead(bon_nr) over (partition by wup_id,mandant_id,kasse_nr,bon_dat order by bon_nr DESC)-bon_nr  folgeBon
    ,CASE WHEN folgeBon=0 THEN 99999999 ELSE folgeBon END folge_bon_nr
 FROM DBP_ETL.ods_bon_sign_on_off_1
 WHERE transaction_name IN ('SignOnTransaction             ')
-- GROUP BY wup_id,mandant_id,kasse_nr,bon_dat
) t1_1
   LEFT OUTER JOIN 
(SELECT *
 FROM DBP_ETL.ods_bon_sign_on_off_1
 WHERE transaction_name IN ('SignOffTransaction            ')
) t2
 ON  t1.wup_id=t2.wup_id
 AND t1.mandant_id=t2.mandant_id 
 AND t1.kassensystem_name=t2.kassensystem_name 
 AND t1.kasse_nr=t2.kasse_nr
 AND t2.bon_nr BETWEEN t1.bon_nr AND  t1.folge_bon_nr
 AND t2.bon_dat =t1.bon_dat
   LEFT OUTER JOIN 
(SELECT *
 FROM DBP_ETL.ods_bon_sign_on_off_1
 WHERE transaction_name IN ('SignOnTransaction           ')
) t3
 ON  t1.wup_id=t3.wup_id
 AND t1.mandant_id=t3.mandant_id 
 AND t1.kassensystem_name = t3.kassensystem_name
 AND t1.kasse_nr=t3.kasse_nr
 AND t3.bon_nr= t1.folge_bon_nr
 AND t3.bon_dat =t1.bon_dat
GROUP BY 1,2,3,4,5,6
;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _kill_zombies_$_1{TRANSIENT_TABLE_SUFFIX} AS (
SELECT wup_id,
       mandant_id,
       kasse_nr,
       Cast(start_time AS DATE) AS dat
FROM DBP_ETL.ods_bon_sign_on_off_time_1
WHERE LPad(Cast(HOUR ( start_time)   AS VARCHAR(2)),2,'0')||':'||
      LPad(Cast(MINUTE ( start_time) AS VARCHAR(2)),2,'0')||':'||
      LPad(Cast(SECOND ( start_time) AS VARCHAR(2)),2,'0') = '00:00:00' AND
      LPad(Cast(HOUR ( end_time)     AS VARCHAR(2)),2,'0')||':'||
      LPad(Cast(MINUTE ( end_time)   AS VARCHAR(2)),2,'0')||':'||
      LPad(Cast(SECOND ( end_time) AS VARCHAR(2)),2,'0') = '23:59:59'
);
