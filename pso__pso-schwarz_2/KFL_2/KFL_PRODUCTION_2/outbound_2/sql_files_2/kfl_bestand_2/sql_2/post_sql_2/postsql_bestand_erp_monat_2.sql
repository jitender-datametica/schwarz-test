CREATE OR REPLACE TEMPORARY TABLE _dedup AS
SELECT *
FROM ${TEMP_TABLE}
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        mandant_id, art_id, wup_id, lagerort_id ORDER BY
        mard_fg IS NULL DESC, mard_fg
        DESC
)) = 1;


CREATE OR REPLACE TEMPORARY TABLE _xxx AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.art_id,
    A.lagerort_id,
    A.gjmo_bis,
    C.gjmo + 100 AS gjmo,
    A.gjmo_bis AS zeit_org
FROM `_dedup` AS A
INNER JOIN dbp_data.monat_2 AS B ON A.gjmo_bis - 100 = B.gjmo
INNER JOIN dbp_data.monat_2 AS C ON B.akt_mo - 1 = C.akt_mo
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.art_id,
    A.lagerort_id,
    A.gjmo_bis,
    gjmo,
    zeit_org
UNION DISTINCT
SELECT
    A.mandant_id,
    A.wup_id,
    A.art_id,
    A.lagerort_id,
    A.gjmo_bis,
    C.gjmo + 100 AS gjmo,
    A.gjmo AS zeit_org
FROM `_dedup` AS A
INNER JOIN dbp_data.monat_2 AS B ON A.gjmo - 100 = B.gjmo
INNER JOIN dbp_data.monat_2 AS C ON B.akt_mo - 1 = C.akt_mo
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.art_id,
    A.lagerort_id,
    A.gjmo_bis,
    gjmo,
    zeit_org;


UPDATE dbp_data.bestand_erp_monat_2 SET
    gjmo_bis = b.gjmo FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.art_id,
        A.gjmo_bis,
        A.lagerort_id,
        C.gjmo + 100 AS gjmo
    FROM `_dedup` AS A
    INNER JOIN dbp_data.monat_2 AS B ON A.gjmo_bis - 100 = B.gjmo
    INNER JOIN dbp_data.monat_2 AS C ON B.akt_mo - 1 = C.akt_mo
    WHERE A.gjmo_bis <> 999912
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.art_id,
        A.gjmo_bis,
        A.lagerort_id,
        gjmo
    UNION DISTINCT
    SELECT
        A.mandant_id,
        A.wup_id,
        A.art_id,
        A.gjmo_bis,
        A.lagerort_id,
        b.gjmo
    FROM `_dedup` AS A
    INNER JOIN (
        SELECT
            mandant_id,
            gjmo
        FROM `_xxx`
        GROUP BY
            mandant_id,
            gjmo
    ) AS b ON A.mandant_id = b.mandant_id
    WHERE A.gjmo_bis = 999912
    GROUP BY
        A.art_id,
        A.mandant_id,
        A.wup_id,
        A.lagerort_id,
        A.gjmo_bis,
        b.gjmo
) AS b
WHERE
    bestand_erp_monat.mandant_id = b.mandant_id AND bestand_erp_monat.wup_id = b.wup_id AND bestand_erp_monat.art_id =
    b.art_id AND bestand_erp_monat.lagerort_id = b.lagerort_id AND (
        bestand_erp_monat.gjmo_bis = b.gjmo_bis OR
        bestand_erp_monat.gjmo_bis = 999912
    );


UPDATE `_dedup` SET
    gjmo = `_dedup`.gjmo_bis
WHERE gjmo = 190001;


DELETE FROM dbp_data.bestand_erp_monat_2
WHERE (
    mandant_id, wup_id, art_id, gjmo) IN (
    SELECT (mandant_id, wup_id, art_id, gjmo)
    FROM `_dedup`
);


INSERT INTO dbp_data.bestand_erp_monat_2 (
    art_id, mandant_id, wup_id, nb_id, gjmo, lagerort_id,
    menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme, gjmo_bis, mard_fg, datzeit_daten_abzug, vk_brutto, td_update,
    td_insert
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
    datzeit_daten_abzug,
    vk_brutto,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
FROM `_dedup`);


UPDATE dbp_data.bestand_erp_monat_2 SET
    gjmo_bis = bestand_erp_monat.gjmo FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.art_id,
        A.lagerort_id,
        A.gjmo_bis,
        COUNT(*) AS anz,
        MAX(A.gjmo) AS max_gjmo,
        MIN(A.gjmo) AS min_gjmo,
        MIN(A.gjmo_bis) AS min_gjmo_bis,
        MAX(C.gjmo) AS upd_gjmo_bis
    FROM dbp_data.bestand_erp_monat_2 AS A
    INNER JOIN dbp_data.monat_2 AS B ON A.gjmo_bis = B.gjmo
    INNER JOIN dbp_data.monat_2 AS C ON B.akt_mo + 1 = C.akt_mo
    GROUP BY
        A.art_id,
        A.mandant_id,
        A.wup_id,
        A.lagerort_id,
        A.gjmo_bis
    HAVING anz > 1
) AS b
WHERE
    bestand_erp_monat.mandant_id = b.mandant_id AND bestand_erp_monat.art_id = b.art_id AND bestand_erp_monat.wup_id =
    b.wup_id AND bestand_erp_monat.lagerort_id = b.lagerort_id AND bestand_erp_monat.gjmo >= b.min_gjmo;


UPDATE dbp_data.bestand_erp_monat_2 AS bestand_erp_monat0 SET
    gjmo = CAST(d.gjmo_ab_ AS INTEGER) FROM (SELECT
    mandant_id,
    art_id,
    wup_id,
    lagerort_id,
    gjmo_bis,
    PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) AS gjmo_bis_dat,
    LAG(PARSE_DATE(
        '%Y%m', CAST(gjmo_bis AS STRING)), 1) OVER (
        PARTITION BY mandant_id, art_id, wup_id, lagerort_id
        ORDER BY PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
    ) AS
    lag_test,
    CASE
        WHEN (LAG(PARSE_DATE('%Y%m', CAST(
            gjmo_bis AS STRING
        )), 1) OVER (
            PARTITION BY
                mandant_id, art_id, wup_id,
                lagerort_id ORDER BY
                PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
                )
        )) IS NULL
            THEN PARSE_DATE('%Y%m', CAST(gjmo AS STRING))
        ELSE IF((LAG(PARSE_DATE('%Y%m', CAST(
            gjmo_bis as STRING)), 1) OVER (PARTITION BY mandant_id, art_id, wup_id,
        lagerort_id ORDER BY PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
        ))) = LAST_DAY((LAG(PARSE_DATE('%Y%m', CAST(
            gjmo_bis as STRING
        )), 1) OVER (
            PARTITION BY
                mandant_id,
                art_id, wup_id, lagerort_id ORDER BY
                PARSE_DATE(
                    '%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE(
                    '%Y%m',
                    CAST(gjmo_bis AS STRING)
                )
        ))), LAST_DAY(DATE_ADD(LAG(PARSE_DATE(
            '%Y%m', CAST(gjmo_bis as STRING
            )
        ), 1)
            OVER (
                PARTITION BY
                    mandant_id, art_id, wup_id, lagerort_id ORDER BY
                    PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
                    IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
            ), INTERVAL 1 MONTH)), DATE_ADD(LAG(PARSE_DATE('%Y%m',
        CAST(gjmo_bis as STRING)), 1) OVER (
            PARTITION BY mandant_id, art_id, wup_id, lagerort_id ORDER BY
                PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
        ), INTERVAL 1
        MONTH))
    END AS dat_ab,
    ROUND(CAST(FORMAT_DATE('%Y%m', CASE
        WHEN (LAG(PARSE_DATE('%Y%m', CAST(
            gjmo_bis AS STRING
        )), 1) OVER (
            PARTITION BY
                mandant_id, art_id, wup_id,
                lagerort_id ORDER BY
                PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
                )
        )) IS NULL
            THEN PARSE_DATE('%Y%m', CAST(gjmo AS STRING))
        ELSE IF((LAG(PARSE_DATE('%Y%m', CAST(
            gjmo_bis as STRING)), 1) OVER (PARTITION BY mandant_id, art_id, wup_id,
        lagerort_id ORDER BY PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
        ))) = LAST_DAY((LAG(PARSE_DATE('%Y%m', CAST(
            gjmo_bis as STRING
        )), 1) OVER (
            PARTITION BY
                mandant_id,
                art_id, wup_id, lagerort_id ORDER BY
                PARSE_DATE(
                    '%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE(
                    '%Y%m',
                    CAST(gjmo_bis AS STRING)
                )
        ))), LAST_DAY(DATE_ADD(LAG(PARSE_DATE(
            '%Y%m', CAST(gjmo_bis as STRING
            )
        ),
        1) OVER (
            PARTITION BY
                mandant_id, art_id, wup_id, lagerort_id ORDER BY
                PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
                ) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
        ), INTERVAL 1 MONTH)), DATE_ADD(LAG(PARSE_DATE('%Y%m',
        CAST(gjmo_bis as STRING)), 1) OVER (
            PARTITION BY mandant_id, art_id, wup_id, lagerort_id ORDER BY
                PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
        ),
        INTERVAL 1 MONTH))
    END) AS BIGNUMERIC), 0) AS gjmo_ab_
FROM dbp_data.bestand_erp_monat_2
QUALIFY ROUND(CAST(FORMAT_DATE('%Y%m', CASE
    WHEN (LAG(PARSE_DATE('%Y%m', CAST(
        gjmo_bis AS STRING
    )), 1) OVER (
        PARTITION BY
            mandant_id, art_id, wup_id,
            lagerort_id ORDER BY
            PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
            )
    )) IS NULL
        THEN PARSE_DATE('%Y%m', CAST(gjmo AS STRING))
    ELSE IF((LAG(PARSE_DATE('%Y%m', CAST(
        gjmo_bis as STRING)), 1) OVER (PARTITION BY mandant_id, art_id, wup_id,
    lagerort_id ORDER BY PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
    ))) = LAST_DAY((LAG(PARSE_DATE('%Y%m', CAST(
        gjmo_bis as STRING
    )), 1) OVER (
        PARTITION BY
            mandant_id,
            art_id, wup_id, lagerort_id ORDER BY
            PARSE_DATE(
                '%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE(
                '%Y%m',
                CAST(gjmo_bis AS STRING)
            )
    ))), LAST_DAY(DATE_ADD(LAG(PARSE_DATE(
        '%Y%m', CAST(gjmo_bis as STRING
        )
    ),
    1) OVER (
        PARTITION BY
            mandant_id, art_id, wup_id, lagerort_id ORDER BY
            PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
            ) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
    ), INTERVAL 1 MONTH)), DATE_ADD(LAG(PARSE_DATE('%Y%m',
    CAST(gjmo_bis as STRING)), 1) OVER (
        PARTITION BY mandant_id, art_id, wup_id, lagerort_id ORDER BY
            PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
    ),
    INTERVAL 1 MONTH))
END) AS BIGNUMERIC), 0) <> gjmo) AS d
WHERE
    bestand_erp_monat0.mandant_id = d.mandant_id AND bestand_erp_monat0.art_id = d.art_id AND bestand_erp_monat0.wup_id
    = d.wup_id AND bestand_erp_monat0.lagerort_id = d.lagerort_id AND bestand_erp_monat0.gjmo_bis = d.gjmo_bis AND
    bestand_erp_monat0.gjmo <> d.gjmo_ab_;


-- 28.12.2022, -dbay-
-- Performance!


CREATE OR REPLACE TEMPORARY TABLE _awzp AS
SELECT *
FROM dbp_data.art_wup_zu_per_2
WHERE dat_bis >= (
    SELECT MIN(PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)))
    FROM `_dedup`
)
AND mandant_id IN (
    SELECT mandant_id
    FROM `_dedup`
    GROUP BY mandant_id
);


UPDATE dbp_data.bestand_erp_monat_2 SET
    vk_brutto = b.vk_brutto_,
    wrg_id = b.wrg_id_ FROM (
    SELECT
        T2.mandant_id AS mandant_id_,
        T2.art_id AS art_id_,
        T2.wup_id AS wup_id_,
        T1.vk_brutto AS vk_brutto_,
        T2.gjmo_bis AS gjmo_bis_,
        T2.lagerort_id AS lagerort_id_,
        T1.wrg_id AS wrg_id_
    FROM `_awzp` AS T1_2
    INNER JOIN
        `_dedup`
            AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id AND T1.wup_id = T2.wup_id AND
            PARSE_DATE('%Y%m', CAST(T2.gjmo_bis AS STRING)) BETWEEN T1.dat_von AND T1.dat_bis
) AS b
WHERE
    bestand_erp_monat.mandant_id = b.mandant_id_ AND bestand_erp_monat.art_id = b.art_id_ AND bestand_erp_monat.wup_id
    = b.wup_id_ AND bestand_erp_monat.gjmo_bis = b.gjmo_bis_ AND bestand_erp_monat.lagerort_id = b.lagerort_id_;


UPDATE dbp_data.bestand_erp_monat_2 SET
    wrg_id = b.default_wrg FROM (SELECT
    mandant_id,
    default_wrg
FROM dbp_data.mandant_2) AS b
WHERE bestand_erp_monat.mandant_id = b.mandant_id AND bestand_erp_monat.wrg_id IS NULL;
