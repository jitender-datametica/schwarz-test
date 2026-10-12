DROP TABLE IF EXISTS dbp_etl.kmo_marm_anr_2;

CREATE TABLE IF NOT EXISTS dbp_etl.kmo_marm_anr_2 (
    matnr INT64 NOT NULL,
    mandant_id INT64 NOT NULL,
    altnv_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL,
    bruttogew NUMERIC(29, 3) NOT NULL,
    gew_einh_id STRING(3) COLLATE 'und:ci' NOT NULL,
    umrech_faktor FLOAT64 NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    laenge NUMERIC(29, 3) NOT NULL,
    breite NUMERIC(29, 3) NOT NULL,
    hoehe NUMERIC(29, 3) NOT NULL,
    umren INT64,
    umrez INT64,
    td_insert TIMESTAMP
);

CREATE TEMPORARY TABLE IF NOT EXISTS _dup_check AS
SELECT
    a.matnr,
    a.matnr_char,
    a.quellsystem,
    a.meinh,
    a.brgew,
    a.gewei,
    a.umrez,
    a.umren,
    a.laenge,
    a.breite,
    a.hoehe,
    a.bezugsdatum,
    a.mandant_id,
    a.td_insert
FROM dbp_etl.kmo_marm_2 AS a
INNER JOIN (
    SELECT
        mandant_id,
        matnr_char,
        meinh
    FROM dbp_etl.kmo_marm_2
    GROUP BY
        matnr_char,
        meinh,
        mandant_id
    HAVING
        COUNT(*) > 1
) AS b
    ON a.mandant_id = b.mandant_id AND a.matnr_char = b.matnr_char AND a.meinh = b.meinh
QUALIFY
    (
        ROW_NUMBER() OVER (
            PARTITION BY a.mandant_id, a.matnr_char, a.meinh
            ORDER BY a.mandant_id IS NULL, a.mandant_id, a.matnr_char IS NULL, a.matnr_char, a.meinh IS NULL, a.meinh, a.bezugsdatum IS NULL DESC, a.bezugsdatum DESC
        )
    ) = 1;

DELETE FROM dbp_etl.kmo_marm_2
WHERE
    (mandant_id, matnr_char, meinh) IN (
        SELECT (mandant_id, matnr_char, meinh)
        FROM `_dup_check`
    );

INSERT INTO dbp_etl.kmo_marm_2
(
    SELECT
        matnr,
        matnr_char,
        quellsystem,
        meinh,
        brgew,
        gewei,
        umrez,
        umren,
        laenge,
        breite,
        hoehe,
        bezugsdatum,
        mandant_id,
        td_insert
    FROM `_dup_check`
);

INSERT INTO dbp_etl.kmo_marm_anr_2 (
    matnr,
    mandant_id,
    altnv_menge_einh_id,
    bruttogew,
    gew_einh_id,
    umrech_faktor,
    dat_von,
    dat_bis,
    laenge,
    breite,
    hoehe,
    umren,
    umrez
)
(
    SELECT
        matnr,
        mandant_id,
        COALESCE(SUBSTR(meinh, 1, 3), '-1') AS altnv_menge_einh_id,
        COALESCE(brgew, 0) AS bruttogew,
        COALESCE(SUBSTR(gewei, 1, 3), '-1') AS gew_einh_id,
        COALESCE(CAST(CAST(umren AS FLOAT64) / umrez AS FLOAT64), 1) AS umrech_faktor,
        DATE_SUB(bezugsdatum, INTERVAL '1' DAY),
        PARSE_DATE('%Y%m%d', '99991231') AS dat_bis,
        COALESCE(laenge, 0) AS laenge,
        COALESCE(breite, 0) AS breite,
        COALESCE(hoehe, 0) AS hoehe,
        CAST(umren AS INT64) AS umrech_nenner,
        CAST(umrez AS INT64) AS umrech_zaehler
    FROM dbp_etl.kmo_marm_2 AS m
);

DROP TABLE IF EXISTS dbp_etl.art_umrechnung_faktor_per_tmp_2;

CREATE TABLE IF NOT EXISTS dbp_etl.art_umrechnung_faktor_per_tmp_2 (
    art_id INT64 NOT NULL,
    mandant_id INT64 NOT NULL,
    altnv_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL,
    bruttogew NUMERIC(29, 3) NOT NULL,
    gew_einh_id STRING(3) COLLATE 'und:ci' NOT NULL,
    umrech_faktor FLOAT64 NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    laenge NUMERIC(29, 3) NOT NULL,
    breite NUMERIC(29, 3) NOT NULL,
    hoehe NUMERIC(29, 3) NOT NULL,
    umrech_nenner INT64,
    umrech_zaehler INT64
);

INSERT INTO dbp_etl.art_umrechnung_faktor_per_tmp_2 (
    art_id,
    mandant_id,
    altnv_menge_einh_id,
    bruttogew,
    gew_einh_id,
    umrech_faktor,
    dat_von,
    dat_bis,
    laenge,
    breite,
    hoehe,
    umrech_nenner,
    umrech_zaehler
)
(
    SELECT
        t0.art_id,
        dt1.mandant_id,
        dt1.altnv_menge_einh_id,
        dt1.bruttogew,
        dt1.gew_einh_id,
        dt1.umrech_faktor,
        dt1.dat_von,
        dt1.dat_bis,
        dt1.laenge,
        dt1.breite,
        dt1.hoehe,
        dt1.umren,
        dt1.umrez
    FROM dbp_etl.kmo_marm_anr_2 AS dt1
    INNER JOIN (
        SELECT
            kl_art_id,
            art_id,
            mandant_id
        FROM dbp_data.art_2
        QUALIFY
            (
                ROW_NUMBER() OVER (PARTITION BY kl_art_id, mandant_id ORDER BY art_id IS NULL DESC, art_id DESC)
            ) = 1
    ) AS t0
        ON dt1.matnr = t0.kl_art_id AND dt1.mandant_id = t0.mandant_id
);

DELETE FROM dbp_data.art_umrechnung_faktor_per_2
WHERE
    (mandant_id, art_id, altnv_menge_einh_id, dat_von) IN (
        SELECT (mandant_id, art_id, altnv_menge_einh_id, dat_von)
        FROM dbp_etl.art_umrechnung_faktor_per_tmp_2
    );

INSERT INTO dbp_data.art_umrechnung_faktor_per_2 (
    mandant_id,
    altnv_menge_einh_id,
    art_id,
    dat_von,
    bruttogew,
    umrech_faktor,
    gew_einh_id,
    dat_bis,
    laenge,
    breite,
    hoehe,
    umrech_zaehler,
    umrech_nenner
)
(
    SELECT
        dt1.mandant_id,
        dt1.altnv_menge_einh_id,
        dt1.art_id,
        dt1.dat_von,
        dt1.bruttogew,
        CAST(dt1.umrech_faktor AS BIGNUMERIC) AS umrech_faktor,
        dt1.gew_einh_id,
        dt1.dat_bis,
        dt1.laenge,
        dt1.breite,
        dt1.hoehe,
        dt1.umrech_zaehler,
        dt1.umrech_nenner
    FROM dbp_etl.art_umrechnung_faktor_per_tmp_2 AS dt1
    LEFT JOIN (
        SELECT *
        FROM dbp_data.art_umrechnung_faktor_per_2 AS dt3
        WHERE
            dat_bis = PARSE_DATE('%F', '9999-12-31')
    ) AS dt2
        ON
            dt1.mandant_id = dt2.mandant_id
            AND dt1.art_id = dt2.art_id
            AND dt1.altnv_menge_einh_id = dt2.altnv_menge_einh_id
            AND dt1.bruttogew = dt2.bruttogew
            AND /* AND CAST(dt1.umrech_faktor AS NUMERIC(29,4)) = CAST(dt2.umrech_faktor AS NUMERIC(29,4)) */ dt1.gew_einh_id = dt2.gew_einh_id
            AND dt1.laenge = dt2.laenge
            AND dt1.breite = dt2.breite
            AND dt1.hoehe = dt2.hoehe
            AND dt1.umrech_nenner = dt2.umrech_nenner
            AND dt1.umrech_zaehler = dt2.umrech_zaehler
    WHERE
        dt2.art_id IS NULL
    GROUP BY
        dt1.art_id,
        dt1.mandant_id,
        dt1.altnv_menge_einh_id,
        dt1.bruttogew,
        dt1.gew_einh_id,
        dt1.umrech_faktor,
        dt1.dat_von,
        dt1.dat_bis,
        dt1.laenge,
        dt1.breite,
        dt1.hoehe,
        dt1.umrech_nenner,
        dt1.umrech_zaehler
);

UPDATE dbp_data.art_umrechnung_faktor_per_2 AS art_umrechnung_faktor_per0 SET dat_bis = CAST(CAST(dt1.dat_bis AS STRING) AS DATE)
FROM (
    SELECT
        mandant_id,
        art_id,
        altnv_menge_einh_id,
        dat_von,
        CASE
            WHEN
                SUM(CAST(FORMAT_DATE('%Y%m%d', CAST(dat_von AS DATE)) AS INT64)) OVER (
                    PARTITION BY mandant_id, art_id, altnv_menge_einh_id
                    ORDER BY dat_von DESC
                    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
                ) - CAST(FORMAT_DATE('%Y%m%d', CAST(dat_von AS DATE)) AS INT64) = 0
                THEN CAST('9999-12-31' AS DATE)
            ELSE DATE_SUB(PARSE_DATE(
                '%Y%m%d',
                CAST(SUM(CAST(FORMAT_DATE('%Y%m%d', CAST(dat_von AS DATE)) AS INT64)) OVER (
                    PARTITION BY mandant_id, art_id, altnv_menge_einh_id
                    ORDER BY dat_von DESC
                    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
                ) - CAST(FORMAT_DATE('%Y%m%d', CAST(dat_von AS DATE)) AS INT64) AS STRING)
            ), INTERVAL '1' DAY)
        END AS dat_bis
    FROM dbp_data.art_umrechnung_faktor_per_2
) AS dt1
WHERE
    art_umrechnung_faktor_per0.mandant_id = dt1.mandant_id
    AND art_umrechnung_faktor_per0.art_id = dt1.art_id
    AND art_umrechnung_faktor_per0.altnv_menge_einh_id = dt1.altnv_menge_einh_id
    AND art_umrechnung_faktor_per0.dat_bis <> CAST(CAST(dt1.dat_bis AS STRING) AS DATE)
    AND art_umrechnung_faktor_per0.dat_von = dt1.dat_von
    AND art_umrechnung_faktor_per0.mandant_id IN (
        SELECT mandant_id
        FROM dbp_etl.art_umrechnung_faktor_per_tmp_2
        GROUP BY
            mandant_id
    );

DROP TABLE IF EXISTS dbp_etl.art_umrechnung_faktor_per_tmp_2;
