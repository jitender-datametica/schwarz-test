--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS dbp_etl.ods_bon_agg_15min_1;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE dbp_etl.ods_bon_agg_15min_1  (
      dat DATE NOT NULL,
      zeit_stunde BYTEINT NOT NULL,
      zeit_15min BYTEINT NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      kassensystem_name CHAR(10),
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
INSERT INTO dbp_etl.ods_bon_agg_15min_1
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,mandant_id
   ,kassensystem_name
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
    t1.dat           AS dat
   ,t1.zeit_stunde   AS zeit_stunde
   ,t1.zeit_15min    AS zeit_15min
   ,t1.wup_id        AS wup_id
   ,t1.mandant_id    AS mandant_id
   ,t1.kassensystem_name AS kassensystem_name
   ,t1.kasse_nr      AS kasse_nr
   ,t1.kasse_typ_id  AS kasse_typ_id
   ,t1.umsatz_brutto AS umsatz_brutto
   ,t1.umsatz_netto  AS umsatz_netto
   ,t1.anz_artikel   AS anz_artikel
   ,t1.anz_kunden    AS anz_kunden
   ,0 AS kassierzeit
   ,0 AS registrierzeit
   ,0 AS zahlzeit
   ,t1.bonanzahl_sug
FROM dbp_etl.ods_bon_agg_15min_umsatz_1 t1_1;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO dbp_etl.ods_bon_agg_15min_1
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,mandant_id
   ,kassensystem_name
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
    t1.dat           AS dat
   ,t1.zeit_stunde   AS zeit_stunde
   ,t1.zeit_15min    AS zeit_15min
   ,t1.wup_id        AS wup_id
   ,t1.mandant_id    AS mandant_id
   ,t1.kassensystem_name AS kassensystem_name
   ,t1.kasse_nr      AS kasse_nr
   ,t1.kasse_typ_id  AS kasse_typ_id
   ,0 AS umsatz_brutto
   ,0 AS umsatz_netto
   ,0 AS anz_artikel
   ,0 AS anz_kunden
   ,t1.kassierzeit AS kassierzeit
   ,0 AS registrierzeit
   ,0 AS zahlzeit
   ,0 AS bonanzahl_sug
FROM dbp_etl.ods_bon_agg_15min_kassierzeit_1 t1_1;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO dbp_etl.ods_bon_agg_15min_1
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,mandant_id
   ,kassensystem_name
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
    t1.dat
   ,t1.zeit_stunde
   ,t1.zeit_15min 
   ,t1.wup_id 
   ,t1.mandant_id
   ,t1.kassensystem_name
   ,t1.kasse_nr 
   ,t1.kasse_typ_id
   ,0 AS umsatz_brutto
   ,0 AS umsatz_netto
   ,0 AS anz_artikel
   ,0 AS anz_kunden
   ,0 AS kassierzeit
   ,scanzeit AS registrierzeit
   ,0 AS zahlzeit
   ,0 AS bonanzahl_sug
FROM dbp_etl.ods_bon_agg_15min_scanzeit_1 t1_1;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO dbp_etl.ods_bon_agg_15min_1
(
   dat
   ,zeit_stunde
   ,zeit_15min
   ,wup_id
   ,mandant_id
   ,kassensystem_name
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
    t1.dat
   ,t1.zeit_stunde
   ,t1.zeit_15min 
   ,t1.wup_id 
   ,t1.mandant_id
   ,t1.kassensystem_name
   ,t1.kasse_nr 
   ,t1.kasse_typ_id
   ,0 AS umsatz_brutto
   ,0 AS umsatz_netto
   ,0 AS anz_artikel
   ,0 AS anz_kunden
   ,0 AS kassierzeit
   ,0 AS registrierzeit
   ,zahlzeit AS zahlzeit
   ,0 AS bonanzahl_sug
FROM dbp_etl.ods_bon_agg_15min_zahlzeit_1 t1_1;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _kasse_track_1_$_1{TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id,
       a.wup_id,
       a.dat,
       a.kasse_nr,
       a.kasse_typ_id,
       COALESCE(b.durchfalllogik_id,99) AS dfl,
       COUNT(a.kasse_typ_id) OVER (PARTITION BY a.mandant_id,a.wup_id,a.dat,a.kasse_nr ORDER BY a.mandant_id,a.wup_id,a.dat,a.kasse_nr) AS anz_kt,
       SUM(a.bonanzahl_sug) AS anz_bons,
       DENSE_RANK() OVER (PARTITION BY a.mandant_id,a.wup_id,a.dat,a.kasse_nr ORDER BY anz_bons DESC) AS rang_anz_bons,
       DENSE_RANK() OVER (PARTITION BY a.mandant_id,a.wup_id,a.dat,a.kasse_nr ORDER BY dfl ASC) AS rang_anz_dfl
FROM dbp_etl.ods_bon_agg_15min_1 a
LEFT JOIN dbp_ods.l_kasse_typ_1 b
  ON a.kasse_typ_id = b.kasse_typ_id
GROUP BY 1,2,3,4,5,6
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _kasse_track_step1_$_1{TRANSIENT_TABLE_SUFFIX} AS (
SELECT mandant_id,
       wup_id,
       dat,
       kasse_nr,
       kasse_typ_id
FROM _kasse_track_1_$_1{TRANSIENT_TABLE_SUFFIX}
WHERE anz_kt = 1 OR
     (anz_kt > 1 AND
      kasse_typ_id = 2)
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM _kasse_track_1_$_1{TRANSIENT_TABLE_SUFFIX}
WHERE (mandant_id,wup_id,dat,kasse_nr) IN (SELECT mandant_id,wup_id,dat,kasse_nr FROM _kasse_track_step1_$_1{TRANSIENT_TABLE_SUFFIX})
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE OR REPLACE TRANSIENT TABLE _kasse_track_step2_$_1{TRANSIENT_TABLE_SUFFIX} AS (
SELECT mandant_id,
       wup_id,
       dat,
       kasse_nr,
       kasse_typ_id
FROM _kasse_track_1_$_1{TRANSIENT_TABLE_SUFFIX}
WHERE anz_kt > 1 AND
      rang_anz_bons = 1
GROUP BY 1,2,3,4,5
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM _kasse_track_1_$_1{TRANSIENT_TABLE_SUFFIX}
WHERE (mandant_id,wup_id,dat,kasse_nr) IN (SELECT mandant_id,wup_id,dat,kasse_nr FROM _kasse_track_step2_$_1{TRANSIENT_TABLE_SUFFIX} GROUP BY 1,2,3,4 HAVING COUNT(*) = 1)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE OR REPLACE TRANSIENT TABLE _kasse_track_step3_$_1{TRANSIENT_TABLE_SUFFIX} AS (
SELECT mandant_id,
       wup_id,
       dat,
       kasse_nr,
       kasse_typ_id
FROM _kasse_track_1_$_1{TRANSIENT_TABLE_SUFFIX}
WHERE anz_kt > 1 AND
      rang_anz_bons = 1 AND
      rang_anz_dfl = 1
GROUP BY 1,2,3,4,5
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM _kasse_track_step2_$_1{TRANSIENT_TABLE_SUFFIX}
WHERE (mandant_id,wup_id,dat,kasse_nr) IN (SELECT mandant_id,wup_id,dat,kasse_nr FROM _kasse_track_step3_$_1{TRANSIENT_TABLE_SUFFIX})
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
CREATE OR REPLACE TRANSIENT TABLE _kasse_track_final_$_1{TRANSIENT_TABLE_SUFFIX} AS (
SELECT *
FROM _kasse_track_step1_$_1{TRANSIENT_TABLE_SUFFIX}
UNION
SELECT *
FROM _kasse_track_step2_$_1{TRANSIENT_TABLE_SUFFIX}
UNION
SELECT *
FROM _kasse_track_step3_$_1{TRANSIENT_TABLE_SUFFIX}
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE dbp_etl.ods_bon_agg_15min_1 
SET kasse_typ_id = kasse_typ_id_

FROM (SELECT r.mandant_id AS mandant_id_,
                                              r.wup_id AS wup_id_,
                                              r.dat AS dat_,
                                              r.kasse_nr AS kasse_nr_,
                                              r.kasse_typ_id AS kasse_typ_id_
                                       FROM _kasse_track_final_$_1{TRANSIENT_TABLE_SUFFIX} r) x WHERE mandant_id = mandant_id_ AND
      wup_id = wup_id_ AND
      dat = dat_ AND
      kasse_nr = kasse_nr_
;



