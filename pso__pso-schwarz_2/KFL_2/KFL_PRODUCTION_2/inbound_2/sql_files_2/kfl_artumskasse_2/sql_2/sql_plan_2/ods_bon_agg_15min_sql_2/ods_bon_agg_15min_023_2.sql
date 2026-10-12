--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS dbp_etl.ods_bon_15min_agg_2;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE TABLE dbp_etl.ods_bon_15min_agg_2  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      kasse_nr SMALLINT NOT NULL ,
      kasse_typ_id BYTEINT NOT NULL ,
      umsatz_brutto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      anz_artikel INTEGER NOT NULL,
      anz_kunden INTEGER NOT NULL,
      kassierzeit INTEGER NOT NULL,
      registrierzeit INTEGER NOT NULL,
      zahlzeit INTEGER NOT NULL,
      bonanzahl_sug INTEGER NOT NULL)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO dbp_etl.ods_bon_15min_agg_2
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,mandant_id
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug
)
SELECT 
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,mandant_id
   ,kasse_nr
   ,kasse_typ_id
   ,Sum(umsatz_brutto  ) AS umsatz_brutto
   ,Sum(umsatz_netto   ) AS umsatz_netto
   ,Sum(anz_artikel    ) AS anz_artikel 
   ,Sum(anz_kunden     ) AS anz_kunden 
   ,Sum(kassierzeit    ) AS kassierzeit
   ,Sum(registrierzeit ) AS registrierzeit
   ,Sum(zahlzeit       ) AS zahlzeit
   ,Sum(bonanzahl_sug  ) AS bonanzahl_sug
FROM dbp_etl.ods_bon_agg_15min_2

WHERE kassensystem_name IN ('','KPOS','LUCAS','POSITION')

GROUP BY 1,2,3,4,5,6,7;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM dbp_etl.ods_bon_15min_agg_2
WHERE umsatz_brutto = 0 AND
      anz_artikel = 0 AND
      kassierzeit = 900 AND
     (mandant_id,wup_id,dat,kasse_nr) IN (SELECT mandant_id,wup_id,dat,kasse_nr FROM _kill_zombies_$_2{TRANSIENT_TABLE_SUFFIX})
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE dbp_etl.ods_bon_15min_agg_2 SET kassierzeit = 900
WHERE kassierzeit > 900
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE dbp_etl.ods_bon_15min_agg_2 SET registrierzeit = 0,
                                     zahlzeit = 0
WHERE umsatz_brutto = 0
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM dbp_etl.ods_bon_15min_agg_2
WHERE zeit_stunde <= 1
AND anz_kunden = 0
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM dbp_ods.ods_bon_agg_15min_2
WHERE
(
   dat
  ,wup_id
  ,mandant_id
  ,zeit_stunde
  ,zeit_15min
  ,kasse_nr
)
IN (
SELECT DISTINCT
    dat
   ,wup_id
   ,mandant_id
   ,zeit_stunde
   ,zeit_15min
   ,kasse_nr
FROM dbp_etl.ods_bon_agg_15min_2
WHERE zeit_stunde <= 1
)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM dbp_ods.ods_bon_agg_15min_2
WHERE dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE-1
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO dbp_ods.ods_bon_agg_15min_2
(
    dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,mandant_id
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug_okf
)
SELECT
    dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,mandant_id
   ,kasse_nr
   ,kasse_typ_id
   ,umsatz_brutto
   ,umsatz_netto
   ,anz_artikel
   ,anz_kunden
   ,kassierzeit
   ,registrierzeit
   ,zahlzeit
   ,bonanzahl_sug
FROM dbp_etl.ods_bon_15min_agg_2
WHERE dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE-1
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _obsolet_$_2{TRANSIENT_TABLE_SUFFIX} AS (
SELECT *
FROM dbp_ods.ods_bon_transaction_2
WHERE transaction_name IN ('SignOffTransaction            ','SignOnTransaction             ','OperatorLock                  ','OperatorUnlock                ','PosUnlockTransaction          ','PosLockTransaction            ') AND
      bon_dat BETWEEN (SELECT MIN(bon_dat) FROM dbp_etl.bon_agg_kassenberichte_tmp_2) AND (SELECT MAX(bon_dat) FROM dbp_etl.bon_agg_kassenberichte_tmp_2)
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM dbp_ods.ods_bon_agg_15min_2
WHERE (wup_id,mandant_id,kasse_nr,dat) NOT IN (SELECT wup_id,mandant_id,kasse_nr,bon_dat FROM _obsolet_$_2{TRANSIENT_TABLE_SUFFIX}) AND
       dat BETWEEN (SELECT MIN(bon_dat) FROM dbp_etl.bon_agg_kassenberichte_tmp_2) AND (SELECT MAX(bon_dat) FROM dbp_etl.bon_agg_kassenberichte_tmp_2) AND
       umsatz_brutto = 0 AND
       anz_artikel = 0 AND
       kassierzeit <> 0 AND
       kassierzeit <> 900
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM dbp_ods.ods_bon_agg_15min_2
WHERE (wup_id,mandant_id,kasse_nr,dat) IN (
SELECT wup_id,
       mandant_id,
       kasse_nr,
       dat
FROM dbp_ods.ods_bon_agg_15min_2
WHERE (wup_id,mandant_id,kasse_nr,dat) NOT IN (SELECT wup_id,mandant_id,kasse_nr,bon_dat FROM _obsolet_$_2{TRANSIENT_TABLE_SUFFIX}) AND
       dat BETWEEN (SELECT MIN(bon_dat) FROM dbp_etl.bon_agg_kassenberichte_tmp_2) AND (SELECT MAX(bon_dat) FROM dbp_etl.bon_agg_kassenberichte_tmp_2) AND
       umsatz_brutto = 0 AND
       anz_artikel = 0 AND
       kassierzeit <> 0
GROUP BY 1,2,3,4
HAVING Min(zeit_stunde) NOT IN (0,1))
;



