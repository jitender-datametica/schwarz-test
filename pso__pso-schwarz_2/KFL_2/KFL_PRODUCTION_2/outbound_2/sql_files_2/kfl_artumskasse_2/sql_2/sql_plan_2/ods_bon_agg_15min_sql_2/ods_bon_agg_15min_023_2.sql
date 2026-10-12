--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.ods_bon_15min_agg_2;


CREATE TABLE IF NOT EXISTS dbp_etl.ods_bon_15min_agg_2 (
    dat DATE NOT NULL,
    zeit_stunde INTEGER NOT NULL,
    zeit_15min INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
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


INSERT INTO dbp_etl.ods_bon_15min_agg_2 (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, kasse_nr,
    kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit, registrierzeit, zahlzeit,
    bonanzahl_sug
)
(
    SELECT
        dat,
        zeit_stunde,
        zeit_15min,
        mandant_id,
        wup_id,
        kasse_nr,
        kasse_typ_id,
        SUM(umsatz_brutto) AS umsatz_brutto,
        SUM(umsatz_netto) AS umsatz_netto,
        SUM(anz_artikel) AS anz_artikel,
        SUM(anz_kunden) AS anz_kunden,
        SUM(kassierzeit) AS kassierzeit,
        SUM(registrierzeit) AS registrierzeit,
        SUM(zahlzeit) AS zahlzeit,
        SUM(bonanzahl_sug) AS bonanzahl_sug
    FROM dbp_etl.ods_bon_agg_15min_2
    WHERE kassensystem_name IN ('', 'KPOS', 'LUCAS', 'POSITION')
    GROUP BY
        dat,
        zeit_stunde,
        zeit_15min,
        mandant_id,
        wup_id,
        kasse_nr,
        kasse_typ_id
);


DELETE FROM dbp_etl.ods_bon_15min_agg_2
WHERE umsatz_brutto = 0 AND anz_artikel = 0 AND kassierzeit = 900 AND (mandant_id, wup_id, dat, kasse_nr) IN (SELECT (
    mandant_id,
    wup_id, dat, kasse_nr
)
FROM dbp_etl.`_kill_zombies_$_2{TRANSIENT_TABLE_SUFFIX}`);


UPDATE dbp_etl.ods_bon_15min_agg_2 SET
    kassierzeit = 900
WHERE kassierzeit > 900;


UPDATE dbp_etl.ods_bon_15min_agg_2 SET
    registrierzeit = 0,
    zahlzeit = 0
WHERE umsatz_brutto = 0;


DELETE FROM dbp_etl.ods_bon_15min_agg_2
WHERE zeit_stunde <= 1 AND anz_kunden = 0;


DELETE FROM dbp_ods.ods_bon_agg_15min_2
WHERE (dat, wup_id, mandant_id, zeit_stunde, zeit_15min, kasse_nr) IN (SELECT (
    dat, wup_id, mandant_id,
    zeit_stunde, zeit_15min, kasse_nr
)
FROM (SELECT DISTINCT
    dat,
    wup_id,
    mandant_id,
    zeit_stunde,
    zeit_15min,
    kasse_nr
FROM dbp_etl.ods_bon_agg_15min_2
WHERE zeit_stunde <= 1) AS t1_2);


DELETE FROM dbp_ods.ods_bon_agg_15min_2
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 14 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY));


INSERT INTO dbp_ods.ods_bon_agg_15min_2 (
    dat, zeit_stunde, zeit_15min, mandant_id, wup_id, kasse_nr,
    kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit, registrierzeit, zahlzeit,
    bonanzahl_sug_okf
)
(
    SELECT *
    FROM dbp_etl.ods_bon_15min_agg_2
    WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 14 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
);


CREATE OR REPLACE TABLE dbp_etl.`_obsolet_$_2{TRANSIENT_TABLE_SUFFIX}` AS
SELECT *
FROM dbp_ods.ods_bon_transaction_2
WHERE transaction_name IN (
    'SignOffTransaction            ', 'SignOnTransaction             ',
    'OperatorLock                  ', 'OperatorUnlock                ', 'PosUnlockTransaction          ',
    'PosLockTransaction            '
)
AND bon_dat BETWEEN (
    SELECT MIN(bon_dat)
    FROM dbp_etl.bon_agg_kassenberichte_tmp_2) AND (
    SELECT MAX(bon_dat)
    FROM dbp_etl.bon_agg_kassenberichte_tmp_2
);


DELETE FROM dbp_ods.ods_bon_agg_15min_2
WHERE dat BETWEEN (
    SELECT MIN(bon_dat)
    FROM dbp_etl.bon_agg_kassenberichte_tmp_2) AND (
    SELECT MAX(bon_dat)
    FROM dbp_etl.bon_agg_kassenberichte_tmp_2
) AND umsatz_brutto = 0 AND anz_artikel = 0 AND kassierzeit
NOT IN (
    0, 900) AND (wup_id, mandant_id, kasse_nr, dat) NOT IN (
    SELECT (wup_id, mandant_id, kasse_nr, bon_dat)
    FROM dbp_etl.`_obsolet_$_2{TRANSIENT_TABLE_SUFFIX}`
);


DELETE FROM dbp_ods.ods_bon_agg_15min_2
WHERE (
    wup_id, mandant_id, kasse_nr, dat) IN (
    SELECT (wup_id, mandant_id, kasse_nr, dat)
    FROM dbp_ods.ods_bon_agg_15min_2
    WHERE
        dat BETWEEN (
            SELECT MIN(bon_dat)
            FROM dbp_etl.bon_agg_kassenberichte_tmp_2) AND (
            SELECT MAX(bon_dat)
            FROM dbp_etl.bon_agg_kassenberichte_tmp_2
        )
        AND umsatz_brutto = 0
        AND anz_artikel = 0
        AND kassierzeit <> 0
        AND (
            wup_id, mandant_id, kasse_nr, dat) NOT IN (
            SELECT (wup_id, mandant_id, kasse_nr, bon_dat)
            FROM dbp_etl.`_obsolet_$_2{TRANSIENT_TABLE_SUFFIX}`
        )
    GROUP BY
        dat,
        mandant_id,
        wup_id,
        kasse_nr
    HAVING MIN(zeit_stunde) NOT IN (0, 1)
);
