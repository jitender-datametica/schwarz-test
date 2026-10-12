CREATE OR REPLACE TABLE dbp_etl.kmo_artbew_bon (
    mandant_id INTEGER,
    bon_id STRING(25) COLLATE 'und:ci',
    dat_booking DATE,
    wup_id INTEGER,
    bon_zeile INTEGER,
    kl_art_id INTEGER,
    ean_kasse INTEGER,
    menge NUMERIC(29, 4),
    umsatz_brutto NUMERIC(29, 4),
    wg_id INTEGER,
    aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
    lkp_art_id INTEGER,
    lkp_nb_id INTEGER,
    lkp_wg_id INTEGER,
    lkp_arthiertyp_id INTEGER,
    lkp_zek_id STRING(3),
    lkp_mwst_id INTEGER,
    lkp_posten_id STRING(4) COLLATE 'und:ci',
    lkp_umrechnungskurs FLOAT64,
    lkp_mwst NUMERIC(29, 2),
    lkp_wrg STRING(3) COLLATE 'und:ci',
    kundenkarte_id STRING(255) COLLATE 'und:ci'
);


CREATE OR REPLACE TABLE dbp_etl.kmo_artbew_bon_promotion (
    mandant_id INTEGER,
    bon_id STRING(25) COLLATE 'und:ci',
    dat_booking DATE,
    kl_art_id INTEGER,
    bon_zeile INTEGER,
    bonuskauf_id STRING(20) COLLATE 'und:ci',
    konditionsart_id STRING(10) COLLATE 'und:ci',
    umsatz_brutto NUMERIC(29, 4),
    umsatz_promo_brutto NUMERIC(29, 4),
    menge_promo NUMERIC(29, 3)
);


CREATE OR REPLACE TABLE dbp_etl.kmo_artbew_bon_delta (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat_booking DATE NOT NULL,
    xml_name STRING(255)
);


CREATE OR REPLACE TABLE dbp_etl.artbew_kmo_tmp (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    aktion_id STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL,
    promo_fg INTEGER DEFAULT 0 NOT NULL,
    ean_kasse INTEGER DEFAULT 0 NOT NULL,
    einkaufsorganisation_id INTEGER,
    herst_id INTEGER,
    mwst_id INTEGER NOT NULL,
    menge NUMERIC(29, 3),
    wrg STRING(3) COLLATE 'und:ci',
    umsatz_netto NUMERIC(29, 4),
    diff_umsatz_netto_konz NUMERIC(29, 4),
    umsatz_mwst_betrag NUMERIC(29, 4),
    diff_umsatz_mwst_betrag_konz NUMERIC(29, 4),
    ek_brutto NUMERIC(29, 4),
    diff_ek_brutto_konz NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    diff_ek_netto_konz NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    diff_ek_nettonetto_konz NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    diff_ek_kal_basis_konz NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    diff_ek_mep_konz NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    diff_einstandspreis_konz NUMERIC(29, 4),
    logkostenzuschlag NUMERIC(29, 4),
    diff_logkostenzuschlag_konz NUMERIC(29, 4),
    bezugsweg_id INTEGER,
    ek_netto_bnk NUMERIC(29, 4),
    diff_ek_netto_bnk_konz NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    diff_ek_netto_bnk_sachk_konz NUMERIC(29, 4),
    posten_id STRING(2) COLLATE 'und:ci',
    bq_findung_id INTEGER,
    ek_gld NUMERIC(29, 4),
    diff_ek_gld_konz NUMERIC(29, 4)
);


INSERT INTO dbp_etl.kmo_artbew_bon_delta (mandant_id, wup_id, dat_booking, xml_name)
(
    SELECT
        mandant_id,
        wup_id,
        bon_dat,
        datei_name
    FROM dbp_ods.ods_bon_transaction AS T
    WHERE
        mandant_id IN (3, 5, 6, 8)
        AND DATE(bon_dat) BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
    GROUP BY
        mandant_id,
        wup_id,
        bon_dat,
        datei_name
);


CREATE TEMPORARY TABLE IF NOT EXISTS _snap_bon_kopf AS
SELECT *
FROM dbp_ods.ods_bon_kopf
WHERE bon_dat BETWEEN (
    SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
    FROM dbp_etl.kmo_artbew_bon_delta) AND (
    SELECT MAX(dat_booking)
    FROM dbp_etl.kmo_artbew_bon_delta
)
AND mandant_id IN (3, 5, 6, 8);


CREATE TEMPORARY TABLE IF NOT EXISTS _snap_bon_verkauf AS
SELECT *
FROM dbp_ods.ods_bon_verkauf
WHERE bon_dat BETWEEN (
    SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
    FROM dbp_etl.kmo_artbew_bon_delta) AND (
    SELECT MAX(dat_booking)
    FROM dbp_etl.kmo_artbew_bon_delta
)
AND mandant_id IN (3, 5, 6, 8);


CREATE TEMPORARY TABLE IF NOT EXISTS _snap_bon_transaction AS
SELECT *
FROM dbp_ods.ods_bon_transaction
WHERE bon_dat BETWEEN (
    SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
    FROM dbp_etl.kmo_artbew_bon_delta) AND (
    SELECT MAX(dat_booking)
    FROM dbp_etl.kmo_artbew_bon_delta
)
AND mandant_id IN (3, 5, 6, 8);


CREATE TEMPORARY TABLE IF NOT EXISTS _snap_bon_retoure AS
SELECT *
FROM dbp_ods.ods_bon_retoure
WHERE bon_dat BETWEEN (
    SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
    FROM dbp_etl.kmo_artbew_bon_delta) AND (
    SELECT MAX(dat_booking)
    FROM dbp_etl.kmo_artbew_bon_delta
)
AND mandant_id IN (3, 5, 6, 8);


INSERT INTO dbp_etl.kmo_artbew_bon (
    mandant_id, bon_id, dat_booking, wup_id, bon_zeile, kl_art_id,
    ean_kasse, menge, umsatz_brutto, wg_id, aktion_id, lkp_art_id, lkp_nb_id, lkp_wg_id, lkp_arthiertyp_id, lkp_zek_id,
    lkp_mwst_id, lkp_posten_id, lkp_wrg
)
(SELECT
    mandant_id,
    bon_id,
    dat_booking,
    wup_id,
    bon_zeile,
    kl_art_id,
    CAST(ean_kasse AS INTEGER) AS ean_kasse,
    CAST(menge_ AS NUMERIC) AS menge_,
    CAST(umsatz_brutto_ AS NUMERIC) AS umsatz_brutto_,
    wg_id,
    aktion_id,
    CAST(art_id AS INTEGER) AS lkp_art_id,
    nb_id AS lkp_nb_id,
    stamm_wg AS lkp_wg_id,
    arthiertyp_id AS lkp_arthiertyp_id,
    zek_id AS lkp_zek_id,
    CAST(mwst_id AS INTEGER) AS lkp_mwst_id,
    posten_id AS lkp_posten_id,
    wrg_id AS lkp_wrg
FROM (
    SELECT
        K.mandant_id,
        K.bon_id,
        K.dat_booking,
        K.wup_id,
        Z.kl_art_id,
        COALESCE(CASE
            WHEN TRIM(Z.barcode_string) = ''
                THEN COALESCE(Z.ean_kasse, 0)
            WHEN LENGTH(Z.barcode_string) > 26
                THEN -9999
            WHEN ROUND(SAFE_CAST(Z.barcode_string AS BIGNUMERIC), 0) IS NULL
                THEN -9999
            ELSE ROUND(CAST(Z.barcode_string AS BIGNUMERIC), 0)
        END, COALESCE(Z.ean_kasse, 0)) AS ean_kasse,
        Z.bon_zeile,
        CASE
            WHEN K.kunde_fg = 0
                THEN Z.menge * -1
            ELSE Z.menge
        END AS menge_,
        CASE
            WHEN K.kunde_fg = 0
                THEN Z.umsatz_brutto * -1
            ELSE Z.umsatz_brutto
        END AS umsatz_brutto_,
        Z.wg_id,
        Z.aktion_id,
        t1.posten_id,
        t1.mwst_id,
        t1.art_id,
        t1.zek_id,
        X1.wg_id AS stamm_wg,
        X1.arthiertyp_id,
        K.wrg_id,
        0 AS nb_id
    FROM `_snap_bon_kopf` AS K
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            dat_booking
        FROM dbp_etl.kmo_artbew_bon_delta
        GROUP BY
            mandant_id,
            wup_id,
            dat_booking
    ) AS d ON K.mandant_id = d.mandant_id AND K.wup_id = d.wup_id AND K.bon_dat = d.dat_booking
    INNER JOIN `_snap_bon_verkauf` AS Z
        ON
            K.mandant_id = Z.mandant_id AND K.bon_id = Z.bon_id AND K.wup_id = Z.wup_id
            AND K.bon_dat = Z.bon_dat
    INNER JOIN `_snap_bon_transaction` AS T
        ON
            K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id AND K.wup_id = T.wup_id
            AND K.bon_dat = T.bon_dat
    INNER JOIN (SELECT
        mandant_id,
        kl_art_id,
        art_id,
        zek_id,
        mwst_id,
        posten_id
    FROM dbp_data.art AS A
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, kl_art_id ORDER BY art_id IS NULL DESC, art_id DESC)) = 1) AS
    t1 ON Z.mandant_id = t1.mandant_id AND Z.kl_art_id = t1.kl_art_id
    INNER JOIN dbp_data.art_wg_zu_per AS X1
        ON
            t1.mandant_id = X1.mandant_id AND t1.art_id = X1.art_id
            AND X1.arthiertyp_id = 2 AND X1.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.mandant AS X2 ON K.mandant_id = X2.mandant_id
    WHERE
        K.kunde_fg = 1
        AND K.turnover_fg = 1
        AND CASE
            WHEN K.kasse_typ_id <> 3
                THEN 1
            ELSE 0
        END = 1
        AND (
            K.bon_id, K.wup_id) NOT IN (
            SELECT (bon_id, wup_id)
            FROM dbp_ods.ods_bon_storno
        )
    UNION DISTINCT
    SELECT
        K.mandant_id,
        K.bon_id,
        K.dat_booking,
        K.wup_id,
        Z.kl_art_id,
        COALESCE(CASE
            WHEN TRIM(Z.barcode_string) = ''
                THEN COALESCE(Z.ean_kasse, 0)
            WHEN LENGTH(Z.barcode_string) > 26
                THEN -9999
            WHEN ROUND(SAFE_CAST(Z.barcode_string AS BIGNUMERIC), 0) IS NULL
                THEN -9999
            ELSE ROUND(CAST(Z.barcode_string AS BIGNUMERIC), 0)
        END, COALESCE(Z.ean_kasse, 0)) AS ean_kasse,
        Z.bon_zeile,
        CASE
            WHEN K.kunde_fg = 0
                THEN Z.menge * -1
            ELSE Z.menge
        END * Z.menge_fg AS menge_,
        CASE
            WHEN K.kunde_fg = 0
                THEN Z.umsatz_brutto * -1
            ELSE Z.umsatz_brutto
        END AS umsatz_brutto_,
        Z.wg_id,
        Z.aktion_id,
        t7.posten_id,
        t7.mwst_id,
        t7.art_id,
        t7.zek_id,
        X1.wg_id AS stamm_wg,
        X1.arthiertyp_id,
        K.wrg_id,
        0 AS nb_id
    FROM `_snap_bon_kopf` AS K
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            dat_booking
        FROM dbp_etl.kmo_artbew_bon_delta
        GROUP BY
            mandant_id,
            wup_id,
            dat_booking
    ) AS d ON K.mandant_id = d.mandant_id AND K.wup_id = d.wup_id AND K.bon_dat = d.dat_booking
    INNER JOIN `_snap_bon_retoure` AS Z
        ON
            K.mandant_id = Z.mandant_id AND K.bon_id = Z.bon_id AND K.wup_id = Z.wup_id
            AND K.bon_dat = Z.bon_dat
    INNER JOIN `_snap_bon_transaction` AS T
        ON
            K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id AND K.wup_id = T.wup_id
            AND K.bon_dat = T.bon_dat
    INNER JOIN (SELECT
        mandant_id,
        kl_art_id,
        art_id,
        zek_id,
        mwst_id,
        posten_id
    FROM dbp_data.art AS A
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, kl_art_id ORDER BY art_id IS NULL DESC, art_id DESC)) = 1) AS
    t7 ON Z.mandant_id = t7.mandant_id AND Z.kl_art_id = t7.kl_art_id
    INNER JOIN dbp_data.art_wg_zu_per AS X1
        ON
            t7.mandant_id = X1.mandant_id AND t7.art_id = X1.art_id
            AND X1.arthiertyp_id = 2 AND X1.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.mandant AS X2 ON K.mandant_id = X2.mandant_id
    WHERE
        K.kunde_fg = 1
        AND K.turnover_fg = 1
        AND CASE
            WHEN K.kasse_typ_id <> 3
                THEN 1
            ELSE 0
        END = 1
        AND (
            K.bon_id, K.wup_id) NOT IN (
            SELECT (bon_id, wup_id)
            FROM dbp_ods.ods_bon_storno
        )
) AS x);


CREATE OR REPLACE TEMPORARY TABLE _tage AS
SELECT dat
FROM dbp_data.tag
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY));


-- 30.09.2022, -dbay-
--
-- Two updates are taking place for enrichment of countries switching to EUR
-- as new currency.

-- 1. setting the default currency for all rows.


UPDATE dbp_etl.kmo_artbew_bon SET
    lkp_umrechnungskurs = CAST(K.umrechnungskurs AS FLOAT64)
FROM dbp_data.kurs AS K
WHERE
    kmo_artbew_bon.lkp_wrg = K.von_wrg_id -- and dbp_etl.kmo_artbew_bon.dat_booking between k.dat_von and k.dat_bis

    AND K.dat_bis = DATE '9999-12-31' AND K.kurstyp_id = 3 AND K.nach_wrg_id = 'EUR';


-- 2. here is the specific update for our currency changes.


UPDATE dbp_etl.kmo_artbew_bon SET
    lkp_wrg = b.wrg_id,
    lkp_umrechnungskurs = 1 / CAST(
        b.umrechnungskurs AS FLOAT64) FROM (
    SELECT *
    FROM dbp_data.mandant_wrg_zu_per
    WHERE
        CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        AND von_wrg_id IS NOT NULL
) AS b
WHERE kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.lkp_wrg = b.von_wrg_id;


UPDATE dbp_etl.kmo_artbew_bon SET
    lkp_mwst = b.mwst FROM (
    SELECT
        A.mandant_id,
        B.dat,
        A.mwst_id,
        A.mwst
    FROM dbp_data.mwst_per AS A
    INNER JOIN dbp_data.`_tage` AS B ON B.dat BETWEEN A.dat_von AND A.dat_bis
    WHERE A.mandant_id IN (3, 5, 6, 8)
) AS b
WHERE
    kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.dat_booking = b.dat AND kmo_artbew_bon.lkp_mwst_id = b.mwst_id;


UPDATE dbp_etl.kmo_artbew_bon SET
    lkp_mwst_id = b.mwst_id
FROM dbp_data.art_per AS b
WHERE
    kmo_artbew_bon.dat_booking BETWEEN b.dat_von AND b.dat_bis AND kmo_artbew_bon.mandant_id = b.mandant_id AND
    kmo_artbew_bon.lkp_art_id = b.art_id AND kmo_artbew_bon.lkp_mwst_id <> b.mwst_id;


INSERT INTO dbp_etl.kmo_artbew_bon_promotion (
    mandant_id, bon_id, dat_booking, kl_art_id, bon_zeile,
    bonuskauf_id, konditionsart_id, umsatz_brutto, umsatz_promo_brutto, menge_promo
)
(
    SELECT
        K.mandant_id,
        K.bon_id,
        K.dat_booking,
        K.kl_art_id,
        K.bon_zeile,
        P.bonuskauf_id,
        P.konditionsart_id,
        SUM(CAST(P.betrag_promo_brutto * -1 AS NUMERIC)) AS umsatz_brutto,
        SUM(P.umsatz_promo_brutto) AS umsatz_promo_brutto,
        SUM(P.menge_promo) AS menge_promo
    FROM dbp_etl.kmo_artbew_bon AS K
    INNER JOIN dbp_ods.ods_promotion AS P
        ON
            K.mandant_id = P.mandant_id AND K.bon_id = P.bon_id AND K.bon_zeile
            = P.bon_zeile
    WHERE COALESCE(P.betrag_promo_brutto, 0) <> 0
    GROUP BY
        K.mandant_id,
        K.bon_id,
        K.dat_booking,
        K.kl_art_id,
        K.bon_zeile,
        P.bonuskauf_id,
        P.konditionsart_id
);


INSERT INTO dbp_etl.artbew_kmo_tmp (
    wup_id, mandant_id, bewart_id, gp_id, nb_id, art_id, dat, aktion_id,
    promo_fg, ean_kasse, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg, umsatz_netto, diff_umsatz_netto_konz,
    umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, bezugsweg_id, posten_id
)
(
    SELECT
        l.wup_id,
        l.mandant_id,
        CASE
            WHEN l.aktion_id <> ''
                THEN 1002
            ELSE 1001
        END AS bewart_id,
        -1 AS gp_id,
        l.lkp_nb_id AS nb_id,
        l.lkp_art_id AS art_id,
        l.dat_booking AS dat,
        l.aktion_id,
        l.promo_fg,
        l.ean_kasse,
        -1 AS einkaufsorganisation_id,
        -1 AS herst_id,
        l.lkp_mwst_id AS mwst_id,
        l.menge_ AS menge,
        l.lkp_wrg AS wrg,
        ROUND(CAST(l.umsatz_brutto_ * CASE
            WHEN y.conv_fg = 1
                THEN l.lkp_umrechnungskurs
            ELSE 1
        END / (1 + l.lkp_mwst / 100) AS NUMERIC), 4) AS umsatz_netto,
        CAST(CAST(l.umsatz_brutto_ / (1 + l.lkp_mwst / 100) AS NUMERIC) * l.lkp_umrechnungskurs AS NUMERIC) AS diff_umsatz_netto_konz,
        CAST(l.umsatz_brutto_ * CASE
            WHEN y.conv_fg = 1
                THEN l.lkp_umrechnungskurs
            ELSE 1
        END - ROUND(CAST(l.umsatz_brutto_ * CASE
            WHEN y.conv_fg = 1
                THEN l.lkp_umrechnungskurs
            ELSE 1
        END / (1 + l.lkp_mwst / 100) AS NUMERIC), 4) AS NUMERIC) AS umsatz_mwst_betrag,
        CAST(l.umsatz_brutto_ * l.lkp_umrechnungskurs - CAST(l.umsatz_brutto_ / (1 + l.lkp_mwst / 100) AS NUMERIC) * l.lkp_umrechnungskurs AS NUMERIC)
            AS diff_umsatz_mwst_betrag_konz,
        0 AS bezugsweg_id,
        COALESCE(l.lkp_posten_id, ' ') AS posten_id
    FROM (
        SELECT
            Z.mandant_id,
            Z.wup_id,
            Z.lkp_nb_id,
            Z.lkp_art_id,
            Z.lkp_posten_id,
            Z.dat_booking,
            Z.lkp_mwst,
            Z.lkp_mwst_id,
            Z.lkp_wrg,
            Z.lkp_umrechnungskurs,
            CASE
                WHEN COALESCE(p.promotion_brutto, 0) <> 0
                    THEN 1
                ELSE 0
            END AS promo_fg,
            Z.ean_kasse,
            Z.aktion_id,
            SUM(Z.umsatz_brutto) AS umsatz_brutto_,
            SUM(Z.menge) AS menge_,
            SUM(COALESCE(p.promotion_brutto, 0)) AS umsatz_promotion_brutto_
        FROM dbp_etl.kmo_artbew_bon AS Z
        LEFT JOIN (
            SELECT
                mandant_id,
                bon_id,
                dat_booking,
                bon_zeile,
                SUM(umsatz_brutto) AS promotion_brutto
            FROM dbp_etl.kmo_artbew_bon_promotion
            GROUP BY
                mandant_id,
                bon_id,
                dat_booking,
                bon_zeile
        ) AS p
            ON
                Z.mandant_id = p.mandant_id AND Z.bon_id = p.bon_id AND Z.dat_booking = p.dat_booking AND Z.bon_zeile
                = p.bon_zeile
        GROUP BY
            Z.mandant_id,
            Z.wup_id,
            Z.lkp_nb_id,
            Z.lkp_art_id,
            Z.lkp_posten_id,
            Z.dat_booking,
            Z.lkp_mwst,
            Z.lkp_mwst_id,
            Z.lkp_wrg,
            Z.lkp_umrechnungskurs,
            promo_fg,
            Z.ean_kasse,
            Z.aktion_id
    ) AS l
    LEFT JOIN (
        SELECT
            mandant_id,
            wrg_id,
            dat_von,
            dat_bis,
            von_wrg_id,
            umrechnungskurs,
            td_update,
            td_insert,
            1 AS conv_fg
        FROM dbp_data.mandant_wrg_zu_per
        WHERE
            von_wrg_id IS NOT NULL
            AND wrg_id <> von_wrg_id
            AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
    ) AS y ON l.mandant_id = y.mandant_id AND l.lkp_wrg = y.wrg_id
);


DELETE FROM dbp_data.artbew_gtin
WHERE mandant_id IN (3, 5, 6, 8) AND dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY) AND (DATE_SUB(
    CURRENT_DATE("Europe/Berlin"),
    INTERVAL 1 DAY
));


INSERT INTO dbp_data.artbew_gtin (
    mandant_id, wup_id, dat, art_id, gp_id, nb_id, bewart_id, aktion_id,
    promo_fg, ean_kasse, herst_id, mwst_id, wrg, menge, umsatz_netto, diff_umsatz_netto_konz, umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz
)
(
    SELECT
        mandant_id,
        wup_id,
        dat,
        art_id,
        gp_id,
        nb_id,
        bewart_id,
        aktion_id,
        promo_fg,
        ean_kasse,
        herst_id,
        mwst_id,
        wrg,
        SUM(menge) AS menge_sum,
        SUM(umsatz_netto) AS umsatz_netto_sum,
        SUM(diff_umsatz_netto_konz) AS diff_umsatz_netto_konz,
        SUM(umsatz_mwst_betrag) AS umsatz_mwst_betrag_sum,
        SUM(diff_umsatz_mwst_betrag_konz) AS diff_umsatz_mwst_betrag_konz
    FROM dbp_etl.artbew_kmo_tmp
    WHERE
        mandant_id IN (3, 5, 6, 8)
        AND dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
    GROUP BY
        wup_id,
        mandant_id,
        bewart_id,
        gp_id,
        nb_id,
        art_id,
        dat,
        aktion_id,
        promo_fg,
        ean_kasse,
        herst_id,
        mwst_id,
        wrg
);


DELETE FROM dbp_data.artbew_gtin
WHERE mandant_id IN (1, 2, 4, 7) AND dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY) AND (DATE_SUB(
    CURRENT_DATE("Europe/Berlin"),
    INTERVAL 1 DAY
));


INSERT INTO dbp_data.artbew_gtin (
    mandant_id, wup_id, dat, art_id, gp_id, nb_id, bewart_id, aktion_id,
    promo_fg, ean_kasse, herst_id, mwst_id, wrg, menge, umsatz_netto, diff_umsatz_netto_konz, umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz
)
(
    SELECT
        mandant_id,
        wup_id,
        dat,
        art_id,
        gp_id,
        nb_id,
        bewart_id,
        aktion_id,
        promo_fg,
        ean_kasse,
        herst_id,
        mwst_id,
        wrg,
        menge,
        umsatz_netto,
        diff_umsatz_netto_konz,
        umsatz_mwst_betrag,
        diff_umsatz_mwst_betrag_konz
    FROM dbp_data.artbew
    WHERE
        mandant_id IN (1, 2, 4, 7)
        AND dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
);
