--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE OR REPLACE TABLE dbp_etl.bestand_mardh_tmp1_1_2 LIKE dbp_data.bestand_erp_monat_2;


INSERT INTO dbp_etl.bestand_mardh_tmp1_1_2 (
    art_id, mandant_id, wup_id, nb_id, gjmo, lagerort_id,
    menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme, gjmo_bis, mard_fg
)
(SELECT
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    gjmo,
    lagerort_id,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme,
    gjmo_bis,
    mard_fg
FROM dbp_data.bestand_erp_monat_2
WHERE (
    art_id, mandant_id, wup_id, nb_id, lagerort_id) IN (
    SELECT (art_id, mandant_id, wup_id, nb_id, lagerort_id)
    FROM dbp_etl.bestand_mardh_tmp_2
));


INSERT INTO dbp_etl.bestand_mardh_tmp_2 (
    art_id, mandant_id, wup_id, nb_id, gjmo, gjmo_bis, lagerort_id,
    mard_fg, menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme, menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme, lade_kz
)
(
    SELECT
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        gjmo,
        gjmo_bis,
        lagerort_id,
        mard_fg,
        menge_lgbest_erp_frei_bme,
        menge_lgbest_erp_umlag_bme,
        menge_lgbest_erp_qual_bme,
        menge_lgbest_erp_nf_charge_bme,
        menge_lgbest_erp_gesp_bme,
        menge_lgbest_erp_ret_gesp_bme,
        1 AS lade_kz
    FROM dbp_etl.bestand_mardh_tmp1_1_2
    WHERE
        mard_fg = 0
        AND (art_id, mandant_id, wup_id, nb_id, lagerort_id, gjmo_bis) NOT IN (SELECT (
            art_id, mandant_id, wup_id, nb_id,
            lagerort_id, gjmo_bis
        )
        FROM dbp_etl.bestand_mardh_tmp_2)
);


CREATE OR REPLACE TABLE dbp_etl.bestand_mardh_tmp2_2 (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    gjmo INTEGER NOT NULL,
    lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL,
    max_dat DATE NOT NULL
);


INSERT INTO dbp_etl.bestand_mardh_tmp2_2 (art_id, mandant_id, wup_id, nb_id, gjmo, lagerort_id, max_dat)
(
    SELECT
        bmt1.art_id,
        bmt1.mandant_id,
        bmt1.wup_id,
        bmt1.nb_id,
        CAST(m.gjmo_ AS INTEGER) AS gjmo,
        bmt1.lagerort_id,
        m.max_dat
    FROM (
        SELECT
            art_id,
            mandant_id,
            wup_id,
            nb_id,
            lagerort_id,
            MAX(gjmo_bis) AS max_gjmo_bis
        FROM dbp_etl.bestand_mardh_tmp_2
        WHERE nb_id = 0
        GROUP BY
            art_id,
            mandant_id,
            wup_id,
            nb_id,
            lagerort_id
    ) AS bmt1
    INNER JOIN (
        SELECT
            mb.mandant_id,
            ROUND(CAST(TRIM(SUBSTR(CAST(SPKZ.sap_buchungs_jahr AS STRING), 1, 10)) || CASE
                WHEN CAST(TRIM(SUBSTR(CAST(SPKZ.buchungsperiode_id AS STRING), 1, 10)) AS FLOAT64) <= 9
                    THEN '0' || TRIM(SUBSTR(CAST(SPKZ.buchungsperiode_id AS STRING), 1, 10))
                ELSE TRIM(SUBSTR(CAST(SPKZ.buchungsperiode_id AS STRING), 1, 10))
            END AS BIGNUMERIC), 0) AS gjmo_,
            MAX(T.dat) AS max_dat
        FROM (SELECT
            mandant_id,
            MAX(dat) AS mbest_max_tag
        FROM dbp_data.marktbestand_erp_2
        WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY) AND (CURRENT_DATE("Europe/Berlin"))
        GROUP BY mandant_id) AS mb
        INNER JOIN dbp_data.tag_2 AS T ON mb.mbest_max_tag >= T.dat
        INNER JOIN dbp_data.sap_periode_kalender_zu_2 AS SPKZ
            ON
                mb.mandant_id = SPKZ.mandant_id AND T.kjmo =
                SPKZ.kjmo AND SPKZ.krk_id IN ('DE01', 'CZ01', 'SK01', 'HR01', 'PL01', 'RO01', 'BG01') AND SPKZ.buchungsperiode_id
                <= 12
        GROUP BY
            mb.mandant_id,
            gjmo_
    ) AS m ON bmt1.max_gjmo_bis < m.gjmo_ AND bmt1.mandant_id = m.mandant_id
);


INSERT INTO dbp_etl.bestand_mardh_tmp2_2 (art_id, mandant_id, wup_id, nb_id, gjmo, lagerort_id, max_dat)
(
    SELECT
        bmt1.art_id,
        bmt1.mandant_id,
        bmt1.wup_id,
        bmt1.nb_id,
        CAST(l.gjmo_ AS INTEGER) AS gjmo,
        bmt1.lagerort_id,
        l.max_dat
    FROM (
        SELECT
            art_id,
            mandant_id,
            wup_id,
            nb_id,
            lagerort_id,
            MAX(gjmo_bis) AS max_gjmo_bis
        FROM dbp_etl.bestand_mardh_tmp_2
        WHERE nb_id <> 0
        GROUP BY
            art_id,
            mandant_id,
            wup_id,
            nb_id,
            lagerort_id
    ) AS bmt1
    INNER JOIN (
        SELECT
            SPKZ.mandant_id,
            ROUND(CAST(TRIM(SUBSTR(CAST(SPKZ.sap_buchungs_jahr AS STRING), 1, 10)) || CASE
                WHEN CAST(TRIM(SUBSTR(CAST(SPKZ.buchungsperiode_id AS STRING), 1, 10)) AS FLOAT64) <= 9
                    THEN '0' || TRIM(SUBSTR(CAST(SPKZ.buchungsperiode_id AS STRING), 1, 10))
                ELSE TRIM(SUBSTR(CAST(SPKZ.buchungsperiode_id AS STRING), 1, 10))
            END AS BIGNUMERIC), 0) AS gjmo_,
            MAX(T.dat) AS max_dat
        FROM dbp_data.tag_2 AS T
        INNER JOIN dbp_data.sap_periode_kalender_zu_2 AS SPKZ
            ON T.kjmo = SPKZ.kjmo AND SPKZ.krk_id IN (
                'DE01',
                'CZ01', 'SK01', 'HR01', 'PL01', 'RO01', 'BG01'
            ) AND SPKZ.buchungsperiode_id <= 12
        WHERE T.dat <= CURRENT_DATE("Europe/Berlin")
        GROUP BY
            SPKZ.mandant_id,
            gjmo_
    ) AS l ON bmt1.mandant_id = l.mandant_id AND bmt1.max_gjmo_bis < l.gjmo_
);


CREATE OR REPLACE TABLE dbp_etl.bestand_mardh_tmp3_2 (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    gjmo INTEGER NOT NULL,
    gjmo_bis INTEGER NOT NULL,
    lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL,
    mard_fg INTEGER NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3),
    menge_lgbest_erp_umlag_bme NUMERIC(29, 3),
    menge_lgbest_erp_qual_bme NUMERIC(29, 3),
    menge_lgbest_erp_nf_charge_bme NUMERIC(29, 3),
    menge_lgbest_erp_gesp_bme NUMERIC(29, 3),
    menge_lgbest_erp_ret_gesp_bme NUMERIC(29, 3)
);


INSERT INTO dbp_etl.bestand_mardh_tmp3_2 (
    art_id, mandant_id, wup_id, nb_id, gjmo, gjmo_bis, lagerort_id,
    mard_fg, menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme, menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme
)
(
    SELECT
        M.art_id,
        M.mandant_id,
        M.wup_id,
        M.nb_id,
        BMT2.gjmo,
        999912 AS gjmo_bis,
        BMT2.lagerort_id,
        1 AS mard_fg,
        M.menge_lgbest_erp_frei_bme,
        CAST(0.0 AS NUMERIC) AS menge_lgbest_erp_umlag_bme,
        M.menge_lgbest_erp_qual_bme,
        CAST(0.0 AS NUMERIC) AS menge_lgbest_erp_nf_charge_bme,
        CAST(0.0 AS NUMERIC) AS menge_lgbest_erp_gesp_bme,
        CAST(0.0 AS NUMERIC) AS menge_lgbest_erp_ret_gesp_bme
    FROM dbp_data.marktbestand_erp_2 AS M
    INNER JOIN dbp_etl.bestand_mardh_tmp2_2 AS BMT2
        ON
            M.art_id = BMT2.art_id AND M.mandant_id = BMT2.mandant_id
            AND M.wup_id = BMT2.wup_id AND M.nb_id = BMT2.nb_id AND M.dat = BMT2.max_dat
    QUALIFY (COUNT(*) OVER (PARTITION BY
        M.mandant_id, M.art_id, M.wup_id, M.nb_id, BMT2.lagerort_id ORDER BY
        BMT2.gjmo
        IS NULL, BMT2.gjmo
    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) = 1 OR (SUM(M.menge_lgbest_erp_frei_bme) OVER
    (
        PARTITION BY M.mandant_id, M.art_id, M.wup_id, M.nb_id, BMT2.lagerort_id ORDER BY BMT2.gjmo IS NULL, BMT2.gjmo
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    )) <> 2.0 * M.menge_lgbest_erp_frei_bme OR (SUM(M.menge_lgbest_erp_qual_bme
    ) OVER (PARTITION BY
        M.mandant_id, M.art_id, M.wup_id, M.nb_id, BMT2.lagerort_id ORDER BY
        BMT2.gjmo IS NULL,
        BMT2.gjmo
    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) <> 2.0 * M.menge_lgbest_erp_qual_bme OR (SUM(0.0) OVER
    (
        PARTITION BY M.mandant_id, M.art_id, M.wup_id, M.nb_id, BMT2.lagerort_id ORDER BY BMT2.gjmo IS NULL, BMT2.gjmo
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) <> 2.0 * 0.0 OR (SUM(0.0) OVER (PARTITION BY
        M.mandant_id, M.art_id,
        M.wup_id, M.nb_id, BMT2.lagerort_id
    ORDER BY BMT2.gjmo IS NULL, BMT2.gjmo
    ROWS BETWEEN 1 PRECEDING AND
    CURRENT ROW)) <> 2.0 * 0.0 OR (SUM(0.0) OVER (
        PARTITION BY M.mandant_id, M.art_id, M.wup_id, M.nb_id, BMT2.lagerort_id
        ORDER BY BMT2.gjmo IS NULL, BMT2.gjmo ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    )) <> 2.0 * 0.0 OR (SUM(0.0) OVER
    (
        PARTITION BY M.mandant_id, M.art_id, M.wup_id, M.nb_id, BMT2.lagerort_id ORDER BY BMT2.gjmo IS NULL, BMT2.gjmo
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    )) <> 2.0 * 0.0
);


INSERT INTO dbp_etl.bestand_mardh_tmp3_2 (
    art_id, mandant_id, wup_id, nb_id, gjmo, gjmo_bis, lagerort_id,
    mard_fg, menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme, menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme
)
(
    SELECT
        L.art_id,
        L.mandant_id,
        L.wup_id,
        L.nb_id,
        BMT2.gjmo,
        999912 AS gjmo_bis,
        L.lagerort_id,
        1 AS mard_fg,
        L.menge_lgbest_erp_frei_bme,
        L.menge_lgbest_erp_umlag_bme,
        L.menge_lgbest_erp_qual_bme,
        L.menge_lgbest_erp_nf_charge_bme,
        L.menge_lgbest_erp_gesp_bme,
        L.menge_lgbest_erp_ret_gesp_bme
    FROM dbp_data.lagerbestand_erp_per_2 AS L
    INNER JOIN dbp_etl.bestand_mardh_tmp2_2 AS BMT2
        ON
            L.art_id = BMT2.art_id AND L.mandant_id = BMT2.mandant_id
            AND L.wup_id = BMT2.wup_id AND L.nb_id = BMT2.nb_id AND L.lagerort_id = BMT2.lagerort_id AND BMT2.max_dat
            BETWEEN L.dat_von AND L.dat_bis
    WHERE L.nb_id <> 0
    QUALIFY (COUNT(*) OVER (PARTITION BY
        L.mandant_id, L.art_id, L.wup_id, L.nb_id, L.lagerort_id ORDER BY
        BMT2.gjmo
        IS NULL, BMT2.gjmo
    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) = 1 OR (SUM(L.menge_lgbest_erp_frei_bme) OVER
    (
        PARTITION BY L.mandant_id, L.art_id, L.wup_id, L.nb_id, L.lagerort_id ORDER BY BMT2.gjmo IS NULL, BMT2.gjmo
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    )) <> 2.0 * L.menge_lgbest_erp_frei_bme OR (SUM(L.menge_lgbest_erp_qual_bme
    ) OVER (PARTITION BY L.mandant_id, L.art_id, L.wup_id, L.nb_id, L.lagerort_id ORDER BY BMT2.gjmo IS NULL, BMT2.gjmo ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) <> 2.0 * L.menge_lgbest_erp_qual_bme OR (SUM(L.menge_lgbest_erp_umlag_bme
    ) OVER (PARTITION BY L.mandant_id, L.art_id, L.wup_id, L.nb_id, L.lagerort_id ORDER BY BMT2.gjmo IS NULL, BMT2.gjmo ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) <> 2.0 * L.menge_lgbest_erp_umlag_bme OR (SUM(L.menge_lgbest_erp_nf_charge_bme
    ) OVER (
        PARTITION BY L.mandant_id, L.art_id, L.wup_id, L.nb_id, L.lagerort_id ORDER BY BMT2.gjmo IS NULL, BMT2.gjmo
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    )) <> 2.0 * L.menge_lgbest_erp_nf_charge_bme OR (SUM(L.menge_lgbest_erp_gesp_bme
    ) OVER (
        PARTITION BY L.mandant_id, L.art_id, L.wup_id, L.nb_id, L.lagerort_id ORDER BY BMT2.gjmo IS NULL, BMT2.gjmo
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    )) <> 2.0 * L.menge_lgbest_erp_gesp_bme OR (SUM(L.menge_lgbest_erp_ret_gesp_bme
    ) OVER (
        PARTITION BY L.mandant_id, L.art_id, L.wup_id, L.nb_id, L.lagerort_id ORDER BY BMT2.gjmo IS NULL, BMT2.gjmo
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    )) <> 2.0 * L.menge_lgbest_erp_ret_gesp_bme
);


DROP TABLE IF EXISTS dbp_etl.bestand_erp_monat_tmp_2;


CREATE TABLE IF NOT EXISTS dbp_etl.bestand_erp_monat_tmp_2 LIKE dbp_data.bestand_erp_monat_2;


INSERT INTO dbp_etl.bestand_erp_monat_tmp_2 (
    art_id, mandant_id, wup_id, nb_id, gjmo, lagerort_id,
    menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme, gjmo_bis, mard_fg
)
(SELECT
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    CAST(CASE
        WHEN mard_fg = 0
            THEN CASE
                WHEN (COUNT(*) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY gjmo_bis IS NULL, gjmo_bis ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) = 1
                    THEN CAST(gjmo AS BIGNUMERIC)
                ELSE ROUND(CAST(FORMAT_DATE('%Y%m', IF(DATE(CAST(LAG(gjmo_bis, 1) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY gjmo_bis IS NULL, gjmo_bis) AS STRING)) = LAST_DAY(DATE(CAST(LAG(gjmo_bis, 1) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY
                    gjmo_bis IS NULL, gjmo_bis) AS STRING))), LAST_DAY(DATE_ADD(DATE(CAST(LAG(gjmo_bis, 1) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY gjmo_bis IS NULL, gjmo_bis) AS STRING)), INTERVAL -1 MONTH)), DATE_ADD(DATE(CAST(LAG(gjmo_bis, 1) OVER (PARTITION BY
                    art_id, mandant_id, wup_id, nb_id, lagerort_id
                ORDER BY gjmo_bis IS NULL, gjmo_bis) AS STRING)), INTERVAL -1 MONTH))) AS BIGNUMERIC), 0)
            END
        ELSE CAST(gjmo AS BIGNUMERIC)
    END AS INTEGER) AS gjmo_ab,
    lagerort_id,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme,
    CAST(COALESCE(CASE
        WHEN mard_fg = 1
            THEN CASE
                WHEN (COUNT(*) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY gjmo IS NULL DESC, gjmo DESC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) = 1
                    THEN CAST(gjmo_bis AS BIGNUMERIC)
                ELSE ROUND(CAST(FORMAT_DATE('%Y%m', IF(
                    DATE(CAST(LAG(gjmo, 1) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY gjmo IS NULL DESC, gjmo DESC) AS STRING)
                    ) = LAST_DAY(
                        DATE(CAST(LAG(gjmo, 1) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY gjmo IS NULL DESC, gjmo DESC) AS STRING)
                        )), LAST_DAY(
                        DATE_ADD(
                            DATE(CAST(LAG(gjmo, 1) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY gjmo IS NULL DESC, gjmo DESC) AS STRING)
                            ), INTERVAL -1 MONTH
                        )
                    ), DATE_ADD(
                        DATE(CAST(LAG(gjmo, 1) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY gjmo IS NULL DESC, gjmo DESC) AS STRING)
                        ), INTERVAL -1 MONTH
                    )
                )) AS BIGNUMERIC), 0)
            END
        ELSE CAST(gjmo_bis AS BIGNUMERIC)
    END, CASE
        WHEN mard_fg = 0
            THEN CASE
                WHEN (COUNT(*) OVER (PARTITION BY
                    art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY
                    gjmo_bis IS NULL,
                    gjmo_bis
                ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) = 1
                    THEN CAST(gjmo AS BIGNUMERIC)
                ELSE ROUND(CAST(FORMAT_DATE('%Y%m', IF(
                    DATE(CAST(LAG(gjmo_bis, 1) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY gjmo_bis IS NULL, gjmo_bis) AS STRING)
                    ) = LAST_DAY(
                        DATE(CAST(LAG(gjmo_bis, 1) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY gjmo_bis IS NULL, gjmo_bis) AS STRING)
                        )), LAST_DAY(
                        DATE_ADD(
                            DATE(CAST(LAG(gjmo_bis, 1) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY gjmo_bis IS NULL, gjmo_bis) AS STRING)
                            ), INTERVAL -1 MONTH
                        )
                    ), DATE_ADD(
                        DATE(CAST(LAG(gjmo_bis, 1) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY gjmo_bis IS NULL, gjmo_bis) AS STRING)
                        ), INTERVAL -1 MONTH
                    )
                )) AS BIGNUMERIC), 0)
            END
        ELSE CAST(gjmo AS BIGNUMERIC)
    END) AS INTEGER) AS `_gjmo_bis`,
    mard_fg
FROM (SELECT
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    gjmo,
    gjmo_bis,
    lagerort_id,
    mard_fg,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme
FROM dbp_etl.bestand_mardh_tmp_2
UNION ALL
SELECT *
FROM dbp_etl.bestand_mardh_tmp3_2) AS tmp);


DELETE FROM dbp_data.bestand_erp_monat_2
WHERE (
    art_id, mandant_id, wup_id, nb_id, lagerort_id) IN (
    SELECT (art_id, mandant_id, wup_id, nb_id, lagerort_id)
    FROM dbp_etl.bestand_erp_monat_tmp_2
);


INSERT INTO dbp_data.bestand_erp_monat_2 (
    art_id, mandant_id, wup_id, nb_id, gjmo, lagerort_id,
    menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme, gjmo_bis, mard_fg, td_update, td_insert
)
(SELECT
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    gjmo,
    lagerort_id,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme,
    gjmo_bis,
    mard_fg,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM dbp_etl.bestand_erp_monat_tmp_2);
