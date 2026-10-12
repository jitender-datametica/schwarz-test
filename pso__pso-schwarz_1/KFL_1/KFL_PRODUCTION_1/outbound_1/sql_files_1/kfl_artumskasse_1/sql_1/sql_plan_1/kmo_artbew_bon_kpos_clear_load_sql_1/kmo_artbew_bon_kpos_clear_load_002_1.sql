CREATE OR REPLACE TABLE dbp_etl.kmo_artbew_bon_1 (
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
    kundenkarte_id STRING(255) COLLATE 'und:ci',
    kundenkarte_typ_id INTEGER DEFAULT 0 NOT NULL,
    bonuskauf_id STRING(20) COLLATE 'und:ci',
    bonuskauf_id_lb STRING(20) COLLATE 'und:ci',
    aktion_typ_id STRING(4) COLLATE 'und:ci',
    konditionsart_id STRING(4) COLLATE 'und:ci',
    vk_aktion_brutto NUMERIC(29, 3),
    vk_brutto NUMERIC(29, 2),
    betrag_promo_brutto_bby NUMERIC(29, 4),
    betrag_promo_brutto_kdn NUMERIC(29, 4),
    betrag_promo_brutto_kdp NUMERIC(29, 4),
    betrag_promo_brutto_null NUMERIC(29, 4),
    bde_kundenkarte_id STRING(255) COLLATE 'und:ci',
    customer_promotion_fg INTEGER DEFAULT 0,
    promotion_art STRING(100),
    important STRING(1),
    bewart_det_id INTEGER,
    standard_aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
    loyalty_berechtigt_fg INTEGER
);


CREATE OR REPLACE TABLE dbp_etl.kmo_artbew_bon_promotion_1 (
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


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_bon_dat_1;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_artbew_bon_dat_1 (
    dat DATE NOT NULL
);


CREATE OR REPLACE TABLE dbp_etl.kmo_artbew_bon_delta_1 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat_booking DATE NOT NULL,
    xml_name STRING(255)
);


INSERT INTO dbp_etl.kmo_artbew_bon_delta_1 (mandant_id, wup_id, dat_booking, xml_name)
(
    SELECT *
    FROM dbp_etl.kmo_artbew_bon_delta_main_1
    WHERE dat_booking >= DATE '2022-04-01'
);


CREATE OR REPLACE TABLE dbp_etl.bd_for_promotion_1 AS
SELECT *
FROM dbp_ods.ods_promotion_1
WHERE bon_dat BETWEEN (
    SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
    FROM dbp_etl.kmo_artbew_bon_delta_1) AND (
    SELECT MAX(dat_booking)
    FROM dbp_etl.kmo_artbew_bon_delta_1
);


UPDATE dbp_etl.bd_for_promotion_1 SET
    promotion_art = 'PERSONAL'
WHERE promotion_art = 'XTRA';


CREATE OR REPLACE TEMPORARY TABLE _track_zbon_zbov_unique AS
SELECT
    mandant_id,
    bon_id,
    bon_zeile,
    bon_dat,
    wup_id,
    1 AS flag
FROM dbp_etl.bd_for_promotion_1
WHERE (
    mandant_id, bon_id, bon_zeile, bon_dat, wup_id) IN (
    SELECT (mandant_id, bon_id, bon_zeile, bon_dat, wup_id)
    FROM dbp_etl.bd_for_promotion_1
    WHERE konditionsart_id IN ('ZBON', 'ZBOV')
    GROUP BY mandant_id,
    bon_id,
    bon_zeile,
    bon_dat,
    wup_id
)
AND konditionsart_id NOT IN ('ZRT3', 'ZTAG', 'ZGEB')
AND promotion_art NOT IN ('PERSONAL_SMP')
GROUP BY
    mandant_id,
    bon_id,
    wup_id,
    bon_zeile,
    bon_dat
HAVING COUNT(DISTINCT konditionsart_id) = 1;


CREATE OR REPLACE TEMPORARY TABLE _track_zbon_zbov_unique_smp AS
SELECT
    mandant_id,
    bon_id,
    bon_zeile,
    bon_dat,
    wup_id,
    1 AS flag
FROM dbp_etl.bd_for_promotion_1
WHERE (
    mandant_id, bon_id, bon_zeile, bon_dat, wup_id) IN (
    SELECT (mandant_id, bon_id, bon_zeile, bon_dat, wup_id)
    FROM dbp_etl.bd_for_promotion_1
    WHERE promotion_art = 'PERSONAL_SMP'
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
    wup_id,
    bon_zeile,
    bon_dat
HAVING COUNT(DISTINCT promotion_art) = 1;


CREATE OR REPLACE TEMPORARY TABLE _track_zbon_zbov AS
SELECT
    mandant_id,
    bon_id,
    bon_zeile,
    bon_dat,
    wup_id,
    promotion_lfd_nr,
    1 AS flag
FROM dbp_etl.bd_for_promotion_1
WHERE konditionsart_id IN ('ZBON', 'ZBOV')
GROUP BY
    mandant_id,
    bon_id,
    bon_zeile,
    bon_dat,
    wup_id,
    promotion_lfd_nr;


CREATE OR REPLACE TABLE dbp_etl._zwischen1_1 AS
SELECT
    K.mandant_id,
    K.bon_id,
    K.dat_booking,
    K.wup_id,
    K.wrg_id,
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
    K.kundenkarte_id,
    K.kundenkarte_typ_id,
    p.bonuskauf_id,
    CASE
        WHEN TRIM(p.bonrabatt_bewart) IN ('Y') AND TRIM(Z.aktion_id) = ''
            THEN 'KDB'
        WHEN TRIM(p.aktion_typ_id) IN ('KDP')
            THEN 'KDP'
        WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
            THEN 'KDN'
        ELSE 'KDA'
    END AS aktion_typ_id_,
    A.vk_aktion_brutto,
    VK.vk_brutto,
    CASE
        WHEN
            p.customer_promotion_fg = 0 AND (TRIM(p.bonrabatt_bewart) IN ('Y') AND CASE
                WHEN TRIM(p.bonrabatt_bewart) IN ('Y') AND TRIM(Z.aktion_id) = ''
                    THEN 'KDB'
                WHEN TRIM(p.aktion_typ_id) IN ('KDP')
                    THEN 'KDP'
                WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
                    THEN 'KDN'
                ELSE 'KDA'
            END = 'KDB' OR TRIM(p.bonrabatt_bby) IN ('Y')) OR p.customer_promotion_fg = 1 AND p.promotion_art IN ('CUSTOMER'
            ) AND TRIM(p.aktion_typ_id) IN ('KPB', 'KDN', 'KDP', 'KDB') AND TRIM(p.bonrabatt_bby) IN ('Y') AND BDE.kundenkarte_id
            IS NULL OR TRIM(p.aktion_typ_id) IN ('KPB', 'KDN', 'KDP', 'KDB') AND TRIM(p.promotion_art) IN ('COMMON', 'PERSONAL'
            ) AND TRIM(p.bonrabatt_bby) IN ('Y')
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_bby,
    CASE
        WHEN
            p.customer_promotion_fg = 1 AND p.promotion_art = 'CUSTOMER' AND TRIM(p.aktion_typ_id) IN ('KDN') AND TRIM(p.bonrabatt_bby
            ) IN ('Y') AND BDE.kundenkarte_id IS NULL AND p.important = 'N'
            THEN NULL
        WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN') AND p.important = 'Y'
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_kdn,
    CASE
        WHEN TRIM(p.aktion_typ_id) = 'KDP' AND p.bonrabatt_bby = 'N'
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_kdp,
    CASE
        WHEN (p.aktion_typ_id IS NULL OR TRIM(p.aktion_typ_id) = '') AND CASE
            WHEN TRIM(p.bonrabatt_bewart) IN ('Y') AND TRIM(Z.aktion_id) = ''
                THEN 'KDB'
            WHEN TRIM(p.aktion_typ_id) IN ('KDP')
                THEN 'KDP'
            WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
                THEN 'KDN'
            ELSE 'KDA'
        END <> 'KDB' AND TRIM(p.bonrabatt_bby) IN ('N')
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_null,
    p.konditionsart_id,
    p.bonuskauf_id_lb,
    BDE.kundenkarte_id AS bde_kundenkarte_id,
    p.customer_promotion_fg,
    CASE
        WHEN p.promotion_art = 'PERSONAL_SMP'
            THEN 99
        WHEN p.important = 'N' AND p.bonrabatt_bewart = 'N'
            THEN 9
        WHEN p.promotion_art = 'PERSONAL'
            THEN 1
        ELSE CASE
            WHEN p.promotion_art = 'CUSTOMER' OR p.promotion_art = 'PAYBACK'
                THEN 2
            ELSE CASE
                WHEN p.promotion_art = 'COMMON'
                    THEN 3
                ELSE 4
            END
        END
    END AS stichlogik,
    CASE
        WHEN p.bonuskauf_id IS NOT NULL AND CAST(p.bonuskauf_id AS FLOAT64) <> 0 AND p.bonuskauf_id_lb IS NULL
            THEN 1
        ELSE 0
    END AS bonus_flag,
    CASE
        WHEN p.smp_unique = 'Y' AND Z.aktion_id = ''
            THEN 'A'
        ELSE p.important
    END AS important,
    A.aktion_id AS standard_aktion_id,
    K.loyalty_berechtigt_fg
FROM dbp_ods.ods_bon_kopf_1 AS K
INNER JOIN (
    SELECT
        mandant_id,
        wup_id,
        dat_booking
    FROM dbp_etl.kmo_artbew_bon_delta_1
    GROUP BY
        mandant_id,
        wup_id,
        dat_booking
) AS d ON K.mandant_id = d.mandant_id AND K.wup_id = d.wup_id AND K.dat_booking = d.dat_booking
INNER JOIN dbp_ods.ods_bon_verkauf_1 AS Z
    ON
        K.mandant_id = Z.mandant_id AND K.bon_id = Z.bon_id AND K.wup_id
        = Z.wup_id
INNER JOIN dbp_ods.ods_bon_transaction_1 AS T
    ON
        K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id AND K.wup_id = T.wup_id
LEFT JOIN dbp_data.aktion_art_wup_zu_1 AS A
    ON
        Z.aktion_id = A.aktion_id AND Z.mandant_id = A.mandant_id
        AND Z.wup_id = A.wup_id AND Z.kl_art_id = A.art_id / 10
LEFT JOIN dbp_data.art_wup_vk_per_1 AS VK_1
    ON
        Z.bon_dat BETWEEN VK.dat_von AND VK.dat_bis AND Z.kl_art_id =
        VK.art_id / 10 AND Z.mandant_id = VK.mandant_id AND Z.wup_id = VK.wup_id
LEFT JOIN dbp_data.bewart_det_ecommerce_1 AS BDE
    ON
        K.kundenkarte_id = BDE.kundenkarte_id AND K.mandant_id
        = BDE.mandant_id
LEFT JOIN (
    SELECT
        OP.bon_id,
        OP.wup_id,
        OP.mandant_id,
        OP.bon_dat,
        OP.kl_art_id,
        OP.bon_zeile,
        OP.bonuskauf_id,
        OP.customer_promotion_fg,
        OP.promotion_art,
        SUM(OP.betrag_promo_brutto) AS betrag_promo_brutto,
        CASE
            WHEN OP.konditionsart_id IN ('ZRT3', 'ZTAG', 'ZGEB')
                THEN 'N'
            ELSE 'Y'
        END AS konditionsart_id,
        CASE
            WHEN OP.konditionsart_id IN ('ZBON', 'ZBOV')
                THEN 'N'
            ELSE 'Y'
        END AS important,
        t2.aktion_typ_id,
        t2.bonuskauf_id AS bonuskauf_id_lb,
        CASE
            WHEN X.flag = 1
                THEN 'Y'
            ELSE 'N'
        END AS bonrabatt_bewart,
        CASE
            WHEN Y.flag = 1 AND t2.aktion_typ_id <> ''
                THEN 'Y'
            ELSE 'N'
        END AS bonrabatt_bby,
        CASE
            WHEN Z0.flag = 1
                THEN 'Y'
            ELSE 'N'
        END AS smp_unique
    FROM dbp_etl.bd_for_promotion_1 AS OP
    LEFT JOIN `_track_zbon_zbov_unique` AS X
        ON
            OP.mandant_id = X.mandant_id AND OP.wup_id = X.wup_id AND OP.bon_id = X.bon_id
            AND OP.bon_zeile = X.bon_zeile AND OP.bon_dat = X.bon_dat
    LEFT JOIN `_track_zbon_zbov` AS Y
        ON
            OP.mandant_id = Y.mandant_id AND OP.wup_id = Y.wup_id AND OP.bon_id = Y.bon_id
            AND OP.bon_zeile = Y.bon_zeile AND OP.promotion_lfd_nr = Y.promotion_lfd_nr AND OP.bon_dat = Y.bon_dat
    LEFT JOIN `_track_zbon_zbov_unique_smp` AS Z0
        ON
            OP.mandant_id = Z0.mandant_id AND OP.wup_id = Z0.wup_id AND OP.bon_id
            = Z0.bon_id AND OP.bon_zeile = Z0.bon_zeile AND OP.bon_dat = Z0.bon_dat
    LEFT JOIN (
        SELECT
            B.mandant_id,
            B.bonuskauf_id,
            MAX(A0.aktion_typ_id) AS aktion_typ_id
        FROM dbp_data.aktion_1 AS A0
        LEFT JOIN dbp_data.l_bonuskauf_1 AS B ON A0.aktion_id = B.aktion_id AND A0.mandant_id = B.mandant_id
        GROUP BY
            B.mandant_id,
            B.bonuskauf_id
    ) AS t2 ON OP.bonuskauf_id = t2.bonuskauf_id AND OP.mandant_id = t2.mandant_id
    GROUP BY
        OP.bon_id,
        OP.wup_id,
        OP.mandant_id,
        OP.bon_dat,
        OP.kl_art_id,
        OP.bon_zeile,
        OP.bonuskauf_id,
        OP.customer_promotion_fg,
        OP.promotion_art,
        konditionsart_id,
        important,
        t2.aktion_typ_id,
        bonuskauf_id_lb,
        bonrabatt_bewart,
        bonrabatt_bby,
        smp_unique
) AS p
    ON
        K.bon_id = p.bon_id AND K.wup_id = p.wup_id AND K.mandant_id = p.mandant_id AND K.bon_dat = p.bon_dat
        AND Z.kl_art_id = p.kl_art_id AND Z.bon_zeile = p.bon_zeile
WHERE
    K.mandant_id > 1
    AND K.kunde_fg = 1
    AND K.turnover_fg = 1
    AND K.bon_dat BETWEEN (
        SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
        FROM dbp_etl.kmo_artbew_bon_delta_1) AND (
        SELECT MAX(dat_booking)
        FROM dbp_etl.kmo_artbew_bon_delta_1
    )
    AND Z.bon_dat BETWEEN (
        SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
        FROM dbp_etl.kmo_artbew_bon_delta_1) AND (
        SELECT MAX(dat_booking)
        FROM dbp_etl.kmo_artbew_bon_delta_1
    )
    AND T.bon_dat BETWEEN (
        SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
        FROM dbp_etl.kmo_artbew_bon_delta_1) AND (
        SELECT MAX(dat_booking)
        FROM dbp_etl.kmo_artbew_bon_delta_1
    )
    AND CASE
        WHEN K.kasse_typ_id <> 3
            THEN 1
        ELSE 0
    END = 1
    AND (
        K.bon_id, K.wup_id) NOT IN (
        SELECT (bon_id, wup_id)
        FROM dbp_ods.ods_bon_storno_1
    )
    AND Z.wg_id NOT IN (822)
UNION DISTINCT
SELECT
    K.mandant_id,
    K.bon_id,
    K.dat_booking,
    K.wup_id,
    K.wrg_id,
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
    K.kundenkarte_id,
    K.kundenkarte_typ_id,
    p.bonuskauf_id,
    CASE
        WHEN TRIM(p.bonrabatt_bewart) IN ('Y') AND TRIM(Z.aktion_id) = ''
            THEN 'KDB'
        WHEN TRIM(p.aktion_typ_id) IN ('KDP')
            THEN 'KDP'
        WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
            THEN 'KDN'
        ELSE 'KDA'
    END AS aktion_typ_id_,
    A.vk_aktion_brutto,
    VK.vk_brutto,
    CASE
        WHEN
            p.customer_promotion_fg = 0 AND (TRIM(p.bonrabatt_bewart) IN ('Y') AND CASE
                WHEN TRIM(p.bonrabatt_bewart) IN ('Y') AND TRIM(Z.aktion_id) = ''
                    THEN 'KDB'
                WHEN TRIM(p.aktion_typ_id) IN ('KDP')
                    THEN 'KDP'
                WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
                    THEN 'KDN'
                ELSE 'KDA'
            END = 'KDB' OR TRIM(p.bonrabatt_bby) IN ('Y')) OR p.customer_promotion_fg = 1 AND p.promotion_art IN ('CUSTOMER'
            ) AND TRIM(p.aktion_typ_id) IN ('KPB', 'KDN', 'KDP', 'KDB') AND TRIM(p.bonrabatt_bby) IN ('Y') AND BDE.kundenkarte_id
            IS NULL OR TRIM(p.aktion_typ_id) IN ('KPB', 'KDN', 'KDP', 'KDB') AND TRIM(p.promotion_art) IN ('COMMON', 'PERSONAL'
            ) AND TRIM(p.bonrabatt_bby) IN ('Y')
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_bby,
    CASE
        WHEN
            p.customer_promotion_fg = 1 AND p.promotion_art = 'CUSTOMER' AND TRIM(p.aktion_typ_id) IN ('KDN') AND TRIM(p.bonrabatt_bby
            ) IN ('Y') AND BDE.kundenkarte_id IS NULL
            THEN NULL
        WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN') AND p.important = 'Y'
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_kdn,
    CASE
        WHEN TRIM(p.aktion_typ_id) = 'KDP' AND p.bonrabatt_bby = 'N'
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_kdp,
    CASE
        WHEN
            p.aktion_typ_id IS NULL AND CASE
                WHEN TRIM(p.bonrabatt_bewart) IN ('Y') AND TRIM(Z.aktion_id) = ''
                    THEN 'KDB'
                WHEN TRIM(p.aktion_typ_id) IN ('KDP')
                    THEN 'KDP'
                WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
                    THEN 'KDN'
                ELSE 'KDA'
            END <> 'KDB' AND TRIM(p.bonrabatt_bby) IN ('N')
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_null,
    p.konditionsart_id,
    p.bonuskauf_id_lb,
    BDE.kundenkarte_id AS bde_kundenkarte_id,
    p.customer_promotion_fg,
    CASE
        WHEN p.promotion_art = 'PERSONAL_SMP'
            THEN 99
        WHEN p.important = 'N' AND p.bonrabatt_bewart = 'N'
            THEN 9
        WHEN p.promotion_art = 'PERSONAL'
            THEN 1
        ELSE CASE
            WHEN p.promotion_art = 'CUSTOMER' OR p.promotion_art = 'PAYBACK'
                THEN 2
            ELSE CASE
                WHEN p.promotion_art = 'COMMON'
                    THEN 3
                ELSE 4
            END
        END
    END AS stichlogik,
    CASE
        WHEN p.bonuskauf_id IS NOT NULL AND CAST(p.bonuskauf_id AS FLOAT64) <> 0 AND p.bonuskauf_id_lb IS NULL
            THEN 1
        ELSE 0
    END AS bonus_flag,
    CASE
        WHEN p.smp_unique = 'Y' AND Z.aktion_id = ''
            THEN 'Z'
        ELSE p.important
    END AS important,
    A.aktion_id AS standard_aktion_id,
    K.loyalty_berechtigt_fg
FROM dbp_ods.ods_bon_kopf_1 AS K
INNER JOIN (
    SELECT
        mandant_id,
        wup_id,
        dat_booking
    FROM dbp_etl.kmo_artbew_bon_delta_1
    GROUP BY
        mandant_id,
        wup_id,
        dat_booking
) AS d ON K.mandant_id = d.mandant_id AND K.wup_id = d.wup_id AND K.dat_booking = d.dat_booking
INNER JOIN dbp_ods.ods_bon_retoure_1 AS Z
    ON
        K.mandant_id = Z.mandant_id AND K.bon_id = Z.bon_id AND K.wup_id
        = Z.wup_id
INNER JOIN dbp_ods.ods_bon_transaction_1 AS T
    ON
        K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id AND K.wup_id = T.wup_id
LEFT JOIN dbp_data.aktion_art_wup_zu_1 AS A
    ON
        Z.aktion_id = A.aktion_id AND Z.mandant_id = A.mandant_id
        AND Z.wup_id = A.wup_id AND Z.kl_art_id = A.art_id / 10
LEFT JOIN dbp_data.art_wup_vk_per_1 AS VK_1
    ON
        Z.bon_dat BETWEEN VK.dat_von AND VK.dat_bis AND Z.kl_art_id =
        VK.art_id / 10 AND Z.mandant_id = VK.mandant_id AND Z.wup_id = VK.wup_id
LEFT JOIN dbp_data.bewart_det_ecommerce_1 AS BDE
    ON
        K.kundenkarte_id = BDE.kundenkarte_id AND K.mandant_id
        = BDE.mandant_id
LEFT JOIN (
    SELECT
        OP.bon_id,
        OP.wup_id,
        OP.mandant_id,
        OP.bon_dat,
        OP.kl_art_id,
        OP.bon_zeile,
        OP.bonuskauf_id,
        OP.customer_promotion_fg,
        OP.promotion_art,
        SUM(OP.betrag_promo_brutto) AS betrag_promo_brutto,
        CASE
            WHEN OP.konditionsart_id IN ('ZRT3', 'ZTAG', 'ZGEB')
                THEN 'N'
            ELSE 'Y'
        END AS konditionsart_id,
        CASE
            WHEN OP.konditionsart_id IN ('ZBON', 'ZBOV')
                THEN 'N'
            ELSE 'Y'
        END AS important,
        t24.aktion_typ_id,
        t24.bonuskauf_id AS bonuskauf_id_lb,
        CASE
            WHEN X.flag = 1
                THEN 'Y'
            ELSE 'N'
        END AS bonrabatt_bewart,
        CASE
            WHEN Y.flag = 1
                THEN 'Y'
            ELSE 'N'
        END AS bonrabatt_bby,
        CASE
            WHEN Z1.flag = 1
                THEN 'Y'
            ELSE 'N'
        END AS smp_unique
    FROM dbp_etl.bd_for_promotion_1 AS OP
    LEFT JOIN `_track_zbon_zbov_unique` AS X
        ON
            OP.mandant_id = X.mandant_id AND OP.wup_id = X.wup_id AND OP.bon_id = X.bon_id
            AND OP.bon_zeile = X.bon_zeile AND OP.bon_dat = X.bon_dat
    LEFT JOIN `_track_zbon_zbov` AS Y
        ON
            OP.mandant_id = Y.mandant_id AND OP.wup_id = Y.wup_id AND OP.bon_id = Y.bon_id
            AND OP.bon_zeile = Y.bon_zeile AND OP.promotion_lfd_nr = Y.promotion_lfd_nr AND OP.bon_dat = Y.bon_dat
    LEFT JOIN `_track_zbon_zbov_unique_smp` AS Z1
        ON
            OP.mandant_id = Z1.mandant_id AND OP.wup_id = Z1.wup_id AND OP.bon_id
            = Z1.bon_id AND OP.bon_zeile = Z1.bon_zeile AND OP.bon_dat = Z1.bon_dat
    LEFT JOIN (
        SELECT
            B.mandant_id,
            B.bonuskauf_id,
            MAX(A1.aktion_typ_id) AS aktion_typ_id
        FROM dbp_data.aktion_1 AS A1
        LEFT JOIN dbp_data.l_bonuskauf_1 AS B ON A1.aktion_id = B.aktion_id AND A1.mandant_id = B.mandant_id
        GROUP BY
            B.mandant_id,
            B.bonuskauf_id
    ) AS t24 ON OP.bonuskauf_id = t24.bonuskauf_id AND OP.mandant_id = t24.mandant_id
    GROUP BY
        OP.bon_id,
        OP.wup_id,
        OP.mandant_id,
        OP.bon_dat,
        OP.kl_art_id,
        OP.bon_zeile,
        OP.bonuskauf_id,
        OP.customer_promotion_fg,
        OP.promotion_art,
        konditionsart_id,
        important,
        t24.aktion_typ_id,
        bonuskauf_id_lb,
        bonrabatt_bewart,
        bonrabatt_bby,
        smp_unique
) AS p
    ON
        K.bon_id = p.bon_id AND K.wup_id = p.wup_id AND K.mandant_id = p.mandant_id AND K.bon_dat = p.bon_dat
        AND Z.kl_art_id = p.kl_art_id AND Z.bon_zeile = p.bon_zeile
WHERE
    K.mandant_id > 1
    AND K.kunde_fg = 1
    AND K.turnover_fg = 1
    AND K.bon_dat BETWEEN (
        SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
        FROM dbp_etl.kmo_artbew_bon_delta_1) AND (
        SELECT MAX(dat_booking)
        FROM dbp_etl.kmo_artbew_bon_delta_1
    )
    AND Z.bon_dat BETWEEN (
        SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
        FROM dbp_etl.kmo_artbew_bon_delta_1) AND (
        SELECT MAX(dat_booking)
        FROM dbp_etl.kmo_artbew_bon_delta_1
    )
    AND T.bon_dat BETWEEN (
        SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
        FROM dbp_etl.kmo_artbew_bon_delta_1) AND (
        SELECT MAX(dat_booking)
        FROM dbp_etl.kmo_artbew_bon_delta_1
    )
    AND CASE
        WHEN K.kasse_typ_id <> 3
            THEN 1
        ELSE 0
    END = 1
    AND (
        K.bon_id, K.wup_id) NOT IN (
        SELECT (bon_id, wup_id)
        FROM dbp_ods.ods_bon_storno_1
    )
    AND Z.wg_id NOT IN (822);


INSERT INTO dbp_etl.kmo_artbew_bon_1 (
    mandant_id, bon_id, dat_booking, wup_id, bon_zeile, kl_art_id,
    ean_kasse, menge, umsatz_brutto, wg_id, aktion_id, lkp_wrg, kundenkarte_id, kundenkarte_typ_id, bonuskauf_id,
    bonuskauf_id_lb, aktion_typ_id, konditionsart_id, vk_aktion_brutto, vk_brutto, betrag_promo_brutto_bby,
    betrag_promo_brutto_kdn, betrag_promo_brutto_kdp, betrag_promo_brutto_null, bde_kundenkarte_id, customer_promotion_fg,
    promotion_art, important, standard_aktion_id, loyalty_berechtigt_fg
)
(SELECT
    mandant_id,
    bon_id,
    dat_booking,
     wup_id,
     bon_zeile,
     kl_art_id,
     CAST(ean_kasse AS INT64),
     menge_,
     umsatz_brutto_,
     wg_id,
    aktion_id,
    wrg_id,
    kundenkarte_id,
     kundenkarte_typ_id,
    bonuskauf_id,
    bonuskauf_id_lb,
    aktion_typ_id,
    konditionsart_id,
    vk_aktion_brutto,
    vk_brutto,
     betrag_promo_brutto_bby,
     betrag_promo_brutto_kdn,
     betrag_promo_brutto_kdp,
     betrag_promo_brutto_null,
    bde_kundenkarte_id,
     customer_promotion_fg,
    CASE
        WHEN stichlogik = 1
            THEN 'PERSONAL'
        WHEN stichlogik = 2
            THEN 'CUSTOMER'
        WHEN stichlogik = 3
            THEN 'COMMON'
        WHEN stichlogik = 99
            THEN 'SMP'
        ELSE ''
    END AS promotion_art,
    important,
    standard_aktion_id,
     loyalty_berechtigt_fg
FROM (SELECT
    mandant_id,
    bon_id,
    dat_booking,
    wup_id,
    wrg_id,
    kl_art_id,
    ean_kasse,
    bon_zeile,
    menge_,
    umsatz_brutto_,
    wg_id,
    aktion_id,
    COALESCE(standard_aktion_id, '') AS standard_aktion_id,
    kundenkarte_id,
    kundenkarte_typ_id,
    MAX(CASE
        WHEN stichlogik IN (99, 9)
            THEN NULL
        ELSE bonuskauf_id
    END) AS bonuskauf_id,
    MAX(CASE
        WHEN stichlogik IN (99, 9)
            THEN NULL
        ELSE aktion_typ_id_
    END) AS aktion_typ_id,
    vk_aktion_brutto,
    vk_brutto,
    SUM(betrag_promo_brutto_bby) AS betrag_promo_brutto_bby,
    SUM(betrag_promo_brutto_kdn) AS betrag_promo_brutto_kdn,
    SUM(betrag_promo_brutto_kdp) AS betrag_promo_brutto_kdp,
    SUM(betrag_promo_brutto_null) AS betrag_promo_brutto_null,
    konditionsart_id,
    MAX(CASE
        WHEN stichlogik IN (99, 9)
            THEN NULL
        ELSE bonuskauf_id_lb
    END) AS bonuskauf_id_lb,
    bde_kundenkarte_id,
    MAX(CASE
        WHEN stichlogik IN (99, 9)
            THEN NULL
        ELSE customer_promotion_fg
    END) AS customer_promotion_fg,
    MIN(stichlogik) AS stichlogik,
    bonus_flag,
    MAX(CASE
        WHEN stichlogik IN (99)
            THEN NULL
        ELSE important
    END) AS important,
    loyalty_berechtigt_fg,
    ROW_NUMBER() OVER (
        PARTITION BY mandant_id, bon_id, dat_booking, wup_id, bon_zeile, kl_art_id, ean_kasse ORDER BY
            MIN(stichlogik) IS NULL, MIN(stichlogik), MAX(CASE
                WHEN stichlogik IN (99, 9)
                    THEN NULL
                ELSE aktion_typ_id_
            END) IS NULL DESC, MAX(CASE
                WHEN stichlogik IN (99, 9)
                    THEN NULL
                ELSE aktion_typ_id_
            END) DESC, konditionsart_id IS NULL DESC, konditionsart_id DESC, MAX(CASE
                WHEN stichlogik IN (99, 9)
                    THEN NULL
                ELSE bonuskauf_id
            END) IS NULL, MAX(CASE
                WHEN stichlogik IN (99, 9)
                    THEN NULL
                ELSE bonuskauf_id
            END), MAX(CASE
                WHEN stichlogik IN (99, 9)
                    THEN NULL
                ELSE bonuskauf_id_lb
            END) IS NULL, MAX(CASE
                WHEN stichlogik IN (99, 9)
                    THEN NULL
                ELSE bonuskauf_id_lb
            END), menge_ IS NULL, menge_
    ) AS rk
FROM dbp_etl.`_zwischen1_1` AS x
GROUP BY
    mandant_id,
    bon_id,
    dat_booking,
    wup_id,
    kl_art_id,
    ean_kasse,
    bon_zeile,
    menge_,
    umsatz_brutto_,
    wg_id,
    aktion_id,
    kundenkarte_id,
    kundenkarte_typ_id,
    vk_aktion_brutto,
    vk_brutto,
    konditionsart_id,
    bde_kundenkarte_id,
    bonus_flag,
    wrg_id,
    x.standard_aktion_id,
    loyalty_berechtigt_fg
QUALIFY rk = 1) AS t2);


CREATE OR REPLACE TEMPORARY TABLE _track_zbon_zbov_unique_personal AS
SELECT
    t8.mandant_id,
    t8.bon_id,
    t8.bon_zeile,
    t8.bon_dat,
    t8.wup_id,
    t8.promotion_art,
    1 AS flag,
    t8.anz,
    t8.bonrabatt
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
    FROM dbp_etl.bd_for_promotion_1 AS A
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
        FROM dbp_etl.bd_for_promotion_1
        WHERE konditionsart_id NOT IN ('ZRT3', 'ZTAG', 'ZGEB')
        GROUP BY
            mandant_id,
            bon_id,
            bon_zeile,
            bon_dat,
            wup_id
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.bon_id = b.bon_id AND A.bon_zeile = b.bon_zeile AND A.bon_dat = b.bon_dat AND A.wup_id = b.wup_id
    WHERE (A.mandant_id, A.bon_id, A.bon_zeile, A.bon_dat, A.wup_id) IN (SELECT (
        mandant_id, bon_id, bon_zeile, bon_dat,
        wup_id
    )
    FROM dbp_etl.bd_for_promotion_1
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
) AS t8;


CREATE OR REPLACE TEMPORARY TABLE _track_zbon_zbov_personal AS
SELECT
    mandant_id,
    bon_id,
    bon_zeile,
    bon_dat,
    wup_id,
    1 AS flag
FROM dbp_etl.bd_for_promotion_1
WHERE (
    mandant_id, bon_id, bon_zeile, bon_dat, wup_id) IN (
    SELECT (mandant_id, bon_id, bon_zeile, bon_dat, wup_id)
    FROM dbp_etl.bd_for_promotion_1
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


CREATE OR REPLACE TABLE dbp_etl.`_zwischen2` AS
SELECT
    K.mandant_id,
    K.bon_id,
    K.dat_booking,
    K.wup_id,
    K.wrg_id,
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
    K.kundenkarte_id,
    K.kundenkarte_typ_id,
    p.bonuskauf_id,
    CASE
        WHEN TRIM(p.bonrabatt_bewart) IN ('Y') AND TRIM(Z.aktion_id) = ''
            THEN 'KDB'
        WHEN TRIM(p.aktion_typ_id) IN ('KDP')
            THEN 'KDP'
        WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
            THEN 'KDN'
        ELSE 'KDA'
    END AS aktion_typ_id_,
    A.vk_aktion_brutto,
    VK.vk_brutto,
    CASE
        WHEN
            p.customer_promotion_fg = 0 AND (TRIM(p.bonrabatt_bewart) IN ('Y') AND CASE
                WHEN TRIM(p.bonrabatt_bewart) IN ('Y') AND TRIM(Z.aktion_id) = ''
                    THEN 'KDB'
                WHEN TRIM(p.aktion_typ_id) IN ('KDP')
                    THEN 'KDP'
                WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
                    THEN 'KDN'
                ELSE 'KDA'
            END = 'KDB' OR TRIM(p.bonrabatt_bby) IN ('Y')) OR p.customer_promotion_fg = 1 AND p.promotion_art IN ('CUSTOMER'
            ) AND TRIM(p.aktion_typ_id) IN ('KPB', 'KDN', 'KDP', 'KDB') AND TRIM(p.bonrabatt_bby) IN ('Y') AND BDE.kundenkarte_id
            IS NULL OR TRIM(p.aktion_typ_id) IN ('KPB', 'KDN', 'KDP', 'KDB') AND TRIM(p.promotion_art) IN ('COMMON', 'PERSONAL'
            ) AND TRIM(p.bonrabatt_bby) IN ('Y')
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_bby,
    CASE
        WHEN
            p.customer_promotion_fg = 1 AND p.promotion_art = 'CUSTOMER' AND TRIM(p.aktion_typ_id) IN ('KDN') AND TRIM(p.bonrabatt_bby
            ) IN ('Y') AND BDE.kundenkarte_id IS NULL AND p.important = 'N'
            THEN NULL
        WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN') AND p.important = 'Y'
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_kdn,
    CASE
        WHEN TRIM(p.aktion_typ_id) = 'KDP' AND p.bonrabatt_bby = 'N'
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_kdp,
    CASE
        WHEN (p.aktion_typ_id IS NULL OR TRIM(p.aktion_typ_id) = '') AND CASE
            WHEN TRIM(p.bonrabatt_bewart) IN ('Y') AND TRIM(Z.aktion_id) = ''
                THEN 'KDB'
            WHEN TRIM(p.aktion_typ_id) IN ('KDP')
                THEN 'KDP'
            WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
                THEN 'KDN'
            ELSE 'KDA'
        END <> 'KDB' AND TRIM(p.bonrabatt_bby) IN ('N')
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_null,
    p.konditionsart_id,
    p.bonuskauf_id_lb,
    BDE.kundenkarte_id AS bde_kundenkarte_id,
    p.customer_promotion_fg,
    CASE
        WHEN p.personal = 'Y' AND Z.wg_id = 822
            THEN 100
        WHEN p.promotion_art = 'PERSONAL_SMP'
            THEN 99
        WHEN p.important = 'N' AND p.bonrabatt_bewart = 'N'
            THEN 9
        WHEN p.promotion_art = 'PERSONAL'
            THEN 1
        ELSE CASE
            WHEN p.promotion_art = 'CUSTOMER' OR p.promotion_art = 'PAYBACK'
                THEN 2
            ELSE CASE
                WHEN p.promotion_art = 'COMMON'
                    THEN 3
                ELSE 4
            END
        END
    END AS stichlogik,
    CASE
        WHEN p.bonuskauf_id IS NOT NULL AND CAST(p.bonuskauf_id AS FLOAT64) <> 0 AND p.bonuskauf_id_lb IS NULL
            THEN 1
        ELSE 0
    END AS bonus_flag,
    CASE
        WHEN p.smp_unique = 'Y' AND Z.aktion_id = ''
            THEN 'A'
        WHEN p.personal_unique = 'Y' AND Z.aktion_id = ''
            THEN 'B'
        WHEN p.personal = 'Y'
            THEN 'C'
        ELSE p.important
    END AS important,
    A.aktion_id AS standard_aktion_id,
    K.loyalty_berechtigt_fg
FROM dbp_ods.ods_bon_kopf_1 AS K
INNER JOIN (
    SELECT
        mandant_id,
        wup_id,
        dat_booking
    FROM dbp_etl.kmo_artbew_bon_delta_1
    GROUP BY
        mandant_id,
        wup_id,
        dat_booking
) AS d ON K.mandant_id = d.mandant_id AND K.wup_id = d.wup_id AND K.dat_booking = d.dat_booking
INNER JOIN dbp_ods.ods_bon_verkauf_1 AS Z
    ON
        K.mandant_id = Z.mandant_id AND K.bon_id = Z.bon_id AND K.wup_id
        = Z.wup_id
INNER JOIN dbp_ods.ods_bon_transaction_1 AS T
    ON
        K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id AND K.wup_id = T.wup_id
LEFT JOIN dbp_data.aktion_art_wup_zu_1 AS A
    ON
        Z.aktion_id = A.aktion_id AND Z.mandant_id = A.mandant_id
        AND Z.wup_id = A.wup_id AND Z.kl_art_id = A.art_id / 10
LEFT JOIN dbp_data.art_wup_vk_per_1 AS VK_1
    ON
        Z.bon_dat BETWEEN VK.dat_von AND VK.dat_bis AND Z.kl_art_id =
        VK.art_id / 10 AND Z.mandant_id = VK.mandant_id AND Z.wup_id = VK.wup_id
LEFT JOIN dbp_data.bewart_det_ecommerce_1 AS BDE
    ON
        K.kundenkarte_id = BDE.kundenkarte_id AND K.mandant_id
        = BDE.mandant_id
LEFT JOIN (
    SELECT
        OP.bon_id,
        OP.wup_id,
        OP.mandant_id,
        OP.bon_dat,
        OP.kl_art_id,
        OP.bon_zeile,
        OP.bonuskauf_id,
        OP.customer_promotion_fg,
        OP.promotion_art,
        SUM(OP.betrag_promo_brutto) AS betrag_promo_brutto,
        CASE
            WHEN OP.konditionsart_id IN ('ZRT3', 'ZTAG', 'ZGEB')
                THEN 'N'
            ELSE 'Y'
        END AS konditionsart_id,
        CASE
            WHEN OP.konditionsart_id IN ('ZBON', 'ZBOV')
                THEN 'N'
            ELSE 'Y'
        END AS important,
        t2.aktion_typ_id,
        t2.bonuskauf_id AS bonuskauf_id_lb,
        CASE
            WHEN X.flag = 1
                THEN 'Y'
            ELSE 'N'
        END AS bonrabatt_bewart,
        CASE
            WHEN Y.flag = 1 AND t2.aktion_typ_id <> ''
                THEN 'Y'
            ELSE 'N'
        END AS bonrabatt_bby,
        CASE
            WHEN Z0.flag = 1
                THEN 'Y'
            ELSE 'N'
        END AS smp_unique,
        CASE
            WHEN W.flag = 1
                THEN 'Y'
            ELSE 'N'
        END AS personal_unique,
        CASE
            WHEN U.flag = 1
                THEN 'Y'
            ELSE 'N'
        END AS personal
    FROM dbp_etl.bd_for_promotion_1 AS OP
    LEFT JOIN `_track_zbon_zbov_unique` AS X
        ON
            OP.mandant_id = X.mandant_id AND OP.wup_id = X.wup_id AND OP.bon_id = X.bon_id
            AND OP.bon_zeile = X.bon_zeile AND OP.bon_dat = X.bon_dat
    LEFT JOIN `_track_zbon_zbov` AS Y
        ON
            OP.mandant_id = Y.mandant_id AND OP.wup_id = Y.wup_id AND OP.bon_id = Y.bon_id
            AND OP.bon_zeile = Y.bon_zeile AND OP.promotion_lfd_nr = Y.promotion_lfd_nr AND OP.bon_dat = Y.bon_dat
    LEFT JOIN `_track_zbon_zbov_unique_smp` AS Z0
        ON
            OP.mandant_id = Z0.mandant_id AND OP.wup_id = Z0.wup_id AND OP.bon_id
            = Z0.bon_id AND OP.bon_zeile = Z0.bon_zeile AND OP.bon_dat = Z0.bon_dat
    LEFT JOIN `_track_zbon_zbov_unique_personal` AS W
        ON
            OP.mandant_id = W.mandant_id AND OP.wup_id = W.wup_id AND OP.bon_id
            = W.bon_id AND OP.bon_zeile = W.bon_zeile AND OP.bon_dat = W.bon_dat
    LEFT JOIN `_track_zbon_zbov_personal` AS U
        ON
            OP.mandant_id = U.mandant_id AND OP.wup_id = U.wup_id AND OP.bon_id = U.bon_id AND OP.bon_zeile = U.bon_zeile AND OP.bon_dat = U.bon_dat
    LEFT JOIN (
        SELECT
            B.mandant_id,
            B.bonuskauf_id,
            MAX(A0.aktion_typ_id) AS aktion_typ_id
        FROM dbp_data.aktion_1 AS A0
        LEFT JOIN dbp_data.l_bonuskauf_1 AS B ON A0.aktion_id = B.aktion_id AND A0.mandant_id = B.mandant_id
        GROUP BY
            B.mandant_id,
            B.bonuskauf_id
    ) AS t2 ON OP.bonuskauf_id = t2.bonuskauf_id AND OP.mandant_id = t2.mandant_id
    GROUP BY
        OP.bon_id,
        OP.wup_id,
        OP.mandant_id,
        OP.bon_dat,
        OP.kl_art_id,
        OP.bon_zeile,
        OP.bonuskauf_id,
        OP.customer_promotion_fg,
        OP.promotion_art,
        konditionsart_id,
        important,
        t2.aktion_typ_id,
        bonuskauf_id_lb,
        bonrabatt_bewart,
        bonrabatt_bby,
        smp_unique,
        personal_unique,
        personal
) AS p
    ON
        K.bon_id = p.bon_id AND K.wup_id = p.wup_id AND K.mandant_id = p.mandant_id AND K.bon_dat = p.bon_dat
        AND Z.kl_art_id = p.kl_art_id AND Z.bon_zeile = p.bon_zeile
WHERE
    K.mandant_id > 1
    AND K.kunde_fg = 1
    AND K.turnover_fg = 1
    AND K.bon_dat BETWEEN (
        SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
        FROM dbp_etl.kmo_artbew_bon_delta_1) AND (
        SELECT MAX(dat_booking)
        FROM dbp_etl.kmo_artbew_bon_delta_1
    )
    AND Z.bon_dat BETWEEN (
        SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
        FROM dbp_etl.kmo_artbew_bon_delta_1) AND (
        SELECT MAX(dat_booking)
        FROM dbp_etl.kmo_artbew_bon_delta_1
    )
    AND T.bon_dat BETWEEN (
        SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
        FROM dbp_etl.kmo_artbew_bon_delta_1) AND (
        SELECT MAX(dat_booking)
        FROM dbp_etl.kmo_artbew_bon_delta_1
    )
    AND CASE
        WHEN K.kasse_typ_id <> 3
            THEN 1
        ELSE 0
    END = 1
    AND Z.wg_id IN (822)
    AND (
        K.bon_id, K.wup_id) NOT IN (
        SELECT (bon_id, wup_id)
        FROM dbp_ods.ods_bon_storno_1
    )
UNION DISTINCT
SELECT
    K.mandant_id,
    K.bon_id,
    K.dat_booking,
    K.wup_id,
    K.wrg_id,
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
    K.kundenkarte_id,
    K.kundenkarte_typ_id,
    p.bonuskauf_id,
    CASE
        WHEN TRIM(p.bonrabatt_bewart) IN ('Y') AND TRIM(Z.aktion_id) = ''
            THEN 'KDB'
        WHEN TRIM(p.aktion_typ_id) IN ('KDP')
            THEN 'KDP'
        WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
            THEN 'KDN'
        ELSE 'KDA'
    END AS aktion_typ_id_,
    A.vk_aktion_brutto,
    VK.vk_brutto,
    CASE
        WHEN
            p.customer_promotion_fg = 0 AND (TRIM(p.bonrabatt_bewart) IN ('Y') AND CASE
                WHEN TRIM(p.bonrabatt_bewart) IN ('Y') AND TRIM(Z.aktion_id) = ''
                    THEN 'KDB'
                WHEN TRIM(p.aktion_typ_id) IN ('KDP')
                    THEN 'KDP'
                WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
                    THEN 'KDN'
                ELSE 'KDA'
            END = 'KDB' OR TRIM(p.bonrabatt_bby) IN ('Y')) OR p.customer_promotion_fg = 1 AND p.promotion_art IN ('CUSTOMER'
            ) AND TRIM(p.aktion_typ_id) IN ('KPB', 'KDN', 'KDP', 'KDB') AND TRIM(p.bonrabatt_bby) IN ('Y') AND BDE.kundenkarte_id
            IS NULL OR TRIM(p.aktion_typ_id) IN ('KPB', 'KDN', 'KDP', 'KDB') AND TRIM(p.promotion_art) IN ('COMMON', 'PERSONAL'
            ) AND TRIM(p.bonrabatt_bby) IN ('Y')
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_bby,
    CASE
        WHEN
            p.customer_promotion_fg = 1 AND p.promotion_art = 'CUSTOMER' AND TRIM(p.aktion_typ_id) IN ('KDN') AND TRIM(p.bonrabatt_bby
            ) IN ('Y') AND BDE.kundenkarte_id IS NULL
            THEN NULL
        WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN') AND p.important = 'Y'
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_kdn,
    CASE
        WHEN TRIM(p.aktion_typ_id) = 'KDP' AND p.bonrabatt_bby = 'N'
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_kdp,
    CASE
        WHEN
            p.aktion_typ_id IS NULL AND CASE
                WHEN TRIM(p.bonrabatt_bewart) IN ('Y') AND TRIM(Z.aktion_id) = ''
                    THEN 'KDB'
                WHEN TRIM(p.aktion_typ_id) IN ('KDP')
                    THEN 'KDP'
                WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
                    THEN 'KDN'
                ELSE 'KDA'
            END <> 'KDB' AND TRIM(p.bonrabatt_bby) IN ('N')
            THEN p.betrag_promo_brutto
        ELSE NULL
    END AS betrag_promo_brutto_null,
    p.konditionsart_id,
    p.bonuskauf_id_lb,
    BDE.kundenkarte_id AS bde_kundenkarte_id,
    p.customer_promotion_fg,
    CASE
        WHEN p.personal = 'Y' AND Z.wg_id = 822
            THEN 100
        WHEN p.promotion_art = 'PERSONAL_SMP'
            THEN 99
        WHEN p.important = 'N' AND p.bonrabatt_bewart = 'N'
            THEN 9
        WHEN p.promotion_art = 'PERSONAL'
            THEN 1
        ELSE CASE
            WHEN p.promotion_art = 'CUSTOMER' OR p.promotion_art = 'PAYBACK'
                THEN 2
            ELSE CASE
                WHEN p.promotion_art = 'COMMON'
                    THEN 3
                ELSE 4
            END
        END
    END AS stichlogik,
    CASE
        WHEN p.bonuskauf_id IS NOT NULL AND CAST(p.bonuskauf_id AS FLOAT64) <> 0 AND p.bonuskauf_id_lb IS NULL
            THEN 1
        ELSE 0
    END AS bonus_flag,
    CASE
        WHEN p.smp_unique = 'Y' AND Z.aktion_id = ''
            THEN 'A'
        WHEN p.personal_unique = 'Y' AND Z.aktion_id = ''
            THEN 'B'
        WHEN p.personal = 'Y'
            THEN 'C'
        ELSE p.important
    END AS important,
    A.aktion_id AS standard_aktion_id,
    K.loyalty_berechtigt_fg
FROM dbp_ods.ods_bon_kopf_1 AS K
INNER JOIN (
    SELECT
        mandant_id,
        wup_id,
        dat_booking
    FROM dbp_etl.kmo_artbew_bon_delta_1
    GROUP BY
        mandant_id,
        wup_id,
        dat_booking
) AS d ON K.mandant_id = d.mandant_id AND K.wup_id = d.wup_id AND K.dat_booking = d.dat_booking
INNER JOIN dbp_ods.ods_bon_retoure_1 AS Z
    ON
        K.mandant_id = Z.mandant_id AND K.bon_id = Z.bon_id AND K.wup_id
        = Z.wup_id
INNER JOIN dbp_ods.ods_bon_transaction_1 AS T
    ON
        K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id AND K.wup_id = T.wup_id
LEFT JOIN dbp_data.aktion_art_wup_zu_1 AS A
    ON
        Z.aktion_id = A.aktion_id AND Z.mandant_id = A.mandant_id
        AND Z.wup_id = A.wup_id AND Z.kl_art_id = A.art_id / 10
LEFT JOIN dbp_data.art_wup_vk_per_1 AS VK_1
    ON
        Z.bon_dat BETWEEN VK.dat_von AND VK.dat_bis AND Z.kl_art_id =
        VK.art_id / 10 AND Z.mandant_id = VK.mandant_id AND Z.wup_id = VK.wup_id
LEFT JOIN dbp_data.bewart_det_ecommerce_1 AS BDE
    ON
        K.kundenkarte_id = BDE.kundenkarte_id AND K.mandant_id
        = BDE.mandant_id
LEFT JOIN (
    SELECT
        OP.bon_id,
        OP.wup_id,
        OP.mandant_id,
        OP.bon_dat,
        OP.kl_art_id,
        OP.bon_zeile,
        OP.bonuskauf_id,
        OP.customer_promotion_fg,
        OP.promotion_art,
        SUM(OP.betrag_promo_brutto) AS betrag_promo_brutto,
        CASE
            WHEN OP.konditionsart_id IN ('ZRT3', 'ZTAG', 'ZGEB')
                THEN 'N'
            ELSE 'Y'
        END AS konditionsart_id,
        CASE
            WHEN OP.konditionsart_id IN ('ZBON', 'ZBOV')
                THEN 'N'
            ELSE 'Y'
        END AS important,
        t24.aktion_typ_id,
        t24.bonuskauf_id AS bonuskauf_id_lb,
        CASE
            WHEN X.flag = 1
                THEN 'Y'
            ELSE 'N'
        END AS bonrabatt_bewart,
        CASE
            WHEN Y.flag = 1
                THEN 'Y'
            ELSE 'N'
        END AS bonrabatt_bby,
        CASE
            WHEN Z1.flag = 1
                THEN 'Y'
            ELSE 'N'
        END AS smp_unique,
        CASE
            WHEN W.flag = 1
                THEN 'Y'
            ELSE 'N'
        END AS personal_unique,
        CASE
            WHEN U.flag = 1
                THEN 'Y'
            ELSE 'N'
        END AS personal
    FROM dbp_etl.bd_for_promotion_1 AS OP
    LEFT JOIN `_track_zbon_zbov_unique` AS X
        ON
            OP.mandant_id = X.mandant_id AND OP.wup_id = X.wup_id AND OP.bon_id = X.bon_id
            AND OP.bon_zeile = X.bon_zeile AND OP.bon_dat = X.bon_dat
    LEFT JOIN `_track_zbon_zbov` AS Y
        ON
            OP.mandant_id = Y.mandant_id AND OP.wup_id = Y.wup_id AND OP.bon_id = Y.bon_id
            AND OP.bon_zeile = Y.bon_zeile AND OP.promotion_lfd_nr = Y.promotion_lfd_nr AND OP.bon_dat = Y.bon_dat
    LEFT JOIN `_track_zbon_zbov_unique_smp` AS Z1
        ON
            OP.mandant_id = Z1.mandant_id AND OP.wup_id = Z1.wup_id AND OP.bon_id
            = Z1.bon_id AND OP.bon_zeile = Z1.bon_zeile AND OP.bon_dat = Z1.bon_dat
    LEFT JOIN `_track_zbon_zbov_unique_personal` AS W
        ON
            OP.mandant_id = W.mandant_id AND OP.wup_id = W.wup_id AND OP.bon_id
            = W.bon_id AND OP.bon_zeile = W.bon_zeile AND OP.bon_dat = W.bon_dat
    LEFT JOIN `_track_zbon_zbov_personal` AS U
        ON
            OP.mandant_id = U.mandant_id AND OP.wup_id = U.wup_id AND OP.bon_id = U.bon_id AND OP.bon_zeile = U.bon_zeile AND OP.bon_dat = U.bon_dat
    LEFT JOIN (
        SELECT
            B.mandant_id,
            B.bonuskauf_id,
            MAX(A1.aktion_typ_id) AS aktion_typ_id
        FROM dbp_data.aktion_1 AS A1
        LEFT JOIN dbp_data.l_bonuskauf_1 AS B ON A1.aktion_id = B.aktion_id AND A1.mandant_id = B.mandant_id
        GROUP BY
            B.mandant_id,
            B.bonuskauf_id
    ) AS t24 ON OP.bonuskauf_id = t24.bonuskauf_id AND OP.mandant_id = t24.mandant_id
    GROUP BY
        OP.bon_id,
        OP.wup_id,
        OP.mandant_id,
        OP.bon_dat,
        OP.kl_art_id,
        OP.bon_zeile,
        OP.bonuskauf_id,
        OP.customer_promotion_fg,
        OP.promotion_art,
        konditionsart_id,
        important,
        t24.aktion_typ_id,
        bonuskauf_id_lb,
        bonrabatt_bewart,
        bonrabatt_bby,
        smp_unique,
        personal_unique,
        personal
) AS p
    ON
        K.bon_id = p.bon_id AND K.wup_id = p.wup_id AND K.mandant_id = p.mandant_id AND K.bon_dat = p.bon_dat
        AND Z.kl_art_id = p.kl_art_id AND Z.bon_zeile = p.bon_zeile
WHERE
    K.mandant_id > 1
    AND K.kunde_fg = 1
    AND K.turnover_fg = 1
    AND K.bon_dat BETWEEN (
        SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
        FROM dbp_etl.kmo_artbew_bon_delta_1) AND (
        SELECT MAX(dat_booking)
        FROM dbp_etl.kmo_artbew_bon_delta_1
    )
    AND Z.bon_dat BETWEEN (
        SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
        FROM dbp_etl.kmo_artbew_bon_delta_1) AND (
        SELECT MAX(dat_booking)
        FROM dbp_etl.kmo_artbew_bon_delta_1
    )
    AND T.bon_dat BETWEEN (
        SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
        FROM dbp_etl.kmo_artbew_bon_delta_1) AND (
        SELECT MAX(dat_booking)
        FROM dbp_etl.kmo_artbew_bon_delta_1
    )
    AND CASE
        WHEN K.kasse_typ_id <> 3
            THEN 1
        ELSE 0
    END = 1
    AND Z.wg_id IN (822)
    AND (
        K.bon_id, K.wup_id) NOT IN (
        SELECT (bon_id, wup_id)
        FROM dbp_ods.ods_bon_storno_1
    );


INSERT INTO dbp_etl.kmo_artbew_bon_1 (
    mandant_id, bon_id, dat_booking, wup_id, bon_zeile, kl_art_id,
    ean_kasse, menge, umsatz_brutto, wg_id, aktion_id, lkp_wrg, kundenkarte_id, kundenkarte_typ_id, bonuskauf_id,
    bonuskauf_id_lb, aktion_typ_id, konditionsart_id, vk_aktion_brutto, vk_brutto, betrag_promo_brutto_bby,
    betrag_promo_brutto_kdn, betrag_promo_brutto_kdp, betrag_promo_brutto_null, bde_kundenkarte_id, customer_promotion_fg,
    promotion_art, important, standard_aktion_id, loyalty_berechtigt_fg
)
(SELECT
     mandant_id,
    bon_id,
    dat_booking,
     wup_id,
     bon_zeile,
     kl_art_id,
     CAST(ean_kasse AS INT64),
     menge_,
     umsatz_brutto_,
     wg_id,
    aktion_id,
    wrg_id,
    kundenkarte_id,
     kundenkarte_typ_id,
    bonuskauf_id,
    bonuskauf_id_lb,
    aktion_typ_id,
    konditionsart_id,
    vk_aktion_brutto,
    vk_brutto,
     betrag_promo_brutto_bby,
     betrag_promo_brutto_kdn,
     betrag_promo_brutto_kdp,
     betrag_promo_brutto_null,
    bde_kundenkarte_id,
     customer_promotion_fg,
    CASE
        WHEN stichlogik = 1
            THEN 'PERSONAL'
        WHEN stichlogik = 2
            THEN 'CUSTOMER'
        WHEN stichlogik = 3
            THEN 'COMMON'
        WHEN stichlogik = 99
            THEN 'SMP'
        ELSE ''
    END AS promotion_art,
    important,
    standard_aktion_id,
    loyalty_berechtigt_fg
FROM (SELECT
    mandant_id,
    bon_id,
    dat_booking,
    wup_id,
    wrg_id,
    kl_art_id,
    ean_kasse,
    bon_zeile,
    menge_,
    umsatz_brutto_,
    wg_id,
    aktion_id,
    COALESCE(standard_aktion_id, '') AS standard_aktion_id,
    kundenkarte_id,
    kundenkarte_typ_id,
    loyalty_berechtigt_fg,
    MAX(CASE
        WHEN stichlogik IN (99, 9)
            THEN NULL
        ELSE bonuskauf_id
    END) AS bonuskauf_id,
    MAX(CASE
        WHEN stichlogik IN (99, 9)
            THEN NULL
        ELSE aktion_typ_id_
    END) AS aktion_typ_id,
    vk_aktion_brutto,
    vk_brutto,
    SUM(betrag_promo_brutto_bby) AS betrag_promo_brutto_bby,
    SUM(betrag_promo_brutto_kdn) AS betrag_promo_brutto_kdn,
    SUM(betrag_promo_brutto_kdp) AS betrag_promo_brutto_kdp,
    SUM(betrag_promo_brutto_null) AS betrag_promo_brutto_null,
    konditionsart_id,
    MAX(CASE
        WHEN stichlogik IN (99, 9)
            THEN NULL
        ELSE bonuskauf_id_lb
    END) AS bonuskauf_id_lb,
    bde_kundenkarte_id,
    MAX(CASE
        WHEN stichlogik IN (99, 9)
            THEN NULL
        ELSE customer_promotion_fg
    END) AS customer_promotion_fg,
    MIN(stichlogik) AS stichlogik,
    bonus_flag,
    MAX(CASE
        WHEN stichlogik IN (99)
            THEN NULL
        ELSE important
    END) AS important,
    ROW_NUMBER() OVER (
        PARTITION BY mandant_id, bon_id, dat_booking, wup_id, bon_zeile, kl_art_id, ean_kasse ORDER BY
            MIN(stichlogik) IS NULL, MIN(stichlogik), MAX(CASE
                WHEN stichlogik IN (99, 9)
                    THEN NULL
                ELSE aktion_typ_id_
            END) IS NULL DESC, MAX(CASE
                WHEN stichlogik IN (99, 9)
                    THEN NULL
                ELSE aktion_typ_id_
            END) DESC, konditionsart_id IS NULL DESC, konditionsart_id DESC, MAX(CASE
                WHEN stichlogik IN (99, 9)
                    THEN NULL
                ELSE bonuskauf_id
            END) IS NULL, MAX(CASE
                WHEN stichlogik IN (99, 9)
                    THEN NULL
                ELSE bonuskauf_id
            END), MAX(CASE
                WHEN stichlogik IN (99, 9)
                    THEN NULL
                ELSE bonuskauf_id_lb
            END) IS NULL, MAX(CASE
                WHEN stichlogik IN (99, 9)
                    THEN NULL
                ELSE bonuskauf_id_lb
            END), menge_ IS NULL, menge_
    ) AS rk
FROM dbp_etl.`_zwischen2` AS x
GROUP BY
    mandant_id,
    bon_id,
    dat_booking,
    wup_id,
    kl_art_id,
    ean_kasse,
    bon_zeile,
    menge_,
    umsatz_brutto_,
    wg_id,
    aktion_id,
    kundenkarte_id,
    kundenkarte_typ_id,
    vk_aktion_brutto,
    vk_brutto,
    konditionsart_id,
    bde_kundenkarte_id,
    bonus_flag,
    wrg_id,
    x.standard_aktion_id,
    loyalty_berechtigt_fg
QUALIFY rk = 1) AS t2);


INSERT INTO dbp_etl_process.artbew_bon_empties_1 (mandant_id, wup_id, td_insert, td_update)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        CURRENT_TIMESTAMP() AS td_insert,
        CURRENT_TIMESTAMP() AS td_update
    FROM dbp_ods.ods_bon_leergut_1 AS A
    INNER JOIN dbp_ods.ods_bon_zahlung_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.barcode_leergut = B.barcode_leergut
            AND A.wup_id = B.wup_id AND A.bon_dat = B.bon_dat
    INNER JOIN dbp_ods.ods_bon_transaction_1 AS C
        ON
            A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id AND
            A.bon_dat = C.bon_dat AND C.transaction_name = 'RetailTransaction' AND TRIM(A.barcode_leergut) <> ''
    WHERE
        B.kpos_zahlung_typ_id = 'BBN'
        AND A.bon_dat BETWEEN (
            SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
            FROM dbp_etl.kmo_artbew_bon_delta_1) AND (
            SELECT MAX(dat_booking)
            FROM dbp_etl.kmo_artbew_bon_delta_1
        )
        AND (
            A.mandant_id, A.wup_id) NOT IN (
            SELECT (mandant_id, wup_id)
            FROM dbp_etl_process.artbew_bon_empties_1
        )
    GROUP BY
        A.mandant_id,
        A.wup_id
);


CREATE OR REPLACE TEMPORARY TABLE _track_empties AS
SELECT
    A.bon_id,
    A.bon_zeile,
    A.ean_kasse,
    A.umsatz_brutto,
    A.mandant_id,
    A.wup_id,
    A.start_bon_zeile,
    A.bon_nr_extern,
    A.bon_dat,
    A.td_insert,
    A.td_update,
    A.kpos_erfassung_id,
    A.menge,
    A.kl_art_id,
    A.einh_id,
    A.mwst_id,
    A.barcode_leergut
FROM dbp_ods.ods_bon_leergut_1 AS A
INNER JOIN (
    SELECT
        mandant_id,
        wup_id,
        dat_booking
    FROM dbp_etl.kmo_artbew_bon_delta_1
    GROUP BY
        mandant_id,
        wup_id,
        dat_booking
) AS d ON A.mandant_id = d.mandant_id AND A.wup_id = d.wup_id AND A.bon_dat = d.dat_booking
WHERE A.bon_dat BETWEEN (
    SELECT DATE_SUB(MIN(dat_booking), INTERVAL 14 DAY)
    FROM dbp_etl.kmo_artbew_bon_delta_1) AND (
    SELECT MAX(dat_booking)
    FROM dbp_etl.kmo_artbew_bon_delta_1
)
AND (
    A.mandant_id, A.wup_id) IN (
    SELECT (mandant_id, wup_id)
    FROM dbp_etl_process.artbew_bon_empties_1
)
AND A.barcode_leergut IS NOT NULL;


CREATE OR REPLACE TEMPORARY TABLE _leergut AS
SELECT
    A.mandant_id,
    A.bon_id,
    A.bon_dat AS dat_booking,
    A.wup_id,
    A.kl_art_id,
    A.ean_kasse,
    9999 AS bon_zeile,
    SUM(CASE
        WHEN B.kunde_fg = 0
            THEN A.menge
        ELSE A.menge * -1
    END) AS menge,
    SUM(CASE
        WHEN B.kunde_fg = 0
            THEN A.umsatz_brutto * -1
        ELSE A.umsatz_brutto
    END) AS umsatz_brutto,
    B.wrg_id,
    999 AS wg_id,
    '' AS aktion_id,
    B.kundenkarte_id,
    B.kundenkarte_typ_id,
    NULL AS bonuskauf_id,
    NULL AS aktion_typ_id,
    NULL AS konditionsart_id,
    0 AS vk_aktion_brutto,
    0 AS vk_brutto,
    0 AS betrag_promo_brutto_kdn,
    0 AS betrag_promo_brutto_kdp,
    0 AS betrag_promo_brutto_null,
    NULL AS bonuskauf_id_lb,
    NULL AS bde_kundenkarte_id,
    0 AS customer_promotion_fg,
    '' AS promotion_art,
    NULL AS important,
    B.loyalty_berechtigt_fg
FROM `_track_empties` AS A
INNER JOIN dbp_ods.ods_bon_kopf_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.bon_id
        = B.bon_id AND A.bon_dat = B.bon_dat
INNER JOIN dbp_data.mandant_1 AS C ON A.mandant_id = C.mandant_id
GROUP BY
    A.mandant_id,
    A.bon_id,
    dat_booking,
    A.wup_id,
    A.kl_art_id,
    A.ean_kasse,
    bon_zeile,
    B.wrg_id,
    wg_id,
    aktion_id,
    B.kundenkarte_id,
    B.kundenkarte_typ_id,
    bonuskauf_id,
    aktion_typ_id,
    konditionsart_id,
    vk_aktion_brutto,
    vk_brutto,
    betrag_promo_brutto_kdn,
    betrag_promo_brutto_kdp,
    betrag_promo_brutto_null,
    bonuskauf_id_lb,
    bde_kundenkarte_id,
    customer_promotion_fg,
    promotion_art,
    important,
    B.loyalty_berechtigt_fg;


INSERT INTO dbp_etl.kmo_artbew_bon_1 (
    mandant_id, bon_id, dat_booking, wup_id, bon_zeile, kl_art_id,
    ean_kasse, menge, umsatz_brutto, wg_id, aktion_id, lkp_wrg, kundenkarte_id, kundenkarte_typ_id, bonuskauf_id,
    bonuskauf_id_lb, aktion_typ_id, konditionsart_id, vk_aktion_brutto, vk_brutto, betrag_promo_brutto_kdn,
    betrag_promo_brutto_kdp, betrag_promo_brutto_null, bde_kundenkarte_id, customer_promotion_fg, promotion_art, important,
    standard_aktion_id, loyalty_berechtigt_fg
)
(SELECT
     mandant_id,
    bon_id,
    dat_booking,
     wup_id,
    bon_zeile,
     kl_art_id,
    CAST(COALESCE(ean_kasse, 0) AS INTEGER) AS ean_kasse,
     menge,
    umsatz_brutto,
    wg_id,
    aktion_id,
    wrg_id,
    kundenkarte_id,
    kundenkarte_typ_id,
    SUBSTR(CAST(bonuskauf_id AS STRING), 1, 20) AS bonuskauf_id,
    SUBSTR(CAST(bonuskauf_id_lb AS STRING), 1, 20) AS bonuskauf_id_lb,
    SUBSTR(CAST(aktion_typ_id AS STRING), 1, 4) AS aktion_typ_id,
    SUBSTR(CAST(konditionsart_id AS STRING), 1, 4) AS konditionsart_id,
    vk_aktion_brutto,
    vk_brutto,
    betrag_promo_brutto_kdn,
    betrag_promo_brutto_kdp,
    betrag_promo_brutto_null,
    SUBSTR(CAST(bde_kundenkarte_id AS STRING), 1, 255) AS bde_kundenkarte_id,
    customer_promotion_fg,
    promotion_art,
    SUBSTR(CAST(important AS STRING), 1, 1) AS important,
    '' AS standard_aktion_id,
    CAST(loyalty_berechtigt_fg AS INTEGER) AS loyalty_berechtigt_fg
FROM `_leergut`);


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    lkp_nb_id = W.nb_id
FROM dbp_data.wup_1 AS W
WHERE kmo_artbew_bon.mandant_id = W.mandant_id AND kmo_artbew_bon.wup_id = W.wup_id;


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    lkp_art_id = t0.art_id,
    lkp_zek_id = t0.zek_id,
    lkp_mwst_id = t0.mwst_id,
    lkp_posten_id = t0.posten_id FROM (SELECT
    mandant_id,
    kl_art_id,
    art_id,
    zek_id,
    mwst_id,
    posten_id
FROM dbp_data.art_1 AS A
QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, kl_art_id ORDER BY art_id IS NULL DESC, art_id DESC)) = 1) AS t0
WHERE kmo_artbew_bon.mandant_id = t0.mandant_id AND kmo_artbew_bon.kl_art_id = t0.kl_art_id;


CREATE OR REPLACE TEMPORARY TABLE _tage AS
SELECT dat_booking
FROM dbp_etl.kmo_artbew_bon_1
GROUP BY dat_booking;


CREATE OR REPLACE TEMPORARY TABLE _min_tage AS
SELECT MIN(dat_booking) AS min_dat_booking
FROM dbp_etl.kmo_artbew_bon_1;


CREATE OR REPLACE TEMPORARY TABLE _art_per AS
SELECT *
FROM (
    SELECT
        A.art_id,
        A.mandant_id,
        A.dat_von,
        A.dat_bis,
        A.mutter_wb_id,
        A.posten_id,
        A.ipn_id,
        A.td_insert,
        A.td_update,
        A.mwst_id,
        A.oug_id,
        A.iwt_id
    FROM dbp_data.art_per_1 AS A
    INNER JOIN `_min_tage` AS B ON A.dat_bis >= B.min_dat_booking
) AS a
INNER JOIN `_tage` AS B0 ON B0.dat_booking BETWEEN a.dat_von AND a.dat_bis;


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    lkp_mwst_id = CAST(b.mwst_id AS INTEGER),
    lkp_posten_id = b.posten_id
FROM `_art_per` AS b
WHERE
    kmo_artbew_bon.dat_booking = b.dat_booking AND kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.lkp_art_id
    = b.art_id;


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    lkp_wg_id = CAST(W.wg_id AS INTEGER),
    lkp_arthiertyp_id = CAST(W.arthiertyp_id AS INTEGER)
FROM dbp_data.art_wg_zu_per_1 AS W
WHERE kmo_artbew_bon.mandant_id = W.mandant_id AND kmo_artbew_bon.lkp_art_id = W.art_id AND W.dat_bis = PARSE_DATE(
    '%F',
    '9999-12-31'
) AND W.arthiertyp_id = 2;


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    lkp_umrechnungskurs = CAST(K.umrechnungskurs AS FLOAT64)
FROM dbp_data.kurs_1 AS K
WHERE
    kmo_artbew_bon.lkp_wrg = K.von_wrg_id AND K.dat_bis = DATE '9999-12-31' AND K.kurstyp_id = 3 AND K.nach_wrg_id =
    'EUR';


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    lkp_wrg = b.wrg_id,
    lkp_umrechnungskurs = 1 / CAST(
        b.umrechnungskurs AS FLOAT64) FROM (
    SELECT *
    FROM dbp_data.mandant_wrg_zu_per_1
    WHERE
        CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        AND von_wrg_id IS NOT NULL
) AS b
WHERE kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.lkp_wrg = b.von_wrg_id;


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    lkp_mwst = M.mwst
FROM dbp_data.mwst_per_1 AS M
WHERE
    kmo_artbew_bon.mandant_id = M.mandant_id AND kmo_artbew_bon.lkp_mwst_id = M.mwst_id AND kmo_artbew_bon.dat_booking
    BETWEEN M.dat_von AND M.dat_bis;


DELETE FROM dbp_etl.kmo_artbew_bon_1
WHERE
    lkp_art_id IS NULL OR lkp_arthiertyp_id IS NULL OR lkp_mwst IS NULL OR lkp_mwst_id IS NULL OR lkp_nb_id IS NULL OR
    lkp_posten_id IS NULL OR lkp_umrechnungskurs IS NULL OR lkp_wg_id IS NULL OR lkp_wrg IS NULL OR lkp_zek_id IS NULL;


INSERT INTO dbp_etl.kmo_artbew_bon_dat_1 (dat)
(
    SELECT dat_booking
    FROM dbp_etl.kmo_artbew_bon_1
    GROUP BY dat_booking
);


DELETE FROM dbp_etl.kmo_artbew_bon_1
WHERE dat_booking > DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY);


INSERT INTO dbp_etl.kmo_artbew_bon_promotion_1 (
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
        SUM(P.betrag_promo_brutto * -1) AS umsatz_brutto,
        SUM(P.umsatz_promo_brutto) AS umsatz_promo_brutto,
        SUM(P.menge_promo) AS menge_promo
    FROM dbp_etl.kmo_artbew_bon_1 AS K
    INNER JOIN dbp_ods.ods_promotion_1 AS P
        ON
            K.mandant_id = P.mandant_id AND K.bon_id = P.bon_id AND K.bon_zeile
            = P.bon_zeile AND (P.wup_id >= 1000 AND P.wup_id <= 9999) AND P.kl_art_id IS NOT NULL
    GROUP BY
        K.mandant_id,
        K.bon_id,
        K.dat_booking,
        K.kl_art_id,
        K.bon_zeile,
        P.bonuskauf_id,
        P.konditionsart_id
);


ALTER TABLE dbp_etl.kmo_artbew_bon_1
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
    AND mandant_id > 1
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
            mandant_id > 1
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
        A.mandant_id > 1
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
    WHERE mandant_id > 1
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
WHERE mandant_id > 1
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
            mandant_id > 1
            AND konditionsart_id = 'ZMP'
        GROUP BY
            mandant_id,
            wup_id,
            bon_dat,
            bon_id,
            bon_zeile
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.bon_dat = b.bon_dat AND A.bon_id = b.bon_id AND A.bon_zeile = b.bon_zeile
    WHERE A.mandant_id > 1
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
WHERE mandant_id > 1
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
WHERE mandant_id > 1
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
            mandant_id > 1
            AND konditionsart_id = 'ZMP'
        GROUP BY
            mandant_id,
            wup_id,
            bon_dat,
            bon_id,
            bon_zeile
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.bon_dat = b.bon_dat AND A.bon_id = b.bon_id AND A.bon_zeile = b.bon_zeile
    WHERE A.mandant_id > 1
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
    WHERE mandant_id > 1
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
    WHERE mandant_id > 1
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

--pe_review

INSERT INTO `_unique_`
SELECT
    x.mandant_id,
    x.wup_id,
    x.bon_dat,
    x.bon_id,
    x.bon_zeile,
    CASE
        WHEN x.max_aktion_verkauf = '' AND x.akt_fg = 0 THEN 100111
        ELSE 9999
    END AS bewart_det_id_
FROM (
    SELECT
        a.mandant_id,
        a.wup_id,
        a.bon_dat,
        a.bon_id,
        a.bon_zeile,
        MAX(b.akt_fg) AS akt_fg,
        MAX(a.aktion_id) AS max_aktion,
        MAX(a.aktion_id_verkauf) AS max_aktion_verkauf,
        COUNT(DISTINCT CASE WHEN a.promotion_art = '' THEN NULL ELSE a.promotion_art END) AS anz_promo,
        COUNT(DISTINCT a.konditionsart_id) AS anz_kond,
        MAX(a.promotion_art) AS max_promo,
        MIN(CASE WHEN a.promotion_art = '' THEN 'ZZZZ' ELSE a.promotion_art END) AS min_promo,
        MAX(a.konditionsart_id) AS max_kond,
        MIN(a.konditionsart_id) AS min_kond
    FROM `_check_zmp1` AS a
    JOIN (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.bon_dat,
            a.bon_id,
            a.bon_zeile,
            CASE
                WHEN MAX(ABS(a.betrag_promo_brutto)) <> 0.01 THEN 1
                ELSE 0
            END AS akt_fg
        FROM `_check_zmp1` AS a
        WHERE
            a.mandant_id > 1
            AND a.konditionsart_id = 'ZMP'
        GROUP BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.bon_zeile
    ) AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.wup_id = b.wup_id
            AND a.bon_dat = b.bon_dat
            AND a.bon_id = b.bon_id
            AND a.bon_zeile = b.bon_zeile
    WHERE a.mandant_id > 1
    GROUP BY a.mandant_id, a.wup_id, a.bon_dat, a.bon_id, a.bon_zeile
    HAVING
        anz_promo = 1
        AND (
            (min_promo = 'COMMON' AND max_promo = 'COMMON')
            OR
            (min_promo = 'CUSTOMER' AND max_promo = 'COMMON')
        )
        AND anz_kond = 1
) AS x
WHERE
    NOT EXISTS (
        SELECT 1
        FROM `_unique_` AS u
        WHERE
            u.mandant_id = x.mandant_id
            AND u.wup_id = x.wup_id
            AND u.bon_dat = x.bon_dat
            AND u.bon_id = x.bon_id
            AND u.bon_zeile = x.bon_zeile
    )
GROUP BY
    mandant_id,
    wup_id,
    bon_dat,
    bon_id,
    bon_zeile,
    bewart_det_id_
having bewart_det_id_ in (100111);


--pe_review

update dbp_etl.kmo_artbew_bon_1

set bewart_det_id_zmp = b.bewart_det_id
from (select * from _unique_) b

where
    kmo_artbew_bon.mandant_id = b.mandant_id and
    kmo_artbew_bon.wup_id = b.wup_id and
    kmo_artbew_bon.dat_booking = b.bon_dat and
    kmo_artbew_bon.bon_id = b.bon_id and
    kmo_artbew_bon.bon_zeile = b.bon_zeile and
    kmo_artbew_bon.umsatz_brutto / NULLIF(kmo_artbew_bon.menge, 0) <> 0.01;


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
    ROUND(
        CAST(ABS(SUM(B.umsatz_promo_brutto) / IF(SUM(B.betrag_promo_brutto) = 0, NULL, SUM(B.betrag_promo_brutto))) AS BIGNUMERIC),
        0
    ) AS menge
FROM dbp_ods.ods_bon_verkauf_1 AS A
INNER JOIN `_check_zmp1` AS B
    ON
        A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.bon_dat = B.bon_dat AND A.bon_zeile
        = B.bon_zeile AND A.bon_id = B.bon_id
WHERE
    A.mandant_id > 1
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


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    umsatz_brutto = kmo_artbew_bon.umsatz_brutto - b.betrag_promo
FROM `_zmp01` AS b
WHERE
    kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.wup_id = b.wup_id AND kmo_artbew_bon.dat_booking = b.bon_dat
    AND kmo_artbew_bon.bon_id = b.bon_id AND kmo_artbew_bon.bon_zeile = b.bon_zeile;


CREATE OR REPLACE TEMPORARY TABLE _zmp02 AS
SELECT
    t5.mandant_id0 AS mandant_id,
    t5.bon_id0 AS bon_id,
    t5.bon_id_kopf,
    t5.bon_zeile0 AS bon_zeile,
    t5.wup_id0 AS wup_id,
    t5.bon_dat0 AS bon_dat,
    t5.betrag_promo_
FROM (
    SELECT
        b.mandant_id AS mandant_id0,
        b.bon_id AS bon_id0,
        b.bon_id_kopf,
        b.bon_zeile AS bon_zeile0,
        b.wup_id AS wup_id0,
        b.bon_dat AS bon_dat0,
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
        wup_id,
        bon_dat,
        bon_id,
        bon_zeile,
        bon_id_kopf
    HAVING ABS(betrag_promo_) <> 0.01) AS b
        ON
            A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.bon_dat = b.bon_dat
            AND A.bon_zeile = b.bon_zeile AND A.bon_id = b.bon_id
    WHERE A.mandant_id > 1
    GROUP BY
        mandant_id0,
        bon_id0,
        b.bon_id_kopf,
        bon_zeile0,
        wup_id0,
        bon_dat0
) AS t5;


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    umsatz_brutto = 0
WHERE
    (mandant_id , wup_id , dat_booking, bon_id) IN
    (SELECT (
        mandant_id , wup_id ,
        bon_dat, bon_id
    )
    FROM `_zmp01`) AND umsatz_brutto / IF(menge = 0, NULL, menge) = 0.01;


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    umsatz_brutto = CAST(kmo_artbew_bon.umsatz_brutto + b.betrag_promo_ AS NUMERIC)
FROM `_zmp02` AS b
WHERE
    kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.wup_id = b.wup_id AND kmo_artbew_bon.dat_booking = b.bon_dat
    AND kmo_artbew_bon.bon_id = b.bon_id AND kmo_artbew_bon.bon_zeile = b.bon_zeile AND kmo_artbew_bon.umsatz_brutto
    / IF(kmo_artbew_bon.menge = 0, NULL, kmo_artbew_bon.menge) <> 0.01 AND kmo_artbew_bon.umsatz_brutto <> 0;


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
    ROUND(
        CAST(ABS(MAX(B.umsatz_promo_brutto) / IF(SUM(B.betrag_promo_brutto) = 0, NULL, SUM(B.betrag_promo_brutto))) AS BIGNUMERIC),
        0
    ) AS menge
FROM dbp_ods.ods_bon_verkauf_1 AS A
INNER JOIN `_check_zmp1` AS B
    ON
        A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.bon_dat = B.bon_dat AND A.bon_zeile
        = B.bon_zeile AND A.bon_id = B.bon_id
WHERE
    A.mandant_id > 1
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


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    umsatz_brutto = b.umsatz_promo
FROM `_zmp03` AS b
WHERE
    kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.wup_id = b.wup_id AND kmo_artbew_bon.dat_booking = b.bon_dat
    AND kmo_artbew_bon.bon_id = b.bon_id AND kmo_artbew_bon.bon_zeile = b.bon_zeile AND kmo_artbew_bon.umsatz_brutto
    / IF(kmo_artbew_bon.menge = 0, NULL, kmo_artbew_bon.menge) <> 0.01 AND kmo_artbew_bon.umsatz_brutto <> 0;
