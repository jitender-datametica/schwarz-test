--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.ods_bon_agg_15min;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.ods_bon_agg_15min (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    kassensystem_name STRING(10),
    kasse_nr INTEGER NOT NULL,
    kasse_typ_id INTEGER NOT NULL,
    umsatz_brutto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    umsatz_netto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    anz_artikel INTEGER NOT NULL,
    anz_kunden INTEGER NOT NULL,
    kassierzeit INTEGER NOT NULL,
    registrierzeit INTEGER NOT NULL,
    zahlzeit INTEGER NOT NULL,
    bonanzahl_sug INTEGER NOT NULL
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO dbp_etl.ods_bon_agg_15min (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id,
    kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit,
    registrierzeit, zahlzeit, bonanzahl_sug
)
(SELECT
    dat,
    zeit_stunde,
    zeit_15min,
    mandant_id,
    wup_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    umsatz_brutto,
    umsatz_netto,
    anz_artikel,
    anz_kunden,
    0 AS kassierzeit,
    0 AS registrierzeit,
    0 AS zahlzeit,
    bonanzahl_sug
FROM dbp_etl.ods_bon_agg_15min_umsatz AS T1);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO dbp_etl.ods_bon_agg_15min (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id,
    kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit,
    registrierzeit, zahlzeit, bonanzahl_sug
)
(SELECT
    dat,
    zeit_stunde,
    zeit_15min,
    mandant_id,
    wup_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    0 AS umsatz_brutto,
    0 AS umsatz_netto,
    0 AS anz_artikel,
    0 AS anz_kunden,
    kassierzeit,
    0 AS registrierzeit,
    0 AS zahlzeit,
    0 AS bonanzahl_sug
FROM dbp_etl.ods_bon_agg_15min_kassierzeit AS T1);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO dbp_etl.ods_bon_agg_15min (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id,
    kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit,
    registrierzeit, zahlzeit, bonanzahl_sug
)
(SELECT
    dat,
    zeit_stunde,
    zeit_15min,
    mandant_id,
    wup_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    0 AS umsatz_brutto,
    0 AS umsatz_netto,
    0 AS anz_artikel,
    0 AS anz_kunden,
    0 AS kassierzeit,
    scanzeit AS registrierzeit,
    0 AS zahlzeit,
    0 AS bonanzahl_sug
FROM dbp_etl.ods_bon_agg_15min_scanzeit AS T1);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO dbp_etl.ods_bon_agg_15min (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id,
    kassensystem_name, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit,
    registrierzeit, zahlzeit, bonanzahl_sug
)
(SELECT
    dat,
    zeit_stunde,
    zeit_15min,
    mandant_id,
    wup_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    0 AS umsatz_brutto,
    0 AS umsatz_netto,
    0 AS anz_artikel,
    0 AS anz_kunden,
    0 AS kassierzeit,
    0 AS registrierzeit,
    zahlzeit,
    0 AS bonanzahl_sug
FROM dbp_etl.ods_bon_agg_15min_zahlzeit AS T1);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)


CREATE OR REPLACE TABLE dbp_etl.`_kasse_track_1_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    t0.mandant_id,
    t0.wup_id,
    t0.dat,
    t0.kasse_nr,
    t0.kasse_typ_id,
    t0.dfl,
    COUNT(t0.kasse_typ_id) OVER (PARTITION BY t0.mandant_id, t0.wup_id, t0.dat, t0.kasse_nr ORDER BY
        t0.mandant_id IS NULL,
        t0.mandant_id, t0.wup_id IS NULL, t0.wup_id, t0.dat IS NULL, t0.dat, t0.kasse_nr IS NULL, t0.kasse_nr
    RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS anz_kt,
    t0.anz_bons,
    DENSE_RANK() OVER (
        PARTITION BY
            t0.mandant_id, t0.wup_id, t0.dat, t0.kasse_nr ORDER BY
            t0.anz_bons IS NULL DESC, t0.anz_bons
            DESC
    ) AS rang_anz_bons,
    DENSE_RANK() OVER (PARTITION BY t0.mandant_id, t0.wup_id, t0.dat, t0.kasse_nr ORDER BY t0.dfl IS NULL, t0.dfl)
        AS
        rang_anz_dfl
FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.dat,
        A.kasse_nr,
        A.kasse_typ_id,
        COALESCE(B.durchfalllogik_id, 99) AS dfl,
        SUM(A.bonanzahl_sug) AS anz_bons
    FROM dbp_etl.ods_bon_agg_15min AS A
    LEFT JOIN dbp_ods.l_kasse_typ AS B ON A.kasse_typ_id = B.kasse_typ_id
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.dat,
        A.kasse_nr,
        A.kasse_typ_id,
        dfl
) AS t0;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)


CREATE OR REPLACE TABLE dbp_etl.`_kasse_track_step1_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    mandant_id,
    wup_id,
    dat,
    kasse_nr,
    kasse_typ_id
FROM dbp_etl.`_kasse_track_1_${TRANSIENT_TABLE_SUFFIX}`
WHERE
    anz_kt = 1
    OR anz_kt > 1 AND kasse_typ_id = 2;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


DELETE FROM dbp_etl.`_kasse_track_1_${TRANSIENT_TABLE_SUFFIX}`
WHERE (
    mandant_id, wup_id, dat, kasse_nr) IN (
    SELECT (mandant_id, wup_id, dat, kasse_nr)
    FROM dbp_etl.`_kasse_track_step1_${TRANSIENT_TABLE_SUFFIX}`
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TABLE dbp_etl.`_kasse_track_step2_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    mandant_id,
    wup_id,
    dat,
    kasse_nr,
    kasse_typ_id
FROM dbp_etl.`_kasse_track_1_${TRANSIENT_TABLE_SUFFIX}`
WHERE
    anz_kt > 1
    AND rang_anz_bons = 1
GROUP BY
    mandant_id,
    wup_id,
    dat,
    kasse_nr,
    kasse_typ_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


DELETE FROM dbp_etl.`_kasse_track_1_${TRANSIENT_TABLE_SUFFIX}`
WHERE (
    mandant_id, wup_id, dat, kasse_nr) IN (
    SELECT (mandant_id, wup_id, dat, kasse_nr)
    FROM dbp_etl.`_kasse_track_step2_${TRANSIENT_TABLE_SUFFIX}`
    GROUP BY
        mandant_id,
        wup_id,
        dat,
        kasse_nr
    HAVING COUNT(*) = 1
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TABLE dbp_etl.`_kasse_track_step3_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    mandant_id,
    wup_id,
    dat,
    kasse_nr,
    kasse_typ_id
FROM dbp_etl.`_kasse_track_1_${TRANSIENT_TABLE_SUFFIX}`
WHERE
    anz_kt > 1
    AND rang_anz_bons = 1
    AND rang_anz_dfl = 1
GROUP BY
    mandant_id,
    wup_id,
    dat,
    kasse_nr,
    kasse_typ_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


DELETE FROM dbp_etl.`_kasse_track_step2_${TRANSIENT_TABLE_SUFFIX}`
WHERE (
    mandant_id, wup_id, dat, kasse_nr) IN (
    SELECT (mandant_id, wup_id, dat, kasse_nr)
    FROM dbp_etl.`_kasse_track_step3_${TRANSIENT_TABLE_SUFFIX}`
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE OR REPLACE TABLE dbp_etl.`_kasse_track_final_${TRANSIENT_TABLE_SUFFIX}` AS
(
    SELECT *
    FROM dbp_etl.`_kasse_track_step1_${TRANSIENT_TABLE_SUFFIX}`
    UNION DISTINCT
    SELECT *
    FROM dbp_etl.`_kasse_track_step2_${TRANSIENT_TABLE_SUFFIX}`
)
UNION DISTINCT
SELECT *
FROM dbp_etl.`_kasse_track_step3_${TRANSIENT_TABLE_SUFFIX}`;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_etl.ods_bon_agg_15min SET
    kasse_typ_id = x.kasse_typ_id_ FROM (SELECT
    mandant_id AS mandant_id_,
    wup_id AS wup_id_,
    dat AS dat_,
    kasse_nr AS kasse_nr_,
    kasse_typ_id AS kasse_typ_id_
FROM dbp_etl.`_kasse_track_final_${TRANSIENT_TABLE_SUFFIX}` AS R) AS x
WHERE
    ods_bon_agg_15min.mandant_id = x.mandant_id_ AND ods_bon_agg_15min.wup_id = x.wup_id_ AND ods_bon_agg_15min.dat =
    x.dat_ AND ods_bon_agg_15min.kasse_nr = x.kasse_nr_;
