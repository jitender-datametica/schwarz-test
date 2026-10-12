CREATE OR REPLACE TABLE dbp_etl.bon_artbew_dat_1 (
    dat DATE NOT NULL
);


CREATE OR REPLACE TABLE dbp_etl.bon_artbew_tag_1 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat DATE NOT NULL
);


-- 01.08.2021, -bartosiewicz-
CREATE OR REPLACE TABLE dbp_etl.bon_kopf_verkauf_1 (
    mandant_id INTEGER,
    wup_id INTEGER,
    bon_dat DATE,
    kl_art_id INTEGER,
    ean_kasse INTEGER,
    mwst_id INTEGER,
    wg_id INTEGER,
    umsatz_brutto NUMERIC(29, 4),
    menge NUMERIC(29, 3),
    aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
    talon_id INTEGER,
    bon_id STRING(25),
    bon_zeile INTEGER,
    kundenkarte_id STRING(255) COLLATE 'und:ci',
    kundenkarte_typ_id INTEGER DEFAULT 0 NOT NULL,
    bonuskauf_id STRING(20) COLLATE 'und:ci',
    customer_promotion_fg INTEGER DEFAULT 0,
    promotion_art STRING(100),
    bby_bewart INTEGER,
    bby_unique INTEGER,
    personal_unique INTEGER,
    personal INTEGER,
    bby_aktion STRING(10) COLLATE 'und:ci' NOT NULL,
    important STRING(2) COLLATE 'und:ci',
    loyalty_berechtigt_fg INTEGER DEFAULT 0
);


-- 01.08.2021, -bartosiewicz-
CREATE OR REPLACE TABLE dbp_etl.bon_artbew_tmp_talon_1 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    kl_art_id INTEGER NOT NULL,
    ean_kasse INTEGER,
    mwst_id INTEGER,
    wg_id INTEGER,
    aktion_id STRING(10) NOT NULL,
    umsatz_brutto NUMERIC(29, 4),
    menge NUMERIC(29, 3),
    talon_id INTEGER DEFAULT 0 NOT NULL,
    talon_id_aus_bon INTEGER DEFAULT 0 NOT NULL,
    bon_id STRING(25),
    kundenkarte_id STRING(255) COLLATE 'und:ci',
    kundenkarte_typ_id INTEGER DEFAULT 0 NOT NULL,
    bonuskauf_id STRING(20) COLLATE 'und:ci',
    customer_promotion_fg INTEGER DEFAULT 0,
    promotion_art STRING(100),
    aktion_id_obv STRING(10) COLLATE 'und:ci',
    bon_zeile INTEGER,
    stichlogik INTEGER,
    bby_bewart INTEGER,
    bby_unique INTEGER,
    personal_unique INTEGER,
    personal INTEGER,
    bby_aktion STRING(10) COLLATE 'und:ci' NOT NULL,
    important STRING(2) COLLATE 'und:ci',
    loyalty_berechtigt_fg INTEGER DEFAULT 0
);


-- 14.10.2019, -dbay-
--
-- an dieser stelle werden talons, die nur abgepackte ware enthalten, nicht fuer die talon-aufloesung mehr vorgesehen. in dem talon, beginnend in der regel mit dem string "99", werden sowohl der 
-- zugrundeliegende artikel_1 als auch der umsatzbruttowert festgeschrieben. das entspricht dem unten angefuegten filterkriterium, um diese von den normalen talons (beginnend mit "90") auszuschliessen.


CREATE OR REPLACE TABLE dbp_etl.`_neue_talons` AS
SELECT
    mandant_id,
    wup_id,
    talon_id,
    SUM(umsatz_brutto) AS umsatz_brutto_talon
FROM dbp_ods.ods_talon_det_1
WHERE
    artbew_fg = 0
    AND (
        SUBSTR(CAST(talon_id AS STRING), 1, 2) = '90' OR STRPOS(CAST(kl_art_id AS STRING), CAST(talon_id AS STRING)) <= 0
        OR STRPOS(CAST(ROUND(CAST(umsatz_brutto * 100 AS BIGNUMERIC), 0) AS STRING), CAST(talon_id AS STRING)) <= 0
    )
GROUP BY
    mandant_id,
    wup_id,
    talon_id;


CREATE OR REPLACE TABLE dbp_etl.de_artbew_bon_promotion_track_1 (
    mandant_id INTEGER,
    bon_id STRING(25),
    dat_booking DATE,
    kl_art_id INTEGER,
    bon_zeile INTEGER,
    bonuskauf_id STRING(20),
    konditionsart_id STRING(10),
    umsatz_brutto NUMERIC(29, 4),
    umsatz_promo_brutto NUMERIC(29, 4),
    menge_promo NUMERIC(29, 3),
    customer_promotion_fg INTEGER DEFAULT 0,
    promotion_art STRING(100),
    lfd_nr INTEGER,
    wup_id INTEGER
);


INSERT INTO dbp_etl.bon_artbew_dat_1 (dat)
(
    SELECT *
    FROM (
        SELECT dat
        FROM dbp_etl.bon_artbew_tgl_delta_1
        GROUP BY dat
        UNION DISTINCT
        SELECT K.bon_dat AS dat
        FROM dbp_etl.`_neue_talons` AS t
        INNER JOIN dbp_ods.ods_bon_verkauf_1 AS V ON t.mandant_id = V.mandant_id AND t.wup_id = V.wup_id AND t.talon_id = V.talon_id AND V.talon_id <> 0 AND t.umsatz_brutto_talon = V.umsatz_brutto
        INNER JOIN dbp_ods.ods_bon_kopf_1 AS K
            ON
                V.mandant_id = K.mandant_id AND V.wup_id = K.wup_id AND V.bon_id
                = K.bon_id
        WHERE
            K.turnover_fg = 1
            AND K.bon_dat < CURRENT_DATE("Europe/Berlin")
            AND (
                K.bon_id, K.wup_id) NOT IN (
                SELECT (bon_id, wup_id)
                FROM dbp_ods.ods_bon_storno_1
            )
        GROUP BY dat
    ) AS x
    WHERE dat IS NOT NULL
);


INSERT INTO dbp_etl.bon_artbew_tag_1 (mandant_id, wup_id, dat)
(SELECT
    mandant_id,
    wup_id,
    dat
FROM dbp_etl.bon_artbew_tgl_delta_1);


INSERT INTO dbp_etl.bon_artbew_tag_1 (mandant_id, wup_id, dat)
(
    SELECT
        K.mandant_id,
        K.wup_id,
        K.bon_dat AS dat
    FROM dbp_etl.`_neue_talons` AS t
    INNER JOIN dbp_ods.ods_bon_verkauf_1 AS V
        ON
            t.mandant_id = V.mandant_id AND t.wup_id = V.wup_id AND t.talon_id
            = V.talon_id AND V.talon_id <> 0 AND t.umsatz_brutto_talon = V.umsatz_brutto
    INNER JOIN dbp_ods.ods_bon_kopf_1 AS K
        ON
            V.mandant_id = K.mandant_id AND V.wup_id = K.wup_id AND V.bon_id
            = K.bon_id
    WHERE (
        K.mandant_id, K.wup_id, K.bon_dat) IN (
        SELECT (A.mandant_id, A.wup_id, A.dat)
        FROM dbp_data.artbew_1 AS A
        INNER JOIN dbp_etl.bon_artbew_dat_1 AS D ON A.dat = D.dat
        WHERE A.mandant_id = 1
    )
    AND K.turnover_fg = 1
    AND K.bon_dat < CURRENT_DATE("Europe/Berlin")
    AND (
        K.mandant_id, K.wup_id, K.bon_dat) NOT IN (
        SELECT (mandant_id, wup_id, dat)
        FROM dbp_etl.bon_artbew_tag_1
    )
    AND (
        K.bon_id, K.wup_id) NOT IN (
        SELECT (bon_id, wup_id)
        FROM dbp_ods.ods_bon_storno_1
    )
    GROUP BY
        K.mandant_id,
        K.wup_id,
        dat
);


-- 09.01.2023, -dbay
-- where coalesce(p.betrag_promo_brutto, 0) <> 0

-- filter killed due to interferences regarding loyalty.
INSERT INTO dbp_etl.de_artbew_bon_promotion_track_1
(
    mandant_id, bon_id, dat_booking, kl_art_id, bon_zeile, bonuskauf_id, konditionsart_id, umsatz_brutto,
    umsatz_promo_brutto, menge_promo, customer_promotion_fg, promotion_art, lfd_nr, wup_id
)
(
    SELECT
        mandant_id,
        bon_id,
        bon_dat,
        kl_art_id,
        bon_zeile,
        bonuskauf_id,
        konditionsart_id,
        CAST(SUM(betrag_promo_brutto * -1) AS NUMERIC) AS umsatz_brutto,
        SUM(umsatz_promo_brutto) AS umsatz_promo_brutto,
        SUM(menge_promo) AS menge_promo,
        customer_promotion_fg,
        promotion_art,
        promotion_lfd_nr,
        wup_id
    FROM dbp_ods.ods_promotion_1 AS P
    WHERE
        mandant_id = 1
        AND bon_dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_etl.bon_artbew_tag_1) AND (
            SELECT MAX(dat)
            FROM dbp_etl.bon_artbew_tag_1
        )
    GROUP BY
        mandant_id,
        bon_id,
        bon_dat,
        kl_art_id,
        bon_zeile,
        bonuskauf_id,
        konditionsart_id,
        customer_promotion_fg,
        promotion_art,
        promotion_lfd_nr,
        wup_id
);


CREATE OR REPLACE TABLE dbp_etl.de_bd_for_promotion_1 AS
SELECT *
FROM dbp_ods.ods_promotion_1
WHERE bon_dat BETWEEN (
    SELECT MIN(dat)
    FROM dbp_etl.bon_artbew_tag_1) AND (
    SELECT MAX(dat)
    FROM dbp_etl.bon_artbew_tag_1
)
AND mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _track_zbon_zbov_unique AS
SELECT
    mandant_id,
    bon_id,
    bon_zeile,
    bon_dat,
    wup_id,
    1 AS flag
FROM dbp_etl.de_bd_for_promotion_1
WHERE (
    mandant_id, bon_id, bon_zeile, bon_dat, wup_id) IN (
    SELECT (mandant_id, bon_id, bon_zeile, bon_dat, wup_id)
    FROM dbp_etl.de_bd_for_promotion_1
    WHERE
        konditionsart_id IN ('ZBON', 'ZBOV')
        AND mandant_id = 1
    GROUP BY mandant_id,
    bon_id,
    bon_zeile,
    bon_dat,
    wup_id
)
AND mandant_id = 1
AND konditionsart_id NOT IN ('ZRT3', 'ZTAG', 'ZGEB')
GROUP BY
    mandant_id,
    bon_id,
    wup_id,
    bon_zeile,
    bon_dat
HAVING COUNT(DISTINCT konditionsart_id) = 1;


CREATE OR REPLACE TEMPORARY TABLE _track_zbon_zbov AS
SELECT
    mandant_id,
    bon_id,
    bon_zeile,
    bon_dat,
    wup_id,
    promotion_lfd_nr,
    1 AS flag
FROM dbp_etl.de_bd_for_promotion_1
WHERE
    konditionsart_id IN ('ZBON', 'ZBOV')
    AND mandant_id = 1
GROUP BY
    mandant_id,
    bon_id,
    bon_zeile,
    bon_dat,
    wup_id,
    promotion_lfd_nr;


CREATE OR REPLACE TEMPORARY TABLE _de_perf_01 AS
SELECT
    A.mandant_id,
    A.bon_id,
    A.dat_booking,
    A.bon_zeile,
    MAX(A.bonuskauf_id) AS bonuskauf_id,
    A.customer_promotion_fg,
    A.promotion_art,
    MAX(COALESCE(B.aktion_id, '')) AS aktion_id,
    SUM(A.umsatz_brutto) AS promotion_brutto,
    CASE
        WHEN A.dat_booking < DATE '2022-04-01'
            THEN NULL
        WHEN A.konditionsart_id IN ('ZBON', 'ZBOV')
            THEN 'N'
        ELSE 'Y'
    END AS important,
    CASE
        WHEN A.dat_booking < DATE '2022-04-01'
            THEN 0
        ELSE COALESCE(Y.flag, 0)
    END AS bby_bewart,
    CASE
        WHEN A.dat_booking < DATE '2022-04-01'
            THEN 0
        ELSE COALESCE(X.flag, 0)
    END AS bby_unique
FROM dbp_etl.de_artbew_bon_promotion_track_1 AS A
LEFT JOIN `_track_zbon_zbov_unique` AS X
    ON
        A.mandant_id = X.mandant_id AND A.wup_id = X.wup_id AND A.bon_id = X.bon_id
        AND A.bon_zeile = X.bon_zeile AND A.dat_booking = X.bon_dat
LEFT JOIN `_track_zbon_zbov` AS Y ON A.mandant_id = Y.mandant_id AND A.wup_id = Y.wup_id AND A.bon_id = Y.bon_id AND A.bon_zeile = Y.bon_zeile AND A.lfd_nr = Y.promotion_lfd_nr AND A.dat_booking = Y.bon_dat
LEFT JOIN dbp_data.l_bonuskauf_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.bonuskauf_id = B.bonuskauf_id
        AND A.dat_booking BETWEEN B.dat_von AND B.dat_bis
GROUP BY
    A.mandant_id,
    A.bon_id,
    A.dat_booking,
    A.bon_zeile,
    A.customer_promotion_fg,
    A.promotion_art,
    important,
    bby_bewart,
    bby_unique;


CREATE OR REPLACE TEMPORARY TABLE _xx1 AS
SELECT
    A.bon_id,
    A.bon_zeile,
    A.mandant_id,
    A.wup_id,
    A.bon_dat,
    A.kl_art_id,
    A.ean_kasse,
    A.wg_id,
    A.menge,
    A.einh_id,
    A.umsatz_brutto,
    A.mwst_id,
    A.erfassung_id,
    A.aktion_id,
    A.talon_id,
    A.start_bon_zeile,
    A.bon_nr_extern,
    A.kpos_erfassung_id,
    A.umsatz_brutto_norm,
    A.vk_brutto_obb,
    A.bon_vorgang_id,
    A.barcode_string,
    A.barcode_leergut,
    A.zeilenstorno_fg,
    A.td_update,
    A.td_insert
FROM dbp_ods.ods_bon_verkauf_1 AS A
INNER JOIN dbp_etl.bon_artbew_tag_1 AS X
    ON
        A.mandant_id = X.mandant_id AND A.wup_id = X.wup_id AND A.bon_dat
        = X.dat
WHERE A.wg_id <> 822;


INSERT INTO dbp_etl.bon_kopf_verkauf_1 (
    mandant_id, wup_id, bon_dat, kl_art_id, ean_kasse, mwst_id, wg_id,
    umsatz_brutto, menge, aktion_id, talon_id, bon_id, bon_zeile, kundenkarte_id, kundenkarte_typ_id, bonuskauf_id,
    customer_promotion_fg, promotion_art, bby_bewart, bby_unique, bby_aktion, important, loyalty_berechtigt_fg
)
(
    SELECT
        K.mandant_id,
        K.wup_id,
        K.bon_dat,
        V.kl_art_id,
        CAST(COALESCE(CASE
            WHEN TRIM(T.kassensystem_name) <> 'KPOS'
                THEN V.ean_kasse
            ELSE CASE
                WHEN TRIM(V.barcode_string) = ''
                    THEN V.ean_kasse
                WHEN LENGTH(V.barcode_string) > 26
                    THEN -9999
                WHEN ROUND(SAFE_CAST(V.barcode_string AS BIGNUMERIC), 0) IS NOT NULL
                    THEN CAST(ROUND(CAST(V.barcode_string AS BIGNUMERIC), 0) AS INTEGER)
                ELSE V.ean_kasse
            END
        END, V.ean_kasse) AS INTEGER) AS ean_kasse,
        V.mwst_id,
        V.wg_id,
        V.umsatz_brutto,
        V.menge,
        COALESCE(CASE
            WHEN TRIM(T.kassensystem_name) = 'KPOS' AND P.aktion_id <> ''
                THEN P.aktion_id
            ELSE V.aktion_id
        END, V.aktion_id) AS aktion_id,
        CAST(V.talon_id AS INTEGER) AS talon_id,
        K.bon_id,
        V.bon_zeile,
        K.kundenkarte_id,
        K.kundenkarte_typ_id,
        P.bonuskauf_id,
        P.customer_promotion_fg,
        P.promotion_art,
        P.bby_bewart,
        P.bby_unique,
        V.aktion_id AS bby_aktion,
        P.important,
        K.loyalty_berechtigt_fg
    FROM dbp_ods.ods_bon_kopf_1 AS K
    INNER JOIN dbp_etl.bon_artbew_tag_1 AS X
        ON
            K.mandant_id = X.mandant_id AND K.wup_id = X.wup_id AND K.bon_dat
            = X.dat
    INNER JOIN dbp_ods.ods_bon_transaction_1 AS T
        ON
            K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id AND
            K.wup_id = T.wup_id AND K.bon_dat = T.bon_dat
    INNER JOIN `_xx1` AS V
        ON
            K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K.bon_id = V.bon_id AND K.bon_dat =
            V.bon_dat
    LEFT JOIN `_de_perf_01` AS P
        ON
            V.mandant_id = P.mandant_id AND V.bon_id = P.bon_id AND V.bon_dat = P.dat_booking AND
            V.bon_zeile = P.bon_zeile
    WHERE
        K.turnover_fg = 1
        AND (
            K.bon_id, K.wup_id) NOT IN (
            SELECT (bon_id, wup_id)
            FROM dbp_ods.ods_bon_storno_1
        )
        AND V.wg_id NOT IN (822)
);


-- 14.08.2017, -dbay-
--
-- Wichtiger Bereinigungsschritt, um etwaige Zeilenstornos in den Warengruppenerfassartikeln, die zu einer Vervielfachung in den ARTBEW_1-Zahlen fuehren, zu eliminieren! Hierzu wird eine_1 View
-- angesprochen, in der bis zu 10 Stornos (!) pro Bon getrackt werden. In der gesamten Historie aller Bon-Daten lag die Hoechstgrenze bei 7 Auspraegungen.


TRUNCATE TABLE dbp_etl_process.artbew_zeilen_stornos_1;


INSERT INTO dbp_etl_process.artbew_zeilen_stornos_1
(SELECT
    mandant_id,
    wup_id,
    bon_dat,
    kl_art_id,
    ean_kasse,
    mwst_id,
    wg_id,
    umsatz_brutto,
    menge,
    aktion_id,
    talon_id,
    bon_id,
    bon_zeile,
    kundenkarte_id,
    kundenkarte_typ_id,
    bonuskauf_id,
    customer_promotion_fg,
    promotion_art,
    bby_bewart,
    bby_unique,
    bby_aktion,
    important
FROM dbp_etl.bon_kopf_verkauf_1);


DELETE FROM dbp_etl.bon_kopf_verkauf_1
WHERE (
    mandant_id, wup_id, bon_dat, bon_id, kl_art_id, bon_zeile, talon_id) IN (
    SELECT (mandant_id, wup_id, bon_dat, bon_id, kl_art_id, bon_zeile, CAST(talon_id AS INTEGER))
    FROM dbp_etl_process.v_ais_clean_row_cancellation_1
);


CREATE OR REPLACE TEMPORARY TABLE _retoure AS
SELECT
    K.mandant_id,
    K.wup_id,
    K.bon_dat AS dat,
    0 AS talon_art_korrekt,
    V.kl_art_id,
    COALESCE(CASE
        WHEN TRIM(T.kassensystem_name) <> 'KPOS'
            THEN V.ean_kasse
        ELSE CASE
            WHEN TRIM(V.barcode_string) = ''
                THEN V.ean_kasse
            WHEN LENGTH(V.barcode_string) > 26
                THEN -9999
            ELSE CAST(ROUND(CAST(V.barcode_string AS BIGNUMERIC), 0) AS INTEGER)
        END
    END, V.ean_kasse) AS ean_kasse,
    V.mwst_id,
    V.wg_id,
    V.umsatz_brutto,
    V.menge * V.menge_fg AS menge,
    V.aktion_id,
    0 AS talon_id,
    0 AS talon_id_aus_bon,
    K.bon_id,
    K.kundenkarte_id,
    K.kundenkarte_typ_id,
    z.bonuskauf_id,
    z.customer_promotion_fg,
    z.promotion_art,
    V.aktion_id AS aktion_id_obv,
    V.bon_zeile,
    z.bby_bewart,
    z.bby_unique,
    V.aktion_id AS bby_aktion,
    z.important,
    K.loyalty_berechtigt_fg
FROM dbp_ods.ods_bon_kopf_1 AS K
INNER JOIN dbp_ods.ods_bon_transaction_1 AS T ON K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id AND K.wup_id = T.wup_id AND K.bon_dat = T.bon_dat
INNER JOIN dbp_ods.ods_bon_retoure_1 AS V
    ON
        K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K.bon_id
        = V.bon_id AND K.bon_dat = V.bon_dat AND COALESCE(V.talon_id, 0) = 0
INNER JOIN dbp_etl.bon_artbew_tag_1 AS P
    ON
        K.mandant_id = P.mandant_id AND K.wup_id = P.wup_id AND K.bon_dat
        = P.dat
LEFT JOIN (
    SELECT
        Z.mandant_id,
        Z.wup_id,
        Z.bon_id,
        Z.bon_dat,
        Z.kl_art_id,
        Z.bon_zeile,
        Z.bonuskauf_id,
        Z.customer_promotion_fg,
        Z.promotion_art,
        CASE
            WHEN Z.bon_dat < DATE '2022-04-01'
                THEN NULL
            WHEN Z.konditionsart_id IN ('ZBON', 'ZBOV')
                THEN 'N'
            ELSE 'Y'
        END AS important,
        CASE
            WHEN Z.bon_dat < DATE '2022-04-01'
                THEN 0
            ELSE COALESCE(Y.flag, 0)
        END AS bby_bewart,
        CASE
            WHEN Z.bon_dat < DATE '2022-04-01'
                THEN 0
            ELSE COALESCE(X.flag, 0)
        END AS bby_unique
    FROM dbp_etl.de_bd_for_promotion_1 AS Z
    LEFT JOIN `_track_zbon_zbov_unique` AS X
        ON
            Z.mandant_id = X.mandant_id AND Z.wup_id = X.wup_id AND Z.bon_id = X.bon_id
            AND Z.bon_zeile = X.bon_zeile AND Z.bon_dat = X.bon_dat
    LEFT JOIN `_track_zbon_zbov` AS Y
        ON
            Z.mandant_id = Y.mandant_id AND Z.wup_id = Y.wup_id AND Z.bon_id = Y.bon_id AND
            Z.bon_zeile = Y.bon_zeile AND Z.promotion_lfd_nr = Y.promotion_lfd_nr AND Z.bon_dat = Y.bon_dat
    GROUP BY
        Z.mandant_id,
        Z.wup_id,
        Z.bon_id,
        Z.bon_dat,
        Z.kl_art_id,
        Z.bon_zeile,
        Z.bonuskauf_id,
        Z.customer_promotion_fg,
        Z.promotion_art,
        important,
        bby_bewart,
        bby_unique
) AS z
    ON
        K.mandant_id = z.mandant_id AND K.wup_id = z.wup_id AND K.bon_id = z.bon_id AND K.bon_dat = z.bon_dat
        AND V.kl_art_id = z.kl_art_id AND V.bon_zeile = z.bon_zeile
WHERE
    K.turnover_fg = 1
    AND (
        K.bon_id, K.bon_dat) NOT IN (
        SELECT (bon_id, bon_dat)
        FROM dbp_ods.ods_bon_storno_1
    )
    AND V.wg_id NOT IN (822);


CREATE OR REPLACE TABLE dbp_etl.retoure_x_1 AS
SELECT *
FROM `_retoure`;


INSERT INTO dbp_etl.bon_artbew_tmp_talon_1 (
    mandant_id, wup_id, dat, kl_art_id, ean_kasse, mwst_id, wg_id,
    aktion_id, umsatz_brutto, menge, talon_id, talon_id_aus_bon, bon_id, kundenkarte_id, kundenkarte_typ_id, bonuskauf_id,
    customer_promotion_fg, promotion_art, aktion_id_obv, bon_zeile, stichlogik, bby_bewart, bby_unique, bby_aktion,
    important, loyalty_berechtigt_fg
)
(
    SELECT
        mandant_id,
        wup_id,
        dat,
        kl_art_id,
        CAST(ean_kasse AS INTEGER) AS ean_kasse,
        mwst_id,
        wg_id,
        aktion_id,
        CAST(SUM(umsatz_brutto) AS NUMERIC) AS umsatz_brutto,
        CAST(SUM(menge) AS NUMERIC) AS menge,
        CAST(talon_id AS INTEGER) AS talon_id,
        talon_id_aus_bon,
        MAX(bon_id) AS bon_id,
        kundenkarte_id,
        kundenkarte_typ_id,
        MAX(bonuskauf_id) AS bonuskauf_id,
        customer_promotion_fg,
        promotion_art,
        aktion_id_obv,
        bon_zeile,
        stichlogik,
        bby_bewart,
        bby_unique,
        bby_aktion,
        important,
        loyalty_berechtigt_fg
    FROM (SELECT
        mandant_id,
        wup_id,
        dat,
        kl_art_id,
        ean_kasse,
        mwst_id,
        wg_id,
        aktion_id,
        umsatz_brutto,
        menge,
        talon_id,
        talon_id_aus_bon,
        bon_id,
        kundenkarte_id,
        kundenkarte_typ_id,
        bonuskauf_id,
        customer_promotion_fg,
        promotion_art,
        aktion_id_obv,
        bon_zeile,
        bby_bewart,
        bby_unique,
        bby_aktion,
        important,
        stichlogik,
        loyalty_berechtigt_fg,
        ROW_NUMBER() OVER (
            PARTITION BY
                mandant_id, bon_id, dat, wup_id, bon_zeile, kl_art_id, ean_kasse ORDER BY
                stichlogik
                IS NULL, stichlogik, bonuskauf_id IS NULL DESC, bonuskauf_id DESC
        ) AS rk
    FROM (
        SELECT
            mandant_id,
            wup_id,
            dat,
            kl_art_id,
            ean_kasse,
            mwst_id,
            wg_id,
            aktion_id,
            talon_id,
            talon_id_aus_bon,
            kundenkarte_id,
            kundenkarte_typ_id,
            customer_promotion_fg,
            promotion_art,
            aktion_id_obv,
            bon_zeile,
            CASE
                WHEN promotion_art = 'PERSONAL_SMP'
                    THEN 99
                WHEN important = 'N' AND bby_unique = 0
                    THEN 9
                WHEN promotion_art = 'PERSONAL'
                    THEN 1
                ELSE CASE
                    WHEN promotion_art = 'CUSTOMER'
                        THEN 2
                    ELSE CASE
                        WHEN promotion_art = 'COMMON'
                            THEN 3
                        ELSE 4
                    END
                END
            END AS stichlogik,
            bby_bewart,
            bby_unique,
            bby_aktion,
            important,
            bon_id,
            loyalty_berechtigt_fg,
            SUM(umsatz_brutto) AS umsatz_brutto,
            SUM(menge) AS menge,
            MAX(bonuskauf_id) AS bonuskauf_id
        FROM (
            SELECT
                X.mandant_id,
                X.wup_id,
                X.bon_dat AS dat,
                CASE
                    WHEN a.kl_art_id IS NOT NULL AND T.mandant_id IS NOT NULL
                        THEN 1
                    ELSE 0
                END AS talon_art_korrekt,
                CASE
                    WHEN
                        CASE
                            WHEN a.kl_art_id IS NOT NULL AND T.mandant_id IS NOT NULL
                                THEN 1
                            ELSE 0
                        END = 1
                        THEN T.kl_art_id
                    ELSE COALESCE(TX.kl_art_id, X.kl_art_id)
                END AS kl_art_id,
                CASE
                    WHEN
                        CASE
                            WHEN a.kl_art_id IS NOT NULL AND T.mandant_id IS NOT NULL
                                THEN 1
                            ELSE 0
                        END = 1
                        THEN 0
                    ELSE X.ean_kasse
                END AS ean_kasse,
                CASE
                    WHEN
                        CASE
                            WHEN a.kl_art_id IS NOT NULL AND T.mandant_id IS NOT NULL
                                THEN 1
                            ELSE 0
                        END = 1
                        THEN MW.mwst_id
                    ELSE COALESCE(TW.mwst_id, X.mwst_id)
                END AS mwst_id,
                CASE
                    WHEN
                        CASE
                            WHEN a.kl_art_id IS NOT NULL AND T.mandant_id IS NOT NULL
                                THEN 1
                            ELSE 0
                        END = 1
                        THEN T.wg_id
                    ELSE COALESCE(TX.wg_id, X.wg_id)
                END AS wg_id,
                COALESCE(
                    T.umsatz_brutto, TX.umsatz_brutto / IF(t1.umsatz_brutto_talon = 0, NULL, t1.umsatz_brutto_talon) * X.umsatz_brutto,
                    X.umsatz_brutto + COALESCE(t12.coupon_betrag, 0.0000)
                ) AS umsatz_brutto,
                COALESCE(CASE
                    WHEN T.menge = 0
                        THEN 1
                    ELSE T.menge
                END, CASE
                    WHEN TX.menge = 0
                        THEN 1
                    ELSE TX.menge
                END, X.menge) AS menge,
                CASE
                    WHEN
                        CASE
                            WHEN a.kl_art_id IS NOT NULL AND T.mandant_id IS NOT NULL
                                THEN 1
                            ELSE 0
                        END = 1
                        THEN T.aktion_id
                    ELSE COALESCE(TX.aktion_id, X.aktion_id)
                END AS aktion_id,
                COALESCE(T.talon_id, TX.talon_id, 0) AS talon_id,
                CASE
                    WHEN T.talon_id IS NULL
                        THEN COALESCE(X.talon_id, 0)
                    ELSE 0
                END AS talon_id_aus_bon,
                X.bon_id,
                X.kundenkarte_id,
                X.kundenkarte_typ_id,
                X.bonuskauf_id,
                X.customer_promotion_fg,
                X.promotion_art,
                X.aktion_id AS aktion_id_obv,
                X.bon_zeile,
                X.bby_bewart,
                X.bby_unique,
                X.bby_aktion,
                X.important,
                X.loyalty_berechtigt_fg
            FROM dbp_etl.bon_kopf_verkauf_1 AS X
            LEFT JOIN (
                SELECT
                    mandant_id,
                    wup_id,
                    talon_id,
                    SUM(umsatz_brutto) AS umsatz_brutto_talon
                FROM dbp_ods.ods_talon_det_1
                WHERE turnover_fg = 1
                GROUP BY
                    mandant_id,
                    talon_id,
                    wup_id
            ) AS t1_1 ON X.mandant_id = t1.mandant_id AND X.wup_id = t1.wup_id AND X.talon_id = t1.talon_id
            LEFT JOIN dbp_ods.ods_talon_det_1 AS T
                ON
                    X.mandant_id = T.mandant_id AND X.wup_id = T.wup_id AND
                    X.talon_id = T.talon_id AND T.turnover_fg = 1 AND t1.umsatz_brutto_talon = X.umsatz_brutto
            LEFT JOIN dbp_ods.ods_talon_det_1 AS TX
                ON
                    X.mandant_id = TX.mandant_id AND X.wup_id = TX.wup_id
                    AND X.talon_id = TX.talon_id AND TX.turnover_fg = 1 AND t1.umsatz_brutto_talon <> X.umsatz_brutto
            LEFT JOIN (
                SELECT
                    mandant_id,
                    kl_art_id,
                    mwst_id
                FROM dbp_data.art_1
                WHERE kl_art_id <> 0
                QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, kl_art_id ORDER BY art_id IS NULL DESC, art_id DESC)) = 1
            ) AS a ON T.kl_art_id = a.kl_art_id AND T.mandant_id = a.mandant_id
            LEFT JOIN (
                SELECT
                    mandant_id,
                    kl_art_id,
                    mwst_id
                FROM dbp_data.art_1
                WHERE kl_art_id <> 0
                QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, kl_art_id ORDER BY art_id IS NULL DESC, art_id DESC)) = 1
            ) AS ax ON TX.kl_art_id = ax.kl_art_id AND TX.mandant_id = ax.mandant_id
            LEFT JOIN dbp_data.mwst_per_1 AS MW
                ON
                    T.mandant_id = MW.mandant_id AND X.bon_dat BETWEEN MW.dat_von
                    AND MW.dat_bis AND COALESCE(T.mwst, 0) <> 0 AND T.mwst = MW.mwst AND MW.mwst_id <> 4
            LEFT JOIN dbp_data.mwst_per_1 AS TW
                ON
                    MW.mandant_id = TX.mandant_id AND X.bon_dat BETWEEN MW.dat_von
                    AND MW.dat_bis AND COALESCE(TX.mwst, 0) <> 0 AND TX.mwst = MW.mwst AND MW.mwst_id <> 4
            LEFT JOIN (
                SELECT
                    mandant_id,
                    wup_id,
                    bon_id,
                    bon_zeile,
                    SUM(coupon_betrag) AS coupon_betrag
                FROM dbp_ods.ods_coupon_1
                WHERE coupon_kz = 1
                GROUP BY
                    bon_id,
                    bon_zeile,
                    mandant_id,
                    wup_id
            ) AS t12
                ON
                    X.mandant_id = t12.mandant_id AND X.wup_id = t12.wup_id AND X.bon_id = t12.bon_id AND X.bon_zeile
                    = t12.bon_zeile AND X.talon_id = 0
            UNION ALL
            SELECT *
            FROM `_retoure`
        ) AS a
        GROUP BY
            mandant_id,
            wup_id,
            dat,
            kl_art_id,
            ean_kasse,
            mwst_id,
            wg_id,
            aktion_id,
            talon_id,
            talon_id_aus_bon,
            kundenkarte_id,
            kundenkarte_typ_id,
            customer_promotion_fg,
            promotion_art,
            aktion_id_obv,
            bon_zeile,
            stichlogik,
            bby_bewart,
            bby_unique,
            bby_aktion,
            important,
            bon_id,
            loyalty_berechtigt_fg
    ) AS t16
    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY mandant_id, bon_id, dat, wup_id, bon_zeile, kl_art_id, ean_kasse ORDER BY
            stichlogik IS NULL, stichlogik, bonuskauf_id IS NULL DESC, bonuskauf_id DESC
    )) = 1) AS t18
    GROUP BY
        mandant_id,
        wup_id,
        dat,
        kl_art_id,
        ean_kasse,
        mwst_id,
        wg_id,
        aktion_id,
        talon_id,
        talon_id_aus_bon,
        kundenkarte_id,
        kundenkarte_typ_id,
        customer_promotion_fg,
        promotion_art,
        aktion_id_obv,
        bon_zeile,
        bby_bewart,
        bby_unique,
        bby_aktion,
        important,
        stichlogik,
        loyalty_berechtigt_fg
);


-- WG_ID = 822


CREATE OR REPLACE TEMPORARY TABLE _track_zbon_zbov_unique_personal AS
SELECT
    t7.mandant_id,
    t7.bon_id,
    t7.bon_zeile,
    t7.bon_dat,
    t7.wup_id,
    t7.promotion_art,
    1 AS flag,
    t7.anz,
    t7.bonrabatt
FROM (
    SELECT
        A.mandant_id,
        A.bon_id,
        A.wup_id,
        A.bon_zeile,
        A.bon_dat,
        A.promotion_art,
        MAX(b.anz) AS anz,
        MAX(b.bonrabatt) AS bonrabatt,
        COUNT(DISTINCT A.promotion_art) AS a1
    FROM dbp_etl.de_bd_for_promotion_1 AS A
    INNER JOIN (
        SELECT
            mandant_id,
            bon_id,
            bon_zeile,
            bon_dat,
            wup_id,
            COUNT(DISTINCT promotion_art) AS anz,
            MAX(CASE
                WHEN konditionsart_id IN ('ZBON', 'ZBOV')
                    THEN 1
                ELSE 0
            END) AS bonrabatt
        FROM dbp_etl.de_bd_for_promotion_1
        GROUP BY
            mandant_id,
            bon_id,
            bon_zeile,
            bon_dat,
            wup_id
    ) AS b ON A.mandant_id = b.mandant_id AND A.bon_id = b.bon_id AND A.bon_zeile = b.bon_zeile AND A.bon_dat = b.bon_dat AND A.wup_id = b.wup_id
    WHERE (A.mandant_id, A.bon_id, A.bon_zeile, A.bon_dat, A.wup_id) IN (SELECT (
        mandant_id, bon_id, bon_zeile, bon_dat,
        wup_id
    )
    FROM dbp_etl.de_bd_for_promotion_1
    WHERE promotion_art = 'PERSONAL'
    GROUP BY mandant_id,
    bon_id,
    bon_zeile,
    bon_dat,
    wup_id)
    AND A.konditionsart_id NOT IN ('ZRT3', 'ZTAG', 'ZGEB')
    GROUP BY
        A.mandant_id,
        A.bon_id,
        A.wup_id,
        A.bon_zeile,
        A.bon_dat,
        A.promotion_art
    HAVING a1 = 1 AND bonrabatt = 0 AND anz = 1
) AS t7;


CREATE OR REPLACE TEMPORARY TABLE _track_zbon_zbov_personal AS
SELECT
    mandant_id,
    bon_id,
    bon_zeile,
    bon_dat,
    wup_id,
    1 AS flag
FROM dbp_etl.de_bd_for_promotion_1
WHERE (
    mandant_id, bon_id, bon_zeile, bon_dat, wup_id) IN (
    SELECT (mandant_id, bon_id, bon_zeile, bon_dat, wup_id)
    FROM dbp_etl.de_bd_for_promotion_1
    WHERE promotion_art = 'PERSONAL'
    GROUP BY mandant_id,
    bon_id,
    bon_zeile,
    bon_dat,
    wup_id
)
AND konditionsart_id NOT IN ('ZRT3', 'ZTAG', 'ZGEB')
GROUP BY
    mandant_id,
    bon_id,
    bon_zeile,
    bon_dat,
    wup_id;


CREATE OR REPLACE TEMPORARY TABLE _de_perf_01 AS
SELECT
    A.mandant_id,
    A.bon_id,
    A.dat_booking,
    A.bon_zeile,
    MAX(A.bonuskauf_id) AS bonuskauf_id,
    A.customer_promotion_fg,
    A.promotion_art,
    MAX(COALESCE(B.aktion_id, '')) AS aktion_id,
    SUM(A.umsatz_brutto) AS promotion_brutto,
    CASE
        WHEN A.dat_booking < DATE '2022-04-01'
            THEN NULL
        WHEN A.konditionsart_id IN ('ZBON', 'ZBOV')
            THEN 'N'
        ELSE 'Y'
    END AS important,
    CASE
        WHEN A.dat_booking < DATE '2022-04-01'
            THEN 0
        ELSE COALESCE(Y.flag, 0)
    END AS bby_bewart,
    CASE
        WHEN A.dat_booking < DATE '2022-04-01'
            THEN 0
        ELSE COALESCE(X.flag, 0)
    END AS bby_unique,
    CASE
        WHEN A.dat_booking < DATE '2022-04-01'
            THEN 0
        ELSE COALESCE(W.flag, 0)
    END AS personal_unique,
    CASE
        WHEN A.dat_booking < DATE '2022-04-01'
            THEN 0
        ELSE COALESCE(U.flag, 0)
    END AS personal
FROM dbp_etl.de_artbew_bon_promotion_track_1 AS A
LEFT JOIN `_track_zbon_zbov_unique` AS X
    ON
        A.mandant_id = X.mandant_id AND A.wup_id = X.wup_id AND A.bon_id = X.bon_id
        AND A.bon_zeile = X.bon_zeile AND A.dat_booking = X.bon_dat
LEFT JOIN `_track_zbon_zbov` AS Y ON A.mandant_id = Y.mandant_id AND A.wup_id = Y.wup_id AND A.bon_id = Y.bon_id AND A.bon_zeile = Y.bon_zeile AND A.lfd_nr = Y.promotion_lfd_nr AND A.dat_booking = Y.bon_dat
LEFT JOIN `_track_zbon_zbov_unique_personal` AS W
    ON
        A.mandant_id = W.mandant_id AND A.wup_id = W.wup_id AND A.bon_id =
        W.bon_id AND A.bon_zeile = W.bon_zeile AND A.dat_booking = W.bon_dat
LEFT JOIN `_track_zbon_zbov_personal` AS U
    ON
        A.mandant_id = U.mandant_id AND A.wup_id = U.wup_id AND A.bon_id = U.bon_id
        AND A.bon_zeile = U.bon_zeile AND A.dat_booking = U.bon_dat
LEFT JOIN dbp_data.l_bonuskauf_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.bonuskauf_id = B.bonuskauf_id
        AND A.dat_booking BETWEEN B.dat_von AND B.dat_bis
GROUP BY
    A.mandant_id,
    A.bon_id,
    A.dat_booking,
    A.bon_zeile,
    A.customer_promotion_fg,
    A.promotion_art,
    important,
    bby_bewart,
    bby_unique,
    personal_unique,
    personal;


INSERT INTO dbp_etl.bon_kopf_verkauf_1 (
    mandant_id, wup_id, bon_dat, kl_art_id, ean_kasse, mwst_id, wg_id,
    umsatz_brutto, menge, aktion_id, talon_id, bon_id, bon_zeile, kundenkarte_id, kundenkarte_typ_id, bonuskauf_id,
    customer_promotion_fg, promotion_art, bby_bewart, bby_unique, personal_unique, personal, bby_aktion, important,
    loyalty_berechtigt_fg
)
(
    SELECT
        K.mandant_id,
        K.wup_id,
        K.bon_dat,
        V.kl_art_id,
        CAST(COALESCE(CASE
            WHEN TRIM(T.kassensystem_name) <> 'KPOS'
                THEN V.ean_kasse
            ELSE CASE
                WHEN TRIM(V.barcode_string) = ''
                    THEN V.ean_kasse
                WHEN LENGTH(V.barcode_string) > 26
                    THEN -9999
                WHEN ROUND(SAFE_CAST(V.barcode_string AS BIGNUMERIC), 0) IS NOT NULL
                    THEN CAST(ROUND(CAST(V.barcode_string AS BIGNUMERIC), 0) AS INTEGER)
                ELSE V.ean_kasse
            END
        END, V.ean_kasse) AS INTEGER) AS ean_kasse,
        V.mwst_id,
        V.wg_id,
        V.umsatz_brutto,
        V.menge,
        COALESCE(CASE
            WHEN TRIM(T.kassensystem_name) = 'KPOS' AND P.aktion_id <> ''
                THEN P.aktion_id
            ELSE V.aktion_id
        END, V.aktion_id) AS aktion_id,
        CAST(V.talon_id AS INTEGER) AS talon_id,
        K.bon_id,
        V.bon_zeile,
        K.kundenkarte_id,
        K.kundenkarte_typ_id,
        P.bonuskauf_id,
        P.customer_promotion_fg,
        P.promotion_art,
        P.bby_bewart,
        P.bby_unique,
        P.personal_unique,
        P.personal,
        V.aktion_id AS bby_aktion,
        CASE
            WHEN P.personal_unique = 1 AND COALESCE(V.aktion_id, '') = ''
                THEN 'B'
            WHEN P.personal = 1
                THEN 'C'
            ELSE P.important
        END AS important,
        K.loyalty_berechtigt_fg
    FROM dbp_ods.ods_bon_kopf_1 AS K
    INNER JOIN dbp_etl.bon_artbew_tag_1 AS X
        ON
            K.mandant_id = X.mandant_id AND K.wup_id = X.wup_id AND K.bon_dat
            = X.dat
    INNER JOIN dbp_ods.ods_bon_transaction_1 AS T
        ON
            K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id AND
            K.wup_id = T.wup_id AND K.bon_dat = T.bon_dat
    INNER JOIN dbp_ods.ods_bon_verkauf_1 AS V
        ON
            K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K.bon_id
            = V.bon_id AND K.bon_dat = V.bon_dat
    LEFT JOIN `_de_perf_01` AS P
        ON
            V.mandant_id = P.mandant_id AND V.bon_id = P.bon_id AND V.bon_dat = P.dat_booking AND
            V.bon_zeile = P.bon_zeile
    WHERE
        K.turnover_fg = 1
        AND V.wg_id IN (822)
        AND (
            K.bon_id, K.wup_id) NOT IN (
            SELECT (bon_id, wup_id)
            FROM dbp_ods.ods_bon_storno_1
        )
);


CREATE OR REPLACE TEMPORARY TABLE _retoure AS
SELECT
    K.mandant_id,
    K.wup_id,
    K.bon_dat AS dat,
    0 AS talon_art_korrekt,
    V.kl_art_id,
    COALESCE(CASE
        WHEN TRIM(T.kassensystem_name) <> 'KPOS'
            THEN V.ean_kasse
        ELSE CASE
            WHEN TRIM(V.barcode_string) = ''
                THEN V.ean_kasse
            WHEN LENGTH(V.barcode_string) > 26
                THEN -9999
            ELSE CAST(ROUND(CAST(V.barcode_string AS BIGNUMERIC), 0) AS INTEGER)
        END
    END, V.ean_kasse) AS ean_kasse,
    V.mwst_id,
    V.wg_id,
    V.umsatz_brutto,
    V.menge * V.menge_fg AS menge,
    V.aktion_id,
    0 AS talon_id,
    0 AS talon_id_aus_bon,
    K.bon_id,
    K.kundenkarte_id,
    K.kundenkarte_typ_id,
    z.bonuskauf_id,
    z.customer_promotion_fg,
    z.promotion_art,
    V.aktion_id AS aktion_id_obv,
    V.bon_zeile,
    z.bby_bewart,
    z.bby_unique,
    V.aktion_id AS bby_aktion,
    CASE
        WHEN z.personal_unique = 1 AND COALESCE(V.aktion_id, '') = ''
            THEN 'B'
        WHEN z.personal = 1
            THEN 'C'
        ELSE z.important
    END AS important,
    z.personal_unique,
    z.personal,
    K.loyalty_berechtigt_fg
FROM dbp_ods.ods_bon_kopf_1 AS K
INNER JOIN dbp_ods.ods_bon_transaction_1 AS T ON K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id AND K.wup_id = T.wup_id AND K.bon_dat = T.bon_dat
INNER JOIN dbp_ods.ods_bon_retoure_1 AS V
    ON
        K.mandant_id = V.mandant_id AND K.wup_id = V.wup_id AND K.bon_id
        = V.bon_id AND K.bon_dat = V.bon_dat AND COALESCE(V.talon_id, 0) = 0
INNER JOIN dbp_etl.bon_artbew_tag_1 AS P
    ON
        K.mandant_id = P.mandant_id AND K.wup_id = P.wup_id AND K.bon_dat
        = P.dat
LEFT JOIN (
    SELECT
        Z.mandant_id,
        Z.wup_id,
        Z.bon_id,
        Z.bon_dat,
        Z.kl_art_id,
        Z.bon_zeile,
        Z.bonuskauf_id,
        Z.customer_promotion_fg,
        Z.promotion_art,
        CASE
            WHEN Z.bon_dat < DATE '2022-04-01'
                THEN NULL
            WHEN Z.konditionsart_id IN ('ZBON', 'ZBOV')
                THEN 'N'
            ELSE 'Y'
        END AS important,
        CASE
            WHEN Z.bon_dat < DATE '2022-04-01'
                THEN 0
            ELSE COALESCE(Y.flag, 0)
        END AS bby_bewart,
        CASE
            WHEN Z.bon_dat < DATE '2022-04-01'
                THEN 0
            ELSE COALESCE(X.flag, 0)
        END AS bby_unique,
        CASE
            WHEN Z.bon_dat < DATE '2022-04-01'
                THEN 0
            ELSE COALESCE(W.flag, 0)
        END AS personal_unique,
        CASE
            WHEN Z.bon_dat < DATE '2022-04-01'
                THEN 0
            ELSE COALESCE(U.flag, 0)
        END AS personal
    FROM dbp_etl.de_bd_for_promotion_1 AS Z
    LEFT JOIN `_track_zbon_zbov_unique` AS X
        ON
            Z.mandant_id = X.mandant_id AND Z.wup_id = X.wup_id AND Z.bon_id = X.bon_id
            AND Z.bon_zeile = X.bon_zeile AND Z.bon_dat = X.bon_dat
    LEFT JOIN `_track_zbon_zbov` AS Y
        ON
            Z.mandant_id = Y.mandant_id AND Z.wup_id = Y.wup_id AND Z.bon_id = Y.bon_id AND
            Z.bon_zeile = Y.bon_zeile AND Z.promotion_lfd_nr = Y.promotion_lfd_nr AND Z.bon_dat = Y.bon_dat
    LEFT JOIN `_track_zbon_zbov_unique_personal` AS W
        ON
            Z.mandant_id = W.mandant_id AND Z.wup_id = W.wup_id AND Z.bon_id
            = W.bon_id AND Z.bon_zeile = W.bon_zeile AND Z.bon_dat = W.bon_dat
    LEFT JOIN `_track_zbon_zbov_personal` AS U
        ON
            Z.mandant_id = U.mandant_id AND Z.wup_id = U.wup_id AND Z.bon_id = U.bon_id
            AND Z.bon_zeile = U.bon_zeile AND Z.bon_dat = U.bon_dat
    GROUP BY
        Z.mandant_id,
        Z.wup_id,
        Z.bon_id,
        Z.bon_dat,
        Z.kl_art_id,
        Z.bon_zeile,
        Z.bonuskauf_id,
        Z.customer_promotion_fg,
        Z.promotion_art,
        important,
        bby_bewart,
        bby_unique,
        personal_unique,
        personal
) AS z
    ON
        K.mandant_id = z.mandant_id AND K.wup_id = z.wup_id AND K.bon_id = z.bon_id AND K.bon_dat = z.bon_dat
        AND V.kl_art_id = z.kl_art_id AND V.bon_zeile = z.bon_zeile
WHERE
    K.turnover_fg = 1
    AND V.wg_id IN (822)
    AND (
        K.bon_id, K.bon_dat) NOT IN (
        SELECT (bon_id, bon_dat)
        FROM dbp_ods.ods_bon_storno_1
    );


INSERT INTO dbp_etl.bon_artbew_tmp_talon_1 (
    mandant_id, wup_id, dat, kl_art_id, ean_kasse, mwst_id, wg_id,
    aktion_id, umsatz_brutto, menge, talon_id, talon_id_aus_bon, bon_id, kundenkarte_id, kundenkarte_typ_id, bonuskauf_id,
    customer_promotion_fg, promotion_art, aktion_id_obv, bon_zeile, stichlogik, bby_bewart, bby_unique, bby_aktion,
    important, loyalty_berechtigt_fg
)
(
    SELECT
        mandant_id,
        wup_id,
        dat,
        kl_art_id,
        CAST(ean_kasse AS INTEGER) AS ean_kasse,
        mwst_id,
        wg_id,
        aktion_id,
        CAST(SUM(umsatz_brutto) AS NUMERIC) AS umsatz_brutto,
        CAST(SUM(menge) AS NUMERIC) AS menge,
        CAST(talon_id AS INTEGER) AS talon_id,
        talon_id_aus_bon,
        MAX(bon_id) AS bon_id,
        kundenkarte_id,
        kundenkarte_typ_id,
        MAX(bonuskauf_id) AS bonuskauf_id,
        customer_promotion_fg,
        promotion_art,
        aktion_id_obv,
        bon_zeile,
        stichlogik,
        bby_bewart,
        bby_unique,
        bby_aktion,
        important,
        loyalty_berechtigt_fg
    FROM (SELECT
        mandant_id,
        wup_id,
        dat,
        kl_art_id,
        ean_kasse,
        mwst_id,
        wg_id,
        aktion_id,
        umsatz_brutto,
        menge,
        talon_id,
        talon_id_aus_bon,
        bon_id,
        kundenkarte_id,
        kundenkarte_typ_id,
        bonuskauf_id,
        customer_promotion_fg,
        promotion_art,
        aktion_id_obv,
        bon_zeile,
        bby_bewart,
        bby_unique,
        bby_aktion,
        important,
        stichlogik,
        loyalty_berechtigt_fg,
        ROW_NUMBER() OVER (
            PARTITION BY
                mandant_id, bon_id, dat, wup_id, bon_zeile, kl_art_id, ean_kasse ORDER BY
                stichlogik
                IS NULL, stichlogik, bonuskauf_id IS NULL DESC, bonuskauf_id DESC
        ) AS rk
    FROM (
        SELECT
            mandant_id,
            wup_id,
            dat,
            kl_art_id,
            ean_kasse,
            mwst_id,
            wg_id,
            aktion_id,
            talon_id,
            talon_id_aus_bon,
            kundenkarte_id,
            kundenkarte_typ_id,
            customer_promotion_fg,
            promotion_art,
            aktion_id_obv,
            bon_zeile,
            CASE
                WHEN personal = 1 AND wg_id = 822
                    THEN 100
                WHEN promotion_art = 'PERSONAL_SMP'
                    THEN 99
                WHEN important = 'N' AND bby_unique = 0
                    THEN 9
                WHEN promotion_art = 'PERSONAL'
                    THEN 1
                ELSE CASE
                    WHEN promotion_art = 'CUSTOMER'
                        THEN 2
                    ELSE CASE
                        WHEN promotion_art = 'COMMON'
                            THEN 3
                        ELSE 4
                    END
                END
            END AS stichlogik,
            bby_bewart,
            bby_unique,
            bby_aktion,
            important,
            bon_id,
            loyalty_berechtigt_fg,
            SUM(umsatz_brutto) AS umsatz_brutto,
            SUM(menge) AS menge,
            MAX(bonuskauf_id) AS bonuskauf_id
        FROM (
            SELECT
                x.mandant_id,
                x.wup_id,
                x.bon_dat AS dat,
                CASE
                    WHEN a.kl_art_id IS NOT NULL AND T.mandant_id IS NOT NULL
                        THEN 1
                    ELSE 0
                END AS talon_art_korrekt,
                CASE
                    WHEN
                        CASE
                            WHEN a.kl_art_id IS NOT NULL AND T.mandant_id IS NOT NULL
                                THEN 1
                            ELSE 0
                        END = 1
                        THEN T.kl_art_id
                    ELSE COALESCE(TX.kl_art_id, x.kl_art_id)
                END AS kl_art_id,
                CASE
                    WHEN
                        CASE
                            WHEN a.kl_art_id IS NOT NULL AND T.mandant_id IS NOT NULL
                                THEN 1
                            ELSE 0
                        END = 1
                        THEN 0
                    ELSE x.ean_kasse
                END AS ean_kasse,
                CASE
                    WHEN
                        CASE
                            WHEN a.kl_art_id IS NOT NULL AND T.mandant_id IS NOT NULL
                                THEN 1
                            ELSE 0
                        END = 1
                        THEN MW.mwst_id
                    ELSE COALESCE(TW.mwst_id, x.mwst_id)
                END AS mwst_id,
                CASE
                    WHEN
                        CASE
                            WHEN a.kl_art_id IS NOT NULL AND T.mandant_id IS NOT NULL
                                THEN 1
                            ELSE 0
                        END = 1
                        THEN T.wg_id
                    ELSE COALESCE(TX.wg_id, x.wg_id)
                END AS wg_id,
                COALESCE(
                    T.umsatz_brutto, TX.umsatz_brutto / IF(t2.umsatz_brutto_talon = 0, NULL, t2.umsatz_brutto_talon) * x.umsatz_brutto,
                    x.umsatz_brutto + COALESCE(t13.coupon_betrag, 0.0000)
                ) AS umsatz_brutto,
                COALESCE(CASE
                    WHEN T.menge = 0
                        THEN 1
                    ELSE T.menge
                END, CASE
                    WHEN TX.menge = 0
                        THEN 1
                    ELSE TX.menge
                END, x.menge) AS menge,
                CASE
                    WHEN
                        CASE
                            WHEN a.kl_art_id IS NOT NULL AND T.mandant_id IS NOT NULL
                                THEN 1
                            ELSE 0
                        END = 1
                        THEN T.aktion_id
                    ELSE COALESCE(TX.aktion_id, x.aktion_id)
                END AS aktion_id,
                COALESCE(T.talon_id, TX.talon_id, 0) AS talon_id,
                CASE
                    WHEN T.talon_id IS NULL
                        THEN COALESCE(x.talon_id, 0)
                    ELSE 0
                END AS talon_id_aus_bon,
                x.bon_id,
                x.kundenkarte_id,
                x.kundenkarte_typ_id,
                x.bonuskauf_id,
                x.customer_promotion_fg,
                x.promotion_art,
                x.aktion_id AS aktion_id_obv,
                x.bon_zeile,
                x.bby_bewart,
                x.bby_unique,
                x.bby_aktion,
                x.important,
                x.personal_unique,
                x.personal,
                x.loyalty_berechtigt_fg
            FROM (
                SELECT *
                FROM dbp_etl.bon_kopf_verkauf_1
                WHERE wg_id = 822
            ) AS x
            LEFT JOIN (
                SELECT
                    mandant_id,
                    wup_id,
                    talon_id,
                    SUM(umsatz_brutto) AS umsatz_brutto_talon
                FROM dbp_ods.ods_talon_det_1
                WHERE turnover_fg = 1
                GROUP BY
                    mandant_id,
                    talon_id,
                    wup_id
            ) AS t2 ON x.mandant_id = t2.mandant_id AND x.wup_id = t2.wup_id AND x.talon_id = t2.talon_id
            LEFT JOIN dbp_ods.ods_talon_det_1 AS T
                ON
                    x.mandant_id = T.mandant_id AND x.wup_id = T.wup_id AND
                    x.talon_id = T.talon_id AND T.turnover_fg = 1 AND t2.umsatz_brutto_talon = x.umsatz_brutto
            LEFT JOIN dbp_ods.ods_talon_det_1 AS TX
                ON
                    x.mandant_id = TX.mandant_id AND x.wup_id = TX.wup_id
                    AND x.talon_id = TX.talon_id AND TX.turnover_fg = 1 AND t2.umsatz_brutto_talon <> x.umsatz_brutto
            LEFT JOIN (
                SELECT
                    mandant_id,
                    kl_art_id,
                    mwst_id
                FROM dbp_data.art_1
                WHERE kl_art_id <> 0
                QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, kl_art_id ORDER BY art_id IS NULL DESC, art_id DESC)) = 1
            ) AS a ON T.kl_art_id = a.kl_art_id AND T.mandant_id = a.mandant_id
            LEFT JOIN (
                SELECT
                    mandant_id,
                    kl_art_id,
                    mwst_id
                FROM dbp_data.art_1
                WHERE kl_art_id <> 0
                QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, kl_art_id ORDER BY art_id IS NULL DESC, art_id DESC)) = 1
            ) AS ax ON TX.kl_art_id = ax.kl_art_id AND TX.mandant_id = ax.mandant_id
            LEFT JOIN dbp_data.mwst_per_1 AS MW
                ON
                    T.mandant_id = MW.mandant_id AND x.bon_dat BETWEEN MW.dat_von
                    AND MW.dat_bis AND COALESCE(T.mwst, 0) <> 0 AND T.mwst = MW.mwst AND MW.mwst_id <> 4
            LEFT JOIN dbp_data.mwst_per_1 AS TW
                ON
                    MW.mandant_id = TX.mandant_id AND x.bon_dat BETWEEN MW.dat_von
                    AND MW.dat_bis AND COALESCE(TX.mwst, 0) <> 0 AND TX.mwst = MW.mwst AND MW.mwst_id <> 4
            LEFT JOIN (
                SELECT
                    mandant_id,
                    wup_id,
                    bon_id,
                    bon_zeile,
                    SUM(coupon_betrag) AS coupon_betrag
                FROM dbp_ods.ods_coupon_1
                WHERE coupon_kz = 1
                GROUP BY
                    bon_id,
                    bon_zeile,
                    mandant_id,
                    wup_id
            ) AS t13
                ON
                    x.mandant_id = t13.mandant_id AND x.wup_id = t13.wup_id AND x.bon_id = t13.bon_id AND x.bon_zeile
                    = t13.bon_zeile AND x.talon_id = 0
            UNION ALL
            SELECT *
            FROM `_retoure`
        ) AS a
        GROUP BY
            mandant_id,
            wup_id,
            dat,
            kl_art_id,
            ean_kasse,
            mwst_id,
            wg_id,
            aktion_id,
            talon_id,
            talon_id_aus_bon,
            kundenkarte_id,
            kundenkarte_typ_id,
            customer_promotion_fg,
            promotion_art,
            aktion_id_obv,
            bon_zeile,
            stichlogik,
            bby_bewart,
            bby_unique,
            bby_aktion,
            important,
            bon_id,
            loyalty_berechtigt_fg
    ) AS t17
    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY mandant_id, bon_id, dat, wup_id, bon_zeile, kl_art_id, ean_kasse ORDER BY
            stichlogik IS NULL, stichlogik, bonuskauf_id IS NULL DESC, bonuskauf_id DESC
    )) = 1) AS t19
    GROUP BY
        mandant_id,
        wup_id,
        dat,
        kl_art_id,
        ean_kasse,
        mwst_id,
        wg_id,
        aktion_id,
        talon_id,
        talon_id_aus_bon,
        kundenkarte_id,
        kundenkarte_typ_id,
        customer_promotion_fg,
        promotion_art,
        aktion_id_obv,
        bon_zeile,
        bby_bewart,
        bby_unique,
        bby_aktion,
        important,
        stichlogik,
        loyalty_berechtigt_fg
);


CREATE OR REPLACE TABLE dbp_etl.`_crm_keys` AS
SELECT
    mandant_id,
    wup_id,
    kundenkarte_id,
    bon_dat AS dat,
    COUNT(DISTINCT CASE
        WHEN bon_id <> ''
            THEN bon_id
        ELSE NULL
    END) AS anz_bon
FROM (SELECT
    mandant_id,
    wup_id,
    kundenkarte_id,
    bon_dat,
    bon_id,
    kl_art_id
FROM dbp_etl.bon_kopf_verkauf_1
UNION ALL
SELECT
    mandant_id,
    wup_id,
    kundenkarte_id,
    dat AS bon_dat,
    bon_id,
    kl_art_id
FROM `_retoure`
UNION ALL
SELECT
    mandant_id,
    wup_id,
    kundenkarte_id,
    dat AS bon_dat,
    bon_id,
    kl_art_id
FROM dbp_etl.retoure_x_1) AS x
WHERE (
    mandant_id, kl_art_id) NOT IN (
    SELECT (mandant_id, CAST(FLOOR(art_id / 100) AS INTEGER))
    FROM dbp_data.art_wg_zu_per_1
    WHERE
        mandant_id = 1
        AND arthiertyp_id = 2
        AND dat_bis = DATE '9999-12-31'
        AND wg_id = 961
)
GROUP BY
    mandant_id,
    wup_id,
    kundenkarte_id,
    dat;


DELETE FROM dbp_etl.bon_artbew_tgl_delta_1
WHERE dat > CURRENT_DATE("Europe/Berlin");


DELETE FROM dbp_etl.bon_artbew_tmp_talon_1
WHERE dat > CURRENT_DATE("Europe/Berlin");


DELETE FROM dbp_etl.bon_artbew_tgl_delta_1
WHERE EXISTS (
    SELECT *
    FROM dbp_data.wup_1
    WHERE
        bon_artbew_tgl_delta.mandant_id = mandant_id
        AND bon_artbew_tgl_delta.wup_id = wup_id
        AND bon_artbew_tgl_delta.dat < dat_von
);


DELETE FROM dbp_etl.bon_artbew_tmp_talon_1
WHERE EXISTS (
    SELECT *
    FROM dbp_data.wup_1
    WHERE
        bon_artbew_tmp_talon.mandant_id = mandant_id
        AND bon_artbew_tmp_talon.wup_id = wup_id
        AND bon_artbew_tmp_talon.dat < dat_von
);


CREATE OR REPLACE TABLE dbp_etl.bd_for_promotion_de_1 AS
SELECT *
FROM dbp_ods.ods_promotion_1
WHERE mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _test AS
SELECT
    OP.bon_id,
    OP.wup_id,
    OP.mandant_id,
    OP.bon_dat,
    OP.kl_art_id,
    b.art_id,
    OP.bon_zeile,
    OP.bonuskauf_id,
    OP.customer_promotion_fg,
    OP.promotion_art,
    ab.aktionsart_id,
    C.aktionsart_bez,
    ab.aktion_typ_id,
    D.aktion_typ_bez
FROM dbp_etl.bd_for_promotion_de_1 AS OP
INNER JOIN (
    SELECT
        mandant_id,
        kl_art_id,
        MAX(art_id) AS art_id
    FROM dbp_data.art_1
    GROUP BY
        mandant_id,
        kl_art_id
) AS b ON OP.mandant_id = b.mandant_id AND OP.kl_art_id = b.kl_art_id
LEFT JOIN (
    SELECT
        B.mandant_id,
        B.bonuskauf_id,
        A.aktion_typ_id,
        A.aktionsart_id
    FROM dbp_data.aktion_1 AS A
    LEFT JOIN dbp_data.l_bonuskauf_1 AS B ON A.aktion_id = B.aktion_id AND A.mandant_id = B.mandant_id
    GROUP BY
        A.aktionsart_id,
        A.aktion_typ_id,
        B.mandant_id,
        B.bonuskauf_id
) AS ab ON OP.bonuskauf_id = ab.bonuskauf_id AND OP.mandant_id = ab.mandant_id
LEFT JOIN dbp_data.aktionsart_spr_zu_1 AS C ON OP.mandant_id = C.mandant_id AND ab.aktionsart_id = C.aktionsart_id

LEFT JOIN dbp_data.l_aktion_typ_1 AS D ON OP.mandant_id = D.mandant_id AND ab.aktion_typ_id = D.aktion_typ_id

GROUP BY
    OP.mandant_id,
    OP.bon_id,
    OP.wup_id,
    OP.bon_zeile,
    OP.bonuskauf_id,
    OP.kl_art_id,
    OP.bon_dat,
    OP.customer_promotion_fg,
    OP.promotion_art,
    b.art_id,
    ab.aktion_typ_id,
    ab.aktionsart_id,
    C.aktionsart_bez,
    D.aktion_typ_bez;


CREATE OR REPLACE TABLE dbp_etl.bon_artbew_tmp_talon_db_1 LIKE dbp_etl.bon_artbew_tmp_talon_1;


ALTER TABLE dbp_etl.bon_artbew_tmp_talon_db_1
ADD COLUMN IF NOT EXISTS standard_aktion_id STRING(1000),
ADD COLUMN IF NOT EXISTS aktionsart_id STRING(1000),
ADD COLUMN IF NOT EXISTS aktionsart_bez STRING(1000),
ADD COLUMN IF NOT EXISTS aktion_typ_id_2 STRING(1000),
ADD COLUMN IF NOT EXISTS aktion_typ_bez STRING(1000),
ADD COLUMN IF NOT EXISTS aktionsart_std STRING(1000),
ADD COLUMN IF NOT EXISTS aktionsart_bez_std STRING(1000);


INSERT INTO dbp_etl.bon_artbew_tmp_talon_db_1 (
    mandant_id, wup_id, dat, kl_art_id, ean_kasse, mwst_id,
    wg_id, aktion_id, umsatz_brutto, menge, talon_id, talon_id_aus_bon, bon_id, kundenkarte_id, kundenkarte_typ_id,
    bonuskauf_id, customer_promotion_fg, promotion_art, aktion_id_obv, bon_zeile, stichlogik, bby_bewart, bby_unique,
    bby_aktion, important, loyalty_berechtigt_fg, standard_aktion_id, aktionsart_id, aktionsart_bez, aktion_typ_id_2,
    aktion_typ_bez, aktionsart_std, aktionsart_bez_std
)
(
    SELECT
        Z.mandant_id,
        Z.wup_id,
        Z.dat,
        Z.kl_art_id,
        Z.ean_kasse,
        Z.mwst_id,
        Z.wg_id,
        Z.aktion_id,
        Z.umsatz_brutto,
        Z.menge,
        Z.talon_id,
        Z.talon_id_aus_bon,
        Z.bon_id,
        Z.kundenkarte_id,
        Z.kundenkarte_typ_id,
        Z.bonuskauf_id,
        Z.customer_promotion_fg,
        Z.promotion_art,
        Z.aktion_id_obv,
        Z.bon_zeile,
        Z.stichlogik,
        Z.bby_bewart,
        Z.bby_unique,
        Z.bby_aktion,
        Z.important,
        Z.loyalty_berechtigt_fg,
        zz.standard_aktion_id_,
        XXXXX.aktionsart_id,
        XXXXX.aktionsart_bez,
        XXXXX.aktion_typ_id,
        XXXXX.aktion_typ_bez,
        yyyyy.aktionsart_std,
        yyyyy.aktionsart_bez_std
    FROM dbp_etl.bon_artbew_tmp_talon_1 AS Z
    LEFT JOIN `_test` AS XXXXX
        ON
            Z.bon_id = XXXXX.bon_id AND Z.wup_id = XXXXX.wup_id AND Z.mandant_id = XXXXX.mandant_id
            AND Z.dat = XXXXX.bon_dat AND Z.kl_art_id = XXXXX.kl_art_id AND Z.bon_zeile = XXXXX.bon_zeile
    LEFT JOIN (
        SELECT
            B.mandant_id,
            B.wup_id,
            B.kl_art_id,
            B.dat,
            MAX(A.aktion_id) AS standard_aktion_id_
        FROM dbp_data.aktion_art_wup_zu_1 AS A
        INNER JOIN dbp_etl.bon_artbew_tmp_talon_1 AS B
            ON
                CAST(FLOOR(A.art_id / 100) AS INTEGER) = B.kl_art_id
                AND A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
        INNER JOIN dbp_data.aktion_1 AS C
            ON
                A.mandant_id = C.mandant_id AND A.aktion_id = C.aktion_id AND B.dat
                BETWEEN C.dat_von AND C.dat_bis
        WHERE
            A.grund_sperrung IS NULL
            AND CASE
                WHEN C.mandant_id = 1
                    THEN C.preisaktiviert_fg
                ELSE 0
            END = 1
        GROUP BY
            B.mandant_id,
            B.wup_id,
            B.dat,
            B.kl_art_id
    ) AS zz
        ON
            Z.mandant_id = zz.mandant_id AND Z.wup_id = zz.wup_id AND Z.kl_art_id = zz.kl_art_id AND Z.dat
            = zz.dat
    LEFT JOIN (
        SELECT
            A0.mandant_id,
            A0.aktion_id,
            MAX(A0.aktionsart_id) AS aktionsart_std,
            MAX(B0.aktionsart_bez) AS aktionsart_bez_std
        FROM dbp_data.aktion_1 AS A0
        INNER JOIN dbp_data.aktionsart_spr_zu_1 AS B0
            ON
                A0.mandant_id = B0.mandant_id AND A0.aktionsart_id =
                B0.aktionsart_id AND B0.spr_id = 22
        GROUP BY
            A0.aktion_id,
            A0.mandant_id
    ) AS yyyyy ON zz.mandant_id = yyyyy.mandant_id AND zz.standard_aktion_id_ = yyyyy.aktion_id
    GROUP BY
        Z.mandant_id,
        Z.wup_id,
        Z.dat,
        Z.kl_art_id,
        Z.ean_kasse,
        Z.mwst_id,
        Z.wg_id,
        Z.aktion_id,
        Z.umsatz_brutto,
        Z.menge,
        Z.talon_id,
        Z.talon_id_aus_bon,
        Z.bon_id,
        Z.kundenkarte_id,
        Z.kundenkarte_typ_id,
        Z.bonuskauf_id,
        Z.customer_promotion_fg,
        Z.promotion_art,
        Z.aktion_id_obv,
        Z.bon_zeile,
        Z.stichlogik,
        Z.bby_bewart,
        Z.bby_unique,
        Z.bby_aktion,
        Z.important,
        Z.loyalty_berechtigt_fg,
        XXXXX.aktionsart_id,
        XXXXX.aktionsart_bez,
        XXXXX.aktion_typ_id,
        XXXXX.aktion_typ_bez,
        zz.standard_aktion_id_,
        yyyyy.aktionsart_std,
        yyyyy.aktionsart_bez_std
);


ALTER TABLE dbp_etl.bon_artbew_tmp_talon_1
ADD COLUMN IF NOT EXISTS aktionsart_id STRING(1000),
ADD COLUMN IF NOT EXISTS aktionsart_bez STRING(1000),
ADD COLUMN IF NOT EXISTS aktion_typ_id_2 STRING(1000),
ADD COLUMN IF NOT EXISTS aktion_typ_bez STRING(1000);


update dbp_etl.bon_artbew_tmp_talon_1 set aktionsart_id = b.aktionsart_id_liste, aktionsart_bez = b.aktionsart_bez_liste, aktion_typ_id_2 = b.aktion_typ_liste, aktion_typ_bez = b.aktion_typ_bez_liste from (
    select
        a.mandant_id,
        a.wup_id,
        a.dat,
        a.kl_art_id,
        a.ean_kasse,
        a.mwst_id,
        a.wg_id,
        a.aktion_id,
        a.umsatz_brutto,
        a.menge,
        a.talon_id,
        a.talon_id_aus_bon,
        a.bon_id,
        a.kundenkarte_id,
        a.kundenkarte_typ_id,
        a.bonuskauf_id,
        a.customer_promotion_fg,
        a.promotion_art,
        a.aktion_id_obv,
        a.bon_zeile,
        a.bby_bewart,
        a.bby_unique,
        a.bby_aktion,
        a.important,
        a.stichlogik,
        a.loyalty_berechtigt_fg,
        case
            when
                trim(a.aktionsart_std, ' ') <> ''
                and a.aktionsart_std is not null then concat(a.aktionsart_std, ',', trim(array_to_string(bqutil.fn.cw_array_stable_distinct(array_agg(cast(/* expression of unknown or erroneous type */ a.aktionsart_id as string) ignore nulls order by if(rand() is null, 0, 1) desc, rand())), ','), ','))
            else trim(array_to_string(bqutil.fn.cw_array_stable_distinct(array_agg(cast(/* expression of unknown or erroneous type */ a.aktionsart_id as string) ignore nulls order by if(rand() is null, 0, 1) desc, rand())), ','), ',')
        end as aktionsart_id_liste,
        case
            when
                trim(a.aktionsart_bez_std, ' ') <> ''
                and a.aktionsart_bez_std is not null then concat(a.aktionsart_bez_std, ',', trim(array_to_string(bqutil.fn.cw_array_stable_distinct(array_agg(cast(/* expression of unknown or erroneous type */ a.aktionsart_bez as string) ignore nulls order by if(rand() is null, 0, 1) desc, rand())), ','), ','))
            else trim(array_to_string(bqutil.fn.cw_array_stable_distinct(array_agg(cast(/* expression of unknown or erroneous type */ a.aktionsart_bez as string) ignore nulls order by if(rand() is null, 0, 1) desc, rand())), ','), ',')
        end as aktionsart_bez_liste,
        trim(array_to_string(bqutil.fn.cw_array_stable_distinct(array_agg(cast(/* expression of unknown or erroneous type */ a.aktion_typ_id_2 as string) ignore nulls order by if(rand() is null, 0, 1) desc, rand())), ','), ',') as aktion_typ_liste,
        trim(array_to_string(bqutil.fn.cw_array_stable_distinct(array_agg(cast(/* expression of unknown or erroneous type */ a.aktion_typ_bez as string) ignore nulls order by if(rand() is null, 0, 1) desc, rand())), ','), ',') as aktion_typ_bez_liste,
        a.aktionsart_std,
        a.aktionsart_bez_std
    from
        dbp_etl.bon_artbew_tmp_talon_db_1 as a
    group by all
) as b
where
    bon_artbew_tmp_talon.mandant_id = b.mandant_id
    and bon_artbew_tmp_talon.wup_id = b.wup_id
    and bon_artbew_tmp_talon.dat = b.dat
    and bon_artbew_tmp_talon.kl_art_id = b.kl_art_id
    and coalesce(bon_artbew_tmp_talon.ean_kasse, -numeric '1') = coalesce(b.ean_kasse, -numeric '1')
    and coalesce(bon_artbew_tmp_talon.mwst_id, -numeric '1') = coalesce(b.mwst_id, -numeric '1')
    and coalesce(bon_artbew_tmp_talon.wg_id, -numeric '1') = coalesce(b.wg_id, -numeric '1')
    and bon_artbew_tmp_talon.aktion_id = b.aktion_id
    and coalesce(bon_artbew_tmp_talon.umsatz_brutto, -numeric '1') = coalesce(b.umsatz_brutto, -numeric '1')
    and coalesce(bon_artbew_tmp_talon.menge, -numeric '1') = coalesce(b.menge, -numeric '1')
    and bon_artbew_tmp_talon.talon_id = b.talon_id
    and bon_artbew_tmp_talon.talon_id_aus_bon = b.talon_id_aus_bon
    and coalesce(bon_artbew_tmp_talon.bon_id, '-1') = coalesce(b.bon_id, '-1')
    and coalesce(bon_artbew_tmp_talon.kundenkarte_id, '-1') = coalesce(b.kundenkarte_id, '-1')
    and bon_artbew_tmp_talon.kundenkarte_typ_id = b.kundenkarte_typ_id
    and coalesce(bon_artbew_tmp_talon.bonuskauf_id, '-1') = coalesce(b.bonuskauf_id, '-1')
    and coalesce(bon_artbew_tmp_talon.customer_promotion_fg, -numeric '1') = coalesce(b.customer_promotion_fg, -numeric '1')
    and coalesce(bon_artbew_tmp_talon.promotion_art, '-1') = coalesce(b.promotion_art, '-1')
    and coalesce(bon_artbew_tmp_talon.aktion_id_obv, '-1') = coalesce(b.aktion_id_obv, '-1')
    and coalesce(bon_artbew_tmp_talon.bon_zeile, -numeric '1') = coalesce(b.bon_zeile, -numeric '1')
    and coalesce(bon_artbew_tmp_talon.bby_bewart, -numeric '1') = coalesce(b.bby_bewart, -numeric '1')
    and coalesce(bon_artbew_tmp_talon.bby_unique, -numeric '1') = coalesce(b.bby_unique, -numeric '1')
    and coalesce(bon_artbew_tmp_talon.bby_aktion, '-1') = coalesce(b.bby_aktion, '-1')
    and coalesce(bon_artbew_tmp_talon.important, '-1') = coalesce(b.important, '-1')
    and coalesce(bon_artbew_tmp_talon.stichlogik, -numeric '1') = coalesce(b.stichlogik, -numeric '1')
    and coalesce(bon_artbew_tmp_talon.loyalty_berechtigt_fg, -numeric '1') = coalesce(b.loyalty_berechtigt_fg, -numeric '1');


UPDATE dbp_etl.bon_artbew_tmp_talon_1 SET
    aktionsart_id = SUBSTR(bon_artbew_tmp_talon.aktionsart_id, 1, LENGTH(bon_artbew_tmp_talon.aktionsart_id) - 1),
    aktionsart_bez = SUBSTR(bon_artbew_tmp_talon.aktionsart_bez, 1, LENGTH(bon_artbew_tmp_talon.aktionsart_bez) - 1)
WHERE ENDS_WITH(aktionsart_id, ',');


UPDATE dbp_etl.bon_artbew_tmp_talon_1 SET
    aktion_typ_id_2 = SUBSTR(bon_artbew_tmp_talon.aktion_typ_id_2, 1, LENGTH(bon_artbew_tmp_talon.aktion_typ_id_2) - 1),
    aktion_typ_bez = SUBSTR(bon_artbew_tmp_talon.aktion_typ_bez, 1, LENGTH(bon_artbew_tmp_talon.aktion_typ_bez) - 1)
WHERE ENDS_WITH(aktion_typ_id_2, ',');


-- zmp-einschub, 12.03.2026, -dbay-


ALTER TABLE dbp_etl.bon_artbew_tmp_talon_1
ADD COLUMN IF NOT EXISTS bewart_det_id_zmp INTEGER;


CREATE OR REPLACE TEMPORARY TABLE _check_zmp1 AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.bon_dat,
    A.bon_id,
    A.bon_zeile,
    A.konditionsart_id,
    A.promotion_art,
    A.customer_promotion_fg,
    C.aktion_id,
    C.aktion_id AS aktion_id_verkauf,
    A.bonuskauf_id,
    C.ean_kasse,
    A.kl_art_id,
    A.menge_promo,
    A.betrag_promo_brutto,
    A.umsatz_promo_brutto,
    B.bon_id AS bon_id_kopf
FROM dbp_ods.ods_promotion_1 AS A
INNER JOIN dbp_ods.ods_bon_kopf_1 AS B
    ON
        A.bon_id = B.bon_id AND A.wup_id = B.wup_id AND A.bon_dat = B.bon_dat
        AND A.mandant_id = B.mandant_id
INNER JOIN dbp_ods.ods_bon_verkauf_1 AS C
    ON
        B.mandant_id = C.mandant_id AND B.bon_id = C.bon_id AND B.bon_dat
        = C.bon_dat AND B.wup_id = C.wup_id AND A.bon_zeile = C.bon_zeile
LEFT JOIN dbp_data.l_bonuskauf_1 AS D
    ON
        A.mandant_id = D.mandant_id AND A.bonuskauf_id = D.bonuskauf_id
        AND A.bon_dat BETWEEN D.dat_von AND D.dat_bis
WHERE (A.mandant_id, A.bon_id, A.bon_zeile, A.bon_dat, A.wup_id) IN (SELECT (
    mandant_id, bon_id, bon_zeile, bon_dat,
    wup_id
)
FROM dbp_ods.ods_promotion_1
WHERE
    konditionsart_id IN ('ZMP')
    AND mandant_id = 1
GROUP BY mandant_id,
bon_id,
bon_zeile,
bon_dat,
wup_id)
AND B.turnover_fg = 1
AND B.suspended_fg = 0
AND B.kunde_fg = 1
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.bon_dat,
    A.bon_id,
    A.bon_zeile,
    A.konditionsart_id,
    A.promotion_art,
    A.customer_promotion_fg,
    aktion_id_verkauf,
    A.bonuskauf_id,
    C.ean_kasse,
    A.kl_art_id,
    A.menge_promo,
    A.betrag_promo_brutto,
    A.umsatz_promo_brutto,
    bon_id_kopf;


UPDATE `_check_zmp1` SET
    promotion_art = 'PERSONAL'
WHERE promotion_art = 'XTRA';


CREATE OR REPLACE TEMPORARY TABLE _unique_ AS
SELECT
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile,
    CASE
        WHEN max_aktion_verkauf = '' AND akt_fg = 0
            THEN 100111
        WHEN max_aktion_verkauf = '' AND akt_fg = 1
            THEN 100241
        ELSE 100211
    END AS bewart_det_id
FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.bon_dat,
        A.bon_id,
        A.bon_zeile,
        MAX(b.akt_fg) AS akt_fg,
        MAX(A.aktion_id) AS max_aktion,
        MAX(A.aktion_id_verkauf) AS max_aktion_verkauf,
        COUNT(DISTINCT A.promotion_art) AS anz_promo,
        COUNT(DISTINCT A.konditionsart_id) AS anz_kond,
        MAX(A.promotion_art) AS max_promo,
        MIN(A.promotion_art) AS min_promo,
        MAX(A.konditionsart_id) AS max_kond,
        MIN(A.konditionsart_id) AS min_kond
    FROM `_check_zmp1` AS A
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            bon_dat,
            bon_id,
            bon_zeile,
            CASE
                WHEN MAX(ABS(betrag_promo_brutto)) <> 0.01
                    THEN 1
                ELSE 0
            END AS akt_fg
        FROM `_check_zmp1` AS A
        WHERE
            mandant_id = 1
            AND konditionsart_id = 'ZMP'
            AND konditionsart_id NOT IN ('ZRT3', 'ZK03')
        GROUP BY
            mandant_id,
            wup_id,
            bon_dat,
            bon_id,
            bon_zeile
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.bon_dat = b.bon_dat AND A.bon_id = b.bon_id
            AND A.bon_zeile = b.bon_zeile
    WHERE
        A.mandant_id = 1
        AND CASE
            WHEN A.konditionsart_id = 'ZMP' AND ABS(A.betrag_promo_brutto) <> 0.01
                THEN 0
            ELSE 1
        END = 1
        AND A.konditionsart_id NOT IN ('ZRT3', 'ZK03')
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.bon_dat,
        A.bon_id,
        A.bon_zeile
    HAVING anz_promo = 1 AND min_promo = 'PERSONAL' AND anz_kond = 1
) AS x;


INSERT INTO `_unique_`
(SELECT
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile,
    100241 AS bewart_det_id
FROM (
    SELECT
        mandant_id,
        wup_id,
        bon_dat,
        bon_id,
        bon_zeile,
        MAX(aktion_id) AS max_aktion,
        COUNT(DISTINCT CASE
            WHEN promotion_art = ''
                THEN NULL
            ELSE promotion_art
        END) AS anz_promo,
        COUNT(DISTINCT konditionsart_id) AS anz_kond,
        MAX(promotion_art) AS max_promo,
        MIN(CASE
            WHEN promotion_art = ''
                THEN 'ZZZZ'
            ELSE promotion_art
        END) AS min_promo,
        MAX(konditionsart_id) AS max_kond,
        MIN(konditionsart_id) AS min_kond
    FROM `_check_zmp1` AS A
    WHERE mandant_id = 1
    GROUP BY
        mandant_id,
        wup_id,
        bon_dat,
        bon_id,
        bon_zeile
    HAVING anz_kond = 2 AND max_kond = 'ZMP' AND min_kond = 'ZAR1' AND max_promo = 'PERSONAL' AND min_promo = 'PERSONAL'
) AS x
WHERE (
    mandant_id, wup_id, bon_dat, bon_id, bon_zeile) NOT IN (
    SELECT (mandant_id, wup_id, bon_dat, bon_id, bon_zeile)
    FROM `_unique_` AS X
));


INSERT INTO `_unique_`
(SELECT
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile,
    100231 AS bewart_det_id
FROM (SELECT
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile,
    MAX(aktion_id) AS max_aktion,
    COUNT(DISTINCT CASE
        WHEN promotion_art = ''
            THEN NULL
        ELSE promotion_art
    END) AS anz_promo,
    COUNT(DISTINCT konditionsart_id) AS anz_kond,
    MAX(promotion_art) AS max_promo,
    MIN(CASE
        WHEN promotion_art = ''
            THEN 'ZZZZ'
        ELSE promotion_art
    END) AS min_promo,
    MAX(konditionsart_id) AS max_kond,
    MIN(konditionsart_id) AS min_kond
FROM `_check_zmp1` AS A
WHERE mandant_id = 1
GROUP BY
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile
HAVING anz_kond = 2 AND max_promo = 'PERSONAL' AND min_promo = 'CUSTOMER') AS x
WHERE (
    mandant_id, wup_id, bon_dat, bon_id, bon_zeile) NOT IN (
    SELECT (mandant_id, wup_id, bon_dat, bon_id, bon_zeile)
    FROM `_unique_` AS X
));


INSERT INTO `_unique_`
(SELECT
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile,
    CASE
        WHEN max_aktion_verkauf = '' AND akt_fg = 0
            THEN 100121
        WHEN max_aktion_verkauf = '' AND akt_fg = 1
            THEN 100241
        ELSE 100211
    END AS bewart_det_id
FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.bon_dat,
        A.bon_id,
        A.bon_zeile,
        MAX(b.akt_fg) AS akt_fg,
        MAX(A.aktion_id) AS max_aktion,
        MAX(A.aktion_id_verkauf) AS max_aktion_verkauf,
        COUNT(DISTINCT CASE
            WHEN A.promotion_art = ''
                THEN NULL
            ELSE A.promotion_art
        END) AS anz_promo,
        COUNT(DISTINCT A.konditionsart_id) AS anz_kond,
        MAX(A.promotion_art) AS max_promo,
        MIN(CASE
            WHEN A.promotion_art = ''
                THEN 'ZZZZ'
            ELSE A.promotion_art
        END) AS min_promo,
        MAX(A.konditionsart_id) AS max_kond,
        MIN(A.konditionsart_id) AS min_kond
    FROM `_check_zmp1` AS A
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            bon_dat,
            bon_id,
            bon_zeile,
            CASE
                WHEN MAX(ABS(betrag_promo_brutto)) <> 0.01
                    THEN 1
                ELSE 0
            END AS akt_fg
        FROM `_check_zmp1` AS A
        WHERE
            mandant_id = 1
            AND konditionsart_id = 'ZMP'
        GROUP BY
            mandant_id,
            wup_id,
            bon_dat,
            bon_id,
            bon_zeile
    ) AS b ON A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.bon_dat = b.bon_dat AND A.bon_id = b.bon_id AND A.bon_zeile = b.bon_zeile
    WHERE A.mandant_id = 1
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.bon_dat,
        A.bon_id,
        A.bon_zeile
    HAVING anz_kond = 2 AND max_promo = 'PERSONAL_SMP' AND min_promo = 'PERSONAL'
) AS x
WHERE (
    mandant_id, wup_id, bon_dat, bon_id, bon_zeile) NOT IN (
    SELECT (mandant_id, wup_id, bon_dat, bon_id, bon_zeile)
    FROM `_unique_` AS X
));


CREATE OR REPLACE TEMPORARY TABLE _unique_100221 AS
SELECT
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile,
    100221 AS bewart_det_id
FROM (SELECT
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile,
    MAX(aktion_id) AS max_aktion,
    COUNT(DISTINCT CASE
        WHEN promotion_art = ''
            THEN NULL
        ELSE promotion_art
    END) AS anz_promo,
    COUNT(DISTINCT konditionsart_id) AS anz_kond,
    MAX(promotion_art) AS max_promo,
    MIN(CASE
        WHEN promotion_art = ''
            THEN 'ZZZZ'
        ELSE promotion_art
    END) AS min_promo,
    MAX(konditionsart_id) AS max_kond,
    MIN(konditionsart_id) AS min_kond
FROM `_check_zmp1` AS A
WHERE mandant_id = 1
GROUP BY
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile
HAVING anz_kond = 2 AND max_promo = 'PERSONAL' AND min_promo = 'COMMON') AS x;


DELETE FROM `_unique_`
WHERE (
    mandant_id, wup_id, bon_dat, bon_id, bon_zeile) IN (
    SELECT (mandant_id, wup_id, bon_dat, bon_id, bon_zeile)
    FROM `_unique_100221` AS X
);


INSERT INTO `_unique_`
(SELECT
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile,
    100221 AS bewart_det_id
FROM (SELECT
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile,
    MAX(aktion_id) AS max_aktion,
    COUNT(DISTINCT CASE
        WHEN promotion_art = ''
            THEN NULL
        ELSE promotion_art
    END) AS anz_promo,
    COUNT(DISTINCT konditionsart_id) AS anz_kond,
    MAX(promotion_art) AS max_promo,
    MIN(CASE
        WHEN promotion_art = ''
            THEN 'ZZZZ'
        ELSE promotion_art
    END) AS min_promo,
    MAX(konditionsart_id) AS max_kond,
    MIN(konditionsart_id) AS min_kond
FROM `_check_zmp1` AS A
WHERE mandant_id = 1
GROUP BY
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile
HAVING anz_kond = 2 AND max_promo = 'PERSONAL' AND min_promo = 'COMMON') AS x);


INSERT INTO `_unique_`
(SELECT
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile,
    CASE
        WHEN max_aktion_verkauf = '' AND akt_fg = 0
            THEN 100131
        WHEN max_aktion_verkauf = '' AND akt_fg = 1
            THEN 100241
        ELSE 100211
    END AS bewart_det_id
FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.bon_dat,
        A.bon_id,
        A.bon_zeile,
        MAX(b.akt_fg) AS akt_fg,
        MAX(A.aktion_id) AS max_aktion,
        MAX(A.aktion_id_verkauf) AS max_aktion_verkauf,
        COUNT(DISTINCT CASE
            WHEN A.promotion_art = ''
                THEN NULL
            ELSE A.promotion_art
        END) AS anz_promo,
        COUNT(DISTINCT A.konditionsart_id) AS anz_kond,
        MAX(A.promotion_art) AS max_promo,
        MIN(CASE
            WHEN A.promotion_art = ''
                THEN 'ZZZZ'
            ELSE A.promotion_art
        END) AS min_promo,
        MAX(A.konditionsart_id) AS max_kond,
        STRING_AGG(DISTINCT A.konditionsart_id) AS avg_kond,
        MIN(A.konditionsart_id) AS min_kond
    FROM `_check_zmp1` AS A
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            bon_dat,
            bon_id,
            bon_zeile,
            CASE
                WHEN MAX(ABS(betrag_promo_brutto)) <> 0.01
                    THEN 1
                ELSE 0
            END AS akt_fg
        FROM `_check_zmp1` AS A
        WHERE
            mandant_id = 1
            AND konditionsart_id = 'ZMP'
        GROUP BY
            mandant_id,
            wup_id,
            bon_dat,
            bon_id,
            bon_zeile
    ) AS b ON A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.bon_dat = b.bon_dat AND A.bon_id = b.bon_id AND A.bon_zeile = b.bon_zeile
    WHERE A.mandant_id = 1
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.bon_dat,
        A.bon_id,
        A.bon_zeile
    HAVING
        anz_kond = 2 AND (avg_kond LIKE '%ZBOV%' OR avg_kond LIKE '%ZBON%') AND max_promo = 'PERSONAL' AND min_promo =
        'PERSONAL'
) AS x
WHERE (
    mandant_id, wup_id, bon_dat, bon_id, bon_zeile) NOT IN (
    SELECT (mandant_id, wup_id, bon_dat, bon_id, bon_zeile)
    FROM `_unique_` AS X
));


INSERT INTO `_unique_`
(SELECT
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile,
    100221 AS bewart_det_id
FROM (
    SELECT
        mandant_id,
        wup_id,
        bon_dat,
        bon_id,
        bon_zeile,
        MAX(aktion_id) AS max_aktion,
        COUNT(DISTINCT CASE
            WHEN promotion_art = ''
                THEN NULL
            ELSE promotion_art
        END) AS anz_promo,
        COUNT(DISTINCT konditionsart_id) AS anz_kond,
        MAX(promotion_art) AS max_promo,
        STRING_AGG(DISTINCT promotion_art) AS avg_promo,
        MIN(CASE
            WHEN promotion_art = ''
                THEN 'ZZZZ'
            ELSE promotion_art
        END) AS min_promo,
        MAX(konditionsart_id) AS max_kond,
        STRING_AGG(DISTINCT konditionsart_id) AS avg_kond,
        MIN(konditionsart_id) AS min_kond
    FROM `_check_zmp1` AS A
    WHERE mandant_id = 1
    GROUP BY
        mandant_id,
        wup_id,
        bon_dat,
        bon_id,
        bon_zeile
    HAVING
        anz_kond = 3 AND anz_promo = 2 AND (avg_kond LIKE '%ZBOV%' OR avg_kond LIKE '%ZBON%') AND max_promo =
        'PERSONAL' AND min_promo = 'COMMON'
) AS x
WHERE (
    mandant_id, wup_id, bon_dat, bon_id, bon_zeile) NOT IN (
    SELECT (mandant_id, wup_id, bon_dat, bon_id, bon_zeile)
    FROM `_unique_` AS X
));


INSERT INTO `_unique_`
(SELECT
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile,
    100231 AS bewart_det_id
FROM (
    SELECT
        mandant_id,
        wup_id,
        bon_dat,
        bon_id,
        bon_zeile,
        MAX(aktion_id) AS max_aktion,
        COUNT(DISTINCT CASE
            WHEN promotion_art = ''
                THEN NULL
            ELSE promotion_art
        END) AS anz_promo,
        COUNT(DISTINCT konditionsart_id) AS anz_kond,
        MAX(promotion_art) AS max_promo,
        STRING_AGG(DISTINCT promotion_art) AS avg_promo,
        MIN(CASE
            WHEN promotion_art = ''
                THEN 'ZZZZ'
            ELSE promotion_art
        END) AS min_promo,
        MAX(konditionsart_id) AS max_kond,
        STRING_AGG(DISTINCT konditionsart_id) AS avg_kond,
        MIN(konditionsart_id) AS min_kond
    FROM `_check_zmp1` AS A
    WHERE mandant_id = 1
    GROUP BY
        mandant_id,
        wup_id,
        bon_dat,
        bon_id,
        bon_zeile
    HAVING
        anz_kond = 3 AND anz_promo = 2 AND max_promo = 'PERSONAL' AND min_promo = 'COMMON' AND avg_promo LIKE
        '%CUSTOMER%'
) AS x
WHERE (
    mandant_id, wup_id, bon_dat, bon_id, bon_zeile) NOT IN (
    SELECT (mandant_id, wup_id, bon_dat, bon_id, bon_zeile)
    FROM `_unique_` AS X
));


INSERT INTO `_unique_`
(SELECT
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile,
    CASE
        WHEN max_aktion_verkauf = '' AND akt_fg = 0
            THEN 100111
        ELSE 9999
    END AS bewart_det_id_
FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.bon_dat,
        A.bon_id,
        A.bon_zeile,
        MAX(b.akt_fg) AS akt_fg,
        MAX(A.aktion_id) AS max_aktion,
        MAX(A.aktion_id_verkauf) AS max_aktion_verkauf,
        COUNT(DISTINCT CASE
            WHEN A.promotion_art = ''
                THEN NULL
            ELSE A.promotion_art
        END) AS anz_promo,
        COUNT(DISTINCT A.konditionsart_id) AS anz_kond,
        MAX(A.promotion_art) AS max_promo,
        MIN(CASE
            WHEN A.promotion_art = ''
                THEN 'ZZZZ'
            ELSE A.promotion_art
        END) AS min_promo,
        MAX(A.konditionsart_id) AS max_kond,
        MIN(A.konditionsart_id) AS min_kond
    FROM `_check_zmp1` AS A
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            bon_dat,
            bon_id,
            bon_zeile,
            CASE
                WHEN MAX(ABS(betrag_promo_brutto)) <> 0.01
                    THEN 1
                ELSE 0
            END AS akt_fg
        FROM `_check_zmp1` AS A
        WHERE
            mandant_id = 1
            AND konditionsart_id = 'ZMP'
        GROUP BY
            mandant_id,
            wup_id,
            bon_dat,
            bon_id,
            bon_zeile
    ) AS b ON A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.bon_dat = b.bon_dat AND A.bon_id = b.bon_id AND A.bon_zeile = b.bon_zeile
    WHERE A.mandant_id = 1
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.bon_dat,
        A.bon_id,
        A.bon_zeile
    HAVING
        anz_promo = 1 AND (
            min_promo = 'COMMON' AND max_promo = 'COMMON' OR min_promo = 'CUSTOMER' AND max_promo =
            'COMMON'
        ) AND anz_kond = 1
) AS x
WHERE (
    mandant_id, wup_id, bon_dat, bon_id, bon_zeile) NOT IN (
    SELECT (mandant_id, wup_id, bon_dat, bon_id, bon_zeile)
    FROM `_unique_` AS X
)
GROUP BY
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile,
    bewart_det_id_
HAVING bewart_det_id_ in (100111));


UPDATE dbp_etl.bon_artbew_tmp_talon_1 SET
    bewart_det_id_zmp = b.bewart_det_id
FROM `_unique_` AS b
WHERE
    bon_artbew_tmp_talon.mandant_id = b.mandant_id AND bon_artbew_tmp_talon.wup_id = b.wup_id AND bon_artbew_tmp_talon.dat = b.bon_dat AND bon_artbew_tmp_talon.bon_id = b.bon_id AND bon_artbew_tmp_talon.bon_zeile = b.bon_zeile AND
    bon_artbew_tmp_talon.umsatz_brutto / IF(bon_artbew_tmp_talon.menge = 0, NULL, bon_artbew_tmp_talon.menge) <> 0.01;


CREATE OR REPLACE TEMPORARY TABLE _zmp01 AS
SELECT
    B.mandant_id,
    B.bon_id,
    B.bon_id_kopf,
    B.bon_zeile,
    B.wup_id,
    B.bon_dat,
    SUM(B.betrag_promo_brutto) AS betrag_promo,
    SUM(B.umsatz_promo_brutto) AS umsatz_promo,
    CAST(ABS(SUM(B.umsatz_promo_brutto) / IF(SUM(B.betrag_promo_brutto) = 0, NULL, SUM(B.betrag_promo_brutto))) AS INTEGER)
        AS menge
FROM dbp_ods.ods_bon_verkauf_1 AS A
INNER JOIN `_check_zmp1` AS B
    ON
        A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.bon_dat = B.bon_dat AND A.bon_zeile
        = B.bon_zeile AND A.bon_id = B.bon_id
WHERE
    A.mandant_id = 1
    AND ABS(B.betrag_promo_brutto) = 0.01
    AND B.betrag_promo_brutto < 0
    AND (B.umsatz_promo_brutto < 0 OR B.umsatz_promo_brutto = 0.01)
GROUP BY
    B.mandant_id,
    B.bon_id,
    B.bon_id_kopf,
    B.bon_zeile,
    B.wup_id,
    B.bon_dat;


UPDATE dbp_etl.bon_artbew_tmp_talon_1 SET
    umsatz_brutto = bon_artbew_tmp_talon.umsatz_brutto - b.betrag_promo
FROM `_zmp01` AS b
WHERE bon_artbew_tmp_talon.mandant_id = b.mandant_id AND bon_artbew_tmp_talon.wup_id = b.wup_id AND bon_artbew_tmp_talon.dat = b.bon_dat AND bon_artbew_tmp_talon.bon_id = b.bon_id AND bon_artbew_tmp_talon.bon_zeile = b.bon_zeile;


CREATE OR REPLACE TEMPORARY TABLE _zmp02 AS
SELECT
    b.mandant_id,
    b.bon_id,
    b.bon_id_kopf,
    b.bon_zeile,
    b.wup_id,
    b.bon_dat,
    SUM(CASE
        WHEN ABS(b.betrag_promo_) <> 0.01 AND b.betrag_promo_ > 0
            THEN 0.01
        ELSE -0.01
    END) AS betrag_promo_
FROM dbp_ods.ods_bon_verkauf_1 AS A
INNER JOIN (SELECT
    mandant_id,
    bon_id,
    bon_id_kopf,
    bon_zeile,
    wup_id,
    bon_dat,
    SUM(betrag_promo_brutto) AS betrag_promo_
FROM `_check_zmp1`
WHERE
    ABS(betrag_promo_brutto) <> 0.01
    AND konditionsart_id = 'ZMP'
GROUP BY
    mandant_id,
    2,
    bon_id_kopf,
    bon_zeile,
    wup_id,
    bon_dat
HAVING ABS(betrag_promo_) <> 0.01) AS b
    ON
        A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.bon_dat = b.bon_dat
        AND A.bon_zeile = b.bon_zeile AND A.bon_id = b.bon_id

WHERE A.mandant_id = 1 -- and
-- abs(b.betrag_promo_brutto) <> 0.01

GROUP BY
    b.mandant_id,
    bon_id,
    b.bon_id_kopf,
    b.bon_zeile,
    b.wup_id,
    b.bon_dat;


UPDATE dbp_etl.bon_artbew_tmp_talon_1 SET
    umsatz_brutto = 0
WHERE (
    mandant_id, wup_id, dat, bon_id) IN (
    SELECT (mandant_id, wup_id, bon_dat, bon_id)
    FROM `_zmp01`
) AND umsatz_brutto / IF(menge = 0, NULL, menge
) = 0.01;


UPDATE dbp_etl.bon_artbew_tmp_talon_1 SET
    umsatz_brutto = CAST(bon_artbew_tmp_talon.umsatz_brutto + b.betrag_promo_ AS NUMERIC)
FROM `_zmp02` AS b
WHERE
    bon_artbew_tmp_talon.mandant_id = b.mandant_id AND bon_artbew_tmp_talon.wup_id = b.wup_id AND bon_artbew_tmp_talon.dat = b.bon_dat AND bon_artbew_tmp_talon.bon_id = b.bon_id AND bon_artbew_tmp_talon.bon_zeile = b.bon_zeile AND
    bon_artbew_tmp_talon.umsatz_brutto / IF(bon_artbew_tmp_talon.menge = 0, NULL, bon_artbew_tmp_talon.menge) <> 0.01
    AND bon_artbew_tmp_talon.umsatz_brutto <> 0;


CREATE OR REPLACE TEMPORARY TABLE _zmp03 AS
SELECT
    B.mandant_id,
    B.bon_id,
    B.bon_id_kopf,
    B.bon_zeile,
    B.wup_id,
    B.bon_dat,
    SUM(B.betrag_promo_brutto) AS betrag_promo,
    MAX(B.umsatz_promo_brutto) AS umsatz_promo,
    CAST(ABS(MAX(B.umsatz_promo_brutto) / IF(SUM(B.betrag_promo_brutto) = 0, NULL, SUM(B.betrag_promo_brutto))) AS INTEGER)
        AS menge
FROM dbp_ods.ods_bon_verkauf_1 AS A
INNER JOIN `_check_zmp1` AS B
    ON
        A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.bon_dat = B.bon_dat AND A.bon_zeile
        = B.bon_zeile AND A.bon_id = B.bon_id
WHERE
    A.mandant_id = 1
    AND ABS(B.betrag_promo_brutto) = 0.01
    AND B.betrag_promo_brutto < 0
    AND (B.umsatz_promo_brutto > 0 AND B.umsatz_promo_brutto < 0.01 OR B.umsatz_promo_brutto > 0.01)
GROUP BY
    B.mandant_id,
    B.bon_id,
    B.bon_id_kopf,
    B.bon_zeile,
    B.wup_id,
    B.bon_dat;


UPDATE dbp_etl.bon_artbew_tmp_talon_1 SET
    umsatz_brutto = b.umsatz_promo
FROM `_zmp03` AS b
WHERE
    bon_artbew_tmp_talon.mandant_id = b.mandant_id AND bon_artbew_tmp_talon.wup_id = b.wup_id AND bon_artbew_tmp_talon.dat = b.bon_dat AND bon_artbew_tmp_talon.bon_id = b.bon_id AND bon_artbew_tmp_talon.bon_zeile = b.bon_zeile AND
    bon_artbew_tmp_talon.umsatz_brutto / IF(bon_artbew_tmp_talon.menge = 0, NULL, bon_artbew_tmp_talon.menge) <> 0.01
    AND bon_artbew_tmp_talon.umsatz_brutto <> 0;
