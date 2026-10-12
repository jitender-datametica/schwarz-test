--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.ods_bon_sign_on_off_1;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.ods_bon_sign_on_off_1  (
      bon_dat DATE NOT NULL,
      wup_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT,
      kasse_typ_id BYTEINT,
      transaction_name CHAR(30) COLLATE 'en-ci' ,
      bon_ende TIMESTAMP(0) NOT NULL,
      bon_nr INTEGER NOT NULL
)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_ETL.ods_bon_sign_on_off_1
(
    bon_dat
   ,wup_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,transaction_name
   ,bon_ende
   ,bon_nr
)
SELECT
    bon_dat
   ,wup_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,CASE WHEN transaction_name = 'OperatorLock                  ' THEN 'SignOffTransaction            '
         WHEN transaction_name = 'OperatorUnlock                ' THEN 'SignOnTransaction             '
         WHEN transaction_name = 'PosLockTransaction            ' THEN 'SignOffTransaction            '
         WHEN transaction_name = 'PosUnlockTransaction          ' THEN 'SignOnTransaction             '
		 ELSE transaction_name 
    END transaction_name
   ,bon_ende
   ,bon_nr
FROM DBP_ODS.ods_bon_transaction_1
WHERE transaction_name IN ('SignOffTransaction            ','SignOnTransaction             ','OperatorLock                  ','OperatorUnlock                ','PosUnlockTransaction          ','PosLockTransaction            ')
  AND (mandant_id,wup_id,kassensystem_name,kasse_nr,bon_dat) IN
  (SELECT
       mandant_id
      ,wup_id
	  ,kassensystem_name
      ,kasse_nr
      ,bon_dat
   FROM DBP_ETL.bon_agg_kassenberichte_1
  )
AND kassensystem_name NOT IN ('KPOS')
;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_ETL.ods_bon_sign_on_off_1
(
    bon_dat
   ,wup_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,transaction_name
   ,bon_ende
   ,bon_nr
)
SELECT
    bon_dat
   ,wup_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,CASE WHEN transaction_name = 'OperatorLock                  ' THEN 'SignOffTransaction            '
         WHEN transaction_name = 'OperatorUnlock                ' THEN 'SignOnTransaction             '
         WHEN transaction_name = 'PosLockTransaction            ' THEN 'SignOffTransaction            '
         WHEN transaction_name = 'PosUnlockTransaction          ' THEN 'SignOnTransaction             '
		 ELSE transaction_name 
    END transaction_name_
   ,bon_ende
   ,row_number() over (partition by wup_id,kasse_nr,bon_dat order by wup_id,kasse_nr,bon_ende,transaction_name_ DESC) bon_nr
FROM DBP_ODS.ods_bon_transaction_1
WHERE transaction_name IN ('SignOffTransaction            ','SignOnTransaction             ','OperatorLock                  ','OperatorUnlock                ','PosUnlockTransaction          ','PosLockTransaction            ')
  AND (mandant_id,wup_id,kassensystem_name,kasse_nr,bon_dat) IN
  (SELECT
       mandant_id
      ,wup_id
	  ,kassensystem_name
      ,kasse_nr
      ,bon_dat
   FROM DBP_ETL.bon_agg_kassenberichte_1
  )
AND kassensystem_name IN ('KPOS')
;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _fake_entries_$_1{TRANSIENT_TABLE_SUFFIX} AS (
SELECT
    bon_dat
   ,wup_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,'SignOnTransaction             'transaction_name
--   ,to_timestamp((to_date(bon_ende, 'yyyy-mm_1-dd') || ' 00:00:00')) AS bon_ende
  ,to_timestamp(to_date(bon_ende)) AS bon_ende
   ,bon_nr-1 AS bon_nr
FROM DBP_ETL.ods_bon_sign_on_off_1
WHERE (mandant_id,wup_id,kassensystem_name,kasse_nr,bon_dat,bon_nr) IN (SELECT mandant_id,
                                                                               wup_id,
                                                                               kassensystem_name,
                                                                               kasse_nr,
                                                                               bon_dat,
                                                                               Min(bon_nr) min_bon_nr
                                                                        FROM DBP_ETL.ods_bon_sign_on_off_1
                                                                        GROUP BY 1,2,3,4,5)
  AND transaction_name IN ('SignOffTransaction            ','OperatorLock                  ','PosLockTransaction            ')
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _not_applicable_$_1{TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.bon_dat+1 AS bon_dat,
       a.wup_id,
       a.mandant_id,
       a.kassensystem_name,
       a.kasse_nr,
       a.kasse_typ_id,
       a.transaction_name,
       a.bon_ende,
       a.bon_nr
FROM DBP_ETL.ods_bon_sign_on_off_1 a
JOIN (SELECT mandant_id,
             wup_id,
             kassensystem_name,
             kasse_nr,
             bon_dat,
             Max(bon_nr) min_bon_nr
      FROM DBP_ETL.ods_bon_sign_on_off_1
      GROUP BY 1,2,3,4,5) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.kassensystem_name = b.kassensystem_name AND
     a.kasse_nr = b.kasse_nr AND
     a.bon_dat = b.bon_dat AND
     a.bon_nr = b.min_bon_nr
WHERE a.transaction_name = 'SignOffTransaction'
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM _fake_entries_$_1{TRANSIENT_TABLE_SUFFIX}
WHERE (mandant_id,wup_id,kassensystem_name,kasse_nr,bon_dat) IN (SELECT mandant_id,wup_id,kassensystem_name,kasse_nr,bon_dat FROM _not_applicable_$_1{TRANSIENT_TABLE_SUFFIX})
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_ETL.ods_bon_sign_on_off_1
(
    bon_dat
   ,wup_id
   ,mandant_id
   ,kassensystem_name
   ,kasse_nr
   ,kasse_typ_id
   ,transaction_name
   ,bon_ende
   ,bon_nr
)
SELECT bon_dat
      ,wup_id
      ,mandant_id
      ,kassensystem_name
      ,kasse_nr
      ,kasse_typ_id
      ,transaction_name
      ,bon_ende
      ,bon_nr
FROM _fake_entries_$_1{TRANSIENT_TABLE_SUFFIX}
;


DROP TABLE IF EXISTS _fake_entries_$_1{TRANSIENT_TABLE_SUFFIX};
DROP TABLE IF EXISTS _not_applicable_$_1{TRANSIENT_TABLE_SUFFIX};





