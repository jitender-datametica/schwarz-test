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
    betrag_promo_brutto_kdn NUMERIC(29, 4),
    betrag_promo_brutto_kdp NUMERIC(29, 4),
    betrag_promo_brutto_null NUMERIC(29, 4),
    bde_kundenkarte_id STRING(255) COLLATE 'und:ci'
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


CREATE OR REPLACE TABLE dbp_etl.kmo_artbew_bon_dat_1 (
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
    WHERE dat_booking <= DATE '2022-03-31'
);


INSERT INTO dbp_etl.kmo_artbew_bon_1 (
    mandant_id, bon_id, dat_booking, wup_id, bon_zeile, kl_art_id,
    ean_kasse, menge, umsatz_brutto, wg_id, aktion_id, lkp_wrg, kundenkarte_id, kundenkarte_typ_id, bonuskauf_id,
    bonuskauf_id_lb, aktion_typ_id, konditionsart_id, vk_aktion_brutto, vk_brutto, betrag_promo_brutto_kdn,
    betrag_promo_brutto_kdp, betrag_promo_brutto_null, bde_kundenkarte_id
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
    wrg_id,
    kundenkarte_id,
    kundenkarte_typ_id,
    bonuskauf_id,
    bonuskauf_id_lb,
    aktion_typ_id,
    konditionsart_id,
    vk_aktion_brutto,
    vk_brutto,
    CAST(betrag_promo_brutto_kdn AS NUMERIC) AS betrag_promo_brutto_kdn,
    CAST(betrag_promo_brutto_kdp AS NUMERIC) AS betrag_promo_brutto_kdp,
    CAST(betrag_promo_brutto_null AS NUMERIC) AS betrag_promo_brutto_null,
    bde_kundenkarte_id
FROM (
    SELECT
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
        MAX(bonuskauf_id) AS bonuskauf_id,
        MAX(aktion_typ_id) AS aktion_typ_id,
        SUM(betrag_promo_brutto_kdn) AS betrag_promo_brutto_kdn,
        SUM(betrag_promo_brutto_kdp) AS betrag_promo_brutto_kdp,
        SUM(betrag_promo_brutto_null) AS betrag_promo_brutto_null,
        MAX(bonuskauf_id_lb) AS bonuskauf_id_lb
    FROM (
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
                ELSE ROUND(CAST(Z.barcode_string AS BIGNUMERIC), 0)
            END, COALESCE(Z.ean_kasse, 0)) AS ean_kasse,
            Z.bon_zeile,
            CASE
                WHEN K.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                    THEN Z.menge * -1
                ELSE Z.menge
            END AS menge_,
            CASE
                WHEN K.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                    THEN Z.umsatz_brutto * -1
                ELSE Z.umsatz_brutto
            END AS umsatz_brutto_,
            Z.wg_id,
            Z.aktion_id,
            K.kundenkarte_id,
            K.kundenkarte_typ_id,
            p.bonuskauf_id,
            CASE
                WHEN TRIM(p.aktion_typ_id) IN ('KDP')
                    THEN 'KDP'
                WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
                    THEN 'KDN'
                ELSE 'KDA'
            END AS aktion_typ_id,
            A.vk_aktion_brutto,
            VK.vk_brutto,
            CASE
                WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
                    THEN p.betrag_promo_brutto
                ELSE NULL
            END AS betrag_promo_brutto_kdn,
            CASE
                WHEN TRIM(p.aktion_typ_id) = 'KDP'
                    THEN p.betrag_promo_brutto
                ELSE NULL
            END AS betrag_promo_brutto_kdp,
            CASE
                WHEN p.aktion_typ_id IS NULL
                    THEN p.betrag_promo_brutto
                ELSE NULL
            END AS betrag_promo_brutto_null,
            p.konditionsart_id,
            p.bonuskauf_id_lb,
            BDE.kundenkarte_id AS bde_kundenkarte_id,
            CASE
                WHEN p.bonuskauf_id IS NOT NULL AND CAST(p.bonuskauf_id AS FLOAT64) <> 0 AND p.bonuskauf_id_lb IS NULL
                    THEN 1
                ELSE 0
            END AS bonus_flag
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
                K.mandant_id = Z.mandant_id AND K.bon_id = Z.bon_id AND
                K.wup_id = Z.wup_id
        INNER JOIN dbp_ods.ods_bon_transaction_1 AS T
            ON
                K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id
                AND K.wup_id = T.wup_id
        LEFT JOIN dbp_data.aktion_art_wup_zu_1 AS A
            ON
                Z.aktion_id = A.aktion_id AND Z.mandant_id = A.mandant_id
                AND Z.wup_id = A.wup_id AND Z.kl_art_id = A.art_id / 10
        LEFT JOIN dbp_data.art_wup_vk_per_1 AS VK_1
            ON
                Z.bon_dat BETWEEN VK.dat_von AND VK.dat_bis AND Z.kl_art_id
                = VK.art_id / 10 AND Z.mandant_id = VK.mandant_id AND Z.wup_id = VK.wup_id
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
                SUM(OP.betrag_promo_brutto) AS betrag_promo_brutto,
                CASE
                    WHEN OP.konditionsart_id IN ('ZRT3', 'ZTAG', 'ZGEB')
                        THEN 'N'
                    ELSE 'Y'
                END AS konditionsart_id,
                t2.aktion_typ_id,
                t2.bonuskauf_id AS bonuskauf_id_lb
            FROM dbp_ods.ods_promotion_1 AS OP
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
                konditionsart_id,
                t2.aktion_typ_id,
                bonuskauf_id_lb
        ) AS p
            ON
                K.bon_id = p.bon_id AND K.wup_id = p.wup_id AND K.mandant_id = p.mandant_id AND K.bon_dat
                = p.bon_dat AND Z.kl_art_id = p.kl_art_id AND Z.bon_zeile = p.bon_zeile
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
                ELSE ROUND(CAST(Z.barcode_string AS BIGNUMERIC), 0)
            END, COALESCE(Z.ean_kasse, 0)) AS ean_kasse,
            Z.bon_zeile -- mengen flag beruecksichtigen (vorgabe david vom 18.03.)
            ,
            CASE
                WHEN K.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                    THEN Z.menge * -1
                ELSE Z.menge
            END * Z.menge_fg AS menge_,
            CASE
                WHEN K.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                    THEN Z.umsatz_brutto * -1
                ELSE Z.umsatz_brutto
            END AS umsatz_brutto_,
            Z.wg_id,
            Z.aktion_id,
            K.kundenkarte_id,
            K.kundenkarte_typ_id,
            p.bonuskauf_id,
            CASE
                WHEN TRIM(p.aktion_typ_id) IN ('KDP')
                    THEN 'KDP'
                WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
                    THEN 'KDN'
                ELSE 'KDA'
            END AS aktion_typ_id,
            A.vk_aktion_brutto,
            VK.vk_brutto,
            CASE
                WHEN TRIM(p.aktion_typ_id) IN ('KPB', 'KDN')
                    THEN p.betrag_promo_brutto
                ELSE NULL
            END AS betrag_promo_brutto_kdn,
            CASE
                WHEN TRIM(p.aktion_typ_id) = 'KDP'
                    THEN p.betrag_promo_brutto
                ELSE NULL
            END AS betrag_promo_brutto_kdp,
            CASE
                WHEN p.aktion_typ_id IS NULL
                    THEN p.betrag_promo_brutto
                ELSE NULL
            END AS betrag_promo_brutto_null,
            p.konditionsart_id,
            p.bonuskauf_id_lb,
            BDE.kundenkarte_id AS bde_kundenkarte_id,
            CASE
                WHEN p.bonuskauf_id IS NOT NULL AND CAST(p.bonuskauf_id AS FLOAT64) <> 0 AND p.bonuskauf_id_lb IS NULL
                    THEN 1
                ELSE 0
            END AS bonus_flag
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
                K.mandant_id = Z.mandant_id AND K.bon_id = Z.bon_id AND
                K.wup_id = Z.wup_id
        INNER JOIN dbp_ods.ods_bon_transaction_1 AS T
            ON
                K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id
                AND K.wup_id = T.wup_id
        LEFT JOIN dbp_data.aktion_art_wup_zu_1 AS A
            ON
                Z.aktion_id = A.aktion_id AND Z.mandant_id = A.mandant_id
                AND Z.wup_id = A.wup_id AND Z.kl_art_id = A.art_id / 10
        LEFT JOIN dbp_data.art_wup_vk_per_1 AS VK_1
            ON
                Z.bon_dat BETWEEN VK.dat_von AND VK.dat_bis AND Z.kl_art_id
                = VK.art_id / 10 AND Z.mandant_id = VK.mandant_id AND Z.wup_id = VK.wup_id
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
                SUM(OP.betrag_promo_brutto) AS betrag_promo_brutto,
                CASE
                    WHEN OP.konditionsart_id IN ('ZRT3', 'ZTAG', 'ZGEB')
                        THEN 'N'
                    ELSE 'Y'
                END AS konditionsart_id,
                t24.aktion_typ_id,
                t24.bonuskauf_id AS bonuskauf_id_lb
            FROM dbp_ods.ods_promotion_1 AS OP
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
                konditionsart_id,
                t24.aktion_typ_id,
                bonuskauf_id_lb
        ) AS p
            ON
                K.bon_id = p.bon_id AND K.wup_id = p.wup_id AND K.mandant_id = p.mandant_id AND K.bon_dat
                = p.bon_dat AND Z.kl_art_id = p.kl_art_id AND Z.bon_zeile = p.bon_zeile
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
    ) AS x
    GROUP BY
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
        kundenkarte_id,
        kundenkarte_typ_id,
        vk_aktion_brutto,
        vk_brutto,
        konditionsart_id,
        bde_kundenkarte_id,
        bonus_flag
) AS t45
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY mandant_id, bon_id, dat_booking, wup_id, bon_zeile, kl_art_id, ean_kasse
    ORDER BY
        aktion_typ_id IS NULL DESC, aktion_typ_id DESC, konditionsart_id IS NULL DESC, konditionsart_id DESC,
        bonuskauf_id IS NULL, bonuskauf_id, bonuskauf_id_lb IS NULL, bonuskauf_id_lb
)) = 1);


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
            A.bon_dat = C.bon_dat AND C.transaction_name = 'RetailTransaction'
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
    A.mandant_id,
    A.wup_id,
    A.bon_dat,
    A.ean_kasse,
    A.umsatz_brutto,
    A.start_bon_zeile,
    A.bon_nr_extern,
    A.kpos_erfassung_id,
    A.menge,
    A.kl_art_id,
    A.einh_id,
    A.mwst_id,
    A.barcode_leergut,
    A.td_update,
    A.td_insert
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
    NULL AS bde_kundenkarte_id
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
    bde_kundenkarte_id;


INSERT INTO dbp_etl.kmo_artbew_bon_1 (
    mandant_id, bon_id, dat_booking, wup_id, bon_zeile, kl_art_id,
    ean_kasse, menge, umsatz_brutto, wg_id, aktion_id, lkp_wrg, kundenkarte_id, kundenkarte_typ_id, bonuskauf_id,
    bonuskauf_id_lb, aktion_typ_id, konditionsart_id, vk_aktion_brutto, vk_brutto, betrag_promo_brutto_kdn,
    betrag_promo_brutto_kdp, betrag_promo_brutto_null, bde_kundenkarte_id
)
(SELECT
    mandant_id,
    bon_id,
    dat_booking,
    wup_id,
    bon_zeile,
    kl_art_id,
    CAST(ean_kasse AS INTEGER) AS ean_kasse,
    menge,
    CAST(umsatz_brutto AS NUMERIC) AS umsatz_brutto,
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
    SUBSTR(CAST(bde_kundenkarte_id AS STRING), 1, 255) AS bde_kundenkarte_id
FROM `_leergut`);


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    lkp_nb_id = W.nb_id
FROM dbp_data.wup_1 AS W
WHERE kmo_artbew_bon.mandant_id = W.mandant_id AND kmo_artbew_bon.wup_id = W.wup_id;


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    lkp_art_id = CAST(t0.art_id AS INTEGER),
    lkp_zek_id = t0.zek_id,
    lkp_mwst_id = CAST(t0.mwst_id AS INTEGER),
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


-- 27.06.2022, dbay: spec0157445, historical tracking of tax ids


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    lkp_mwst_id = b.mwst_id
FROM dbp_data.art_per_1 AS b
WHERE
    kmo_artbew_bon.dat_booking BETWEEN b.dat_von AND b.dat_bis AND kmo_artbew_bon.mandant_id = b.mandant_id AND
    kmo_artbew_bon.lkp_art_id = b.art_id AND kmo_artbew_bon.lkp_mwst_id <> b.mwst_id;


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    lkp_wg_id = W.wg_id,
    lkp_arthiertyp_id = W.arthiertyp_id
FROM dbp_data.art_wg_zu_per_1 AS W
WHERE kmo_artbew_bon.mandant_id = W.mandant_id AND kmo_artbew_bon.lkp_art_id = W.art_id AND W.dat_bis = PARSE_DATE(
    '%F',
    '9999-12-31'
) AND W.arthiertyp_id = 2;


-- 30.09.2022, -dbay-
--
-- Two updates are taking place for enrichment of countries switching to EUR
-- as new currency.

-- 1. setting the default currency for all rows.


UPDATE dbp_etl.kmo_artbew_bon_1 SET
    lkp_umrechnungskurs = CAST(K.umrechnungskurs AS FLOAT64)
FROM dbp_data.kurs_1 AS K
WHERE
    kmo_artbew_bon.lkp_wrg = K.von_wrg_id -- and dbp_etl.kmo_artbew_bon.dat_booking between k.dat_von and k.dat_bis

    AND K.dat_bis = DATE '9999-12-31' AND K.kurstyp_id = 3 AND K.nach_wrg_id = 'EUR';


-- 2. here is the specific update for our currency changes.


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


-- dbay, 13.12.2022
-- Spendenartikel (u.a. Weihnachten) raus.
-- Jetzt neu mit Artikel_1 202685400.


DELETE FROM dbp_etl.kmo_artbew_bon_1
WHERE mandant_id = 2 AND lkp_art_id IN (818410, 202685400);


-- where coalesce(p.betrag_promo_brutto, 0) <> 0
-- filter killed due to interferences regarding loyalty.

-- 09.01.2023, -dbay-
INSERT INTO dbp_etl.kmo_artbew_bon_promotion_1 (
    mandant_id, bon_id, dat_booking,
    kl_art_id, bon_zeile, bonuskauf_id, konditionsart_id, umsatz_brutto, umsatz_promo_brutto, menge_promo
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
