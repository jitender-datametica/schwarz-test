CREATE OR REPLACE TEMPORARY TABLE _dedup AS
SELECT *
FROM ${TEMP_TABLE}
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, mandant_id, bewertungskreis_id ORDER BY
        art_id IS NULL, art_id,
        mandant_id IS NULL, mandant_id, bewertungskreis_id IS NULL, bewertungskreis_id, dat_aenderung IS NULL DESC,
        dat_aenderung DESC
)) = 1;


DELETE FROM `_dedup`
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_wg_zu_per_1
    WHERE
        arthiertyp_id = 2
        AND dat_bis = DATE '9999-12-31'
        AND wg_id = 961
);


CREATE OR REPLACE TEMPORARY TABLE _xxx AS
SELECT
    A.mandant_id,
    A.bewertungskreis_id,
    A.art_id,
    A.gjmo_bis,
    C.gjmo + 100 AS gjmo
FROM `_dedup` AS A
INNER JOIN dbp_data.monat_1 AS B ON A.gjmo_bis - 100 = B.gjmo
INNER JOIN dbp_data.monat_1 AS C ON B.akt_mo - 1 = C.akt_mo
GROUP BY
    A.mandant_id,
    A.bewertungskreis_id,
    A.art_id,
    A.gjmo_bis,
    gjmo
UNION DISTINCT
SELECT
    A.mandant_id,
    A.bewertungskreis_id,
    A.art_id,
    A.gjmo_bis,
    C.gjmo + 100 AS gjmo
FROM `_dedup` AS A
INNER JOIN dbp_data.monat_1 AS B ON A.gjmo - 100 = B.gjmo
INNER JOIN dbp_data.monat_1 AS C ON B.akt_mo - 1 = C.akt_mo
GROUP BY
    A.mandant_id,
    A.bewertungskreis_id,
    A.art_id,
    A.gjmo_bis,
    gjmo;


UPDATE dbp_data.art_bewertungskreis_periode_1 SET
    gjmo_bis = b.gjmo FROM (
    SELECT
        A.mandant_id,
        A.bewertungskreis_id,
        A.art_id,
        A.gjmo_bis,
        C.gjmo + 100 AS gjmo
    FROM `_dedup` AS A
    INNER JOIN dbp_data.monat_1 AS B ON A.gjmo_bis - 100 = B.gjmo
    INNER JOIN dbp_data.monat_1 AS C ON B.akt_mo - 1 = C.akt_mo
    WHERE A.gjmo_bis <> 999912
    GROUP BY
        A.mandant_id,
        A.bewertungskreis_id,
        A.art_id,
        A.gjmo_bis,
        gjmo
    UNION DISTINCT
    SELECT
        A.mandant_id,
        A.bewertungskreis_id,
        A.art_id,
        A.gjmo_bis,
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
        A.bewertungskreis_id,
        A.gjmo_bis,
        b.gjmo
) AS b
WHERE
    art_bewertungskreis_periode.mandant_id = b.mandant_id AND art_bewertungskreis_periode.bewertungskreis_id = b.bewertungskreis_id
    AND art_bewertungskreis_periode.art_id = b.art_id AND (
        art_bewertungskreis_periode.gjmo_bis = b.gjmo_bis OR
        art_bewertungskreis_periode.gjmo_bis = 999912
    );


UPDATE `_dedup` SET
    gjmo = `_dedup`.gjmo_bis
WHERE gjmo = 190001;


DELETE FROM dbp_data.art_bewertungskreis_periode_1
WHERE (
    mandant_id, bewertungskreis_id, art_id, gjmo) IN (
    SELECT (mandant_id, bewertungskreis_id, art_id, gjmo)
    FROM `_dedup`
);


INSERT INTO dbp_data.art_bewertungskreis_periode_1 (
    gjmo, art_id, mandant_id, bewertungskreis_id, wrg_id,
    dat_aenderung, menge_bestand_bme, wert_bestand, vk_wert, mbew_fg, gjmo_bis, bewertung_klasse_id, preis_steuer_kz, gld,
    standard_preis, dat_letzte_preisaenderung, vk_wert_netto
)
(SELECT
    gjmo,
    art_id,
    mandant_id,
    bewertungskreis_id,
    wrg_id,
    dat_aenderung,
    menge_bestand_bme,
    wert_bestand,
    vk_wert,
    mbew_fg,
    gjmo_bis,
    bewertung_klasse_id,
    preis_steuer_kz,
    gld,
    standard_preis,
    dat_letzte_preisaenderung,
    vk_wert_netto
FROM `_dedup`);


UPDATE dbp_data.art_bewertungskreis_periode_1 AS art_bewertungskreis_periode0 SET
    gjmo = CAST(d.gjmo_ab_ AS INTEGER) FROM (SELECT
    mandant_id,
    art_id,
    bewertungskreis_id,
    gjmo_bis,
    PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) AS gjmo_bis_dat,
    LAG(PARSE_DATE(
        '%Y%m', CAST(gjmo_bis AS STRING)), 1) OVER (
        PARTITION BY mandant_id, art_id, bewertungskreis_id
        ORDER BY PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
    ) AS
    lag_test,
    CASE
        WHEN (LAG(PARSE_DATE(
            '%Y%m', CAST(gjmo_bis AS STRING)), 1) OVER (
            PARTITION BY mandant_id, art_id, bewertungskreis_id
            ORDER BY PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
        ))
        IS NULL
            THEN PARSE_DATE('%Y%m', CAST(gjmo AS STRING))
        ELSE IF((LAG(PARSE_DATE('%Y%m', CAST(
            gjmo_bis as STRING)), 1) OVER (PARTITION BY mandant_id, art_id,
        bewertungskreis_id ORDER BY PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
        ))) = LAST_DAY((LAG(PARSE_DATE('%Y%m', CAST(
            gjmo_bis as STRING)), 1) OVER (PARTITION BY mandant_id,
        art_id, bewertungskreis_id ORDER BY PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
        )))), LAST_DAY(DATE_ADD(LAG(PARSE_DATE('%Y%m', CAST(gjmo_bis as STRING)), 1) OVER (
            PARTITION BY
                mandant_id, art_id, bewertungskreis_id ORDER BY
                PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL,
                PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
        ), INTERVAL 1 MONTH)), DATE_ADD(LAG(PARSE_DATE('%Y%m', CAST(
            gjmo_bis
            as STRING
        )), 1) OVER (
            PARTITION BY
                mandant_id, art_id, bewertungskreis_id ORDER BY PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
            ) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
        ), INTERVAL 1 MONTH))
    END AS dat_ab,
    ROUND(CAST(FORMAT_DATE('%Y%m', CASE
        WHEN (LAG(PARSE_DATE('%Y%m', CAST(
            gjmo_bis AS STRING
        )), 1) OVER (
            PARTITION BY
                mandant_id, art_id,
                bewertungskreis_id ORDER BY
                PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
                )
        )) IS NULL
            THEN PARSE_DATE('%Y%m', CAST(gjmo AS STRING))
        ELSE IF((LAG(PARSE_DATE('%Y%m', CAST(
            gjmo_bis as STRING)), 1) OVER (PARTITION BY mandant_id, art_id,
        bewertungskreis_id ORDER BY PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
        ))) = LAST_DAY((LAG(PARSE_DATE('%Y%m', CAST(
            gjmo_bis as STRING
        )), 1) OVER (
            PARTITION BY
                mandant_id,
                art_id, bewertungskreis_id ORDER BY
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
                mandant_id, art_id, bewertungskreis_id ORDER BY
                PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
                ) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
        ), INTERVAL 1 MONTH)), DATE_ADD(LAG(PARSE_DATE('%Y%m',
        CAST(gjmo_bis as STRING)), 1) OVER (
            PARTITION BY mandant_id, art_id, bewertungskreis_id ORDER BY
                PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
        ),
        INTERVAL 1 MONTH))
    END) AS BIGNUMERIC), 0) AS gjmo_ab_
FROM dbp_data.art_bewertungskreis_periode_1
WHERE SAFE.PARSE_DATE('%Y%m', CAST(gjmo AS STRING)) IS NOT NULL
QUALIFY ROUND(CAST(FORMAT_DATE('%Y%m', CASE
    WHEN (LAG(PARSE_DATE('%Y%m', CAST(
        gjmo_bis AS STRING
    )), 1) OVER (
        PARTITION BY
            mandant_id, art_id,
            bewertungskreis_id ORDER BY
            PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
            )
    )) IS NULL
        THEN PARSE_DATE('%Y%m', CAST(gjmo AS STRING))
    ELSE IF((LAG(PARSE_DATE('%Y%m', CAST(
        gjmo_bis as STRING)), 1) OVER (PARTITION BY mandant_id, art_id,
    bewertungskreis_id ORDER BY PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
    ))) = LAST_DAY((LAG(PARSE_DATE('%Y%m', CAST(
        gjmo_bis as STRING
    )), 1) OVER (
        PARTITION BY
            mandant_id,
            art_id, bewertungskreis_id ORDER BY
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
            mandant_id, art_id, bewertungskreis_id ORDER BY
            PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)
            ) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
    ), INTERVAL 1 MONTH)), DATE_ADD(LAG(PARSE_DATE('%Y%m',
    CAST(gjmo_bis as STRING)), 1) OVER (
        PARTITION BY mandant_id, art_id, bewertungskreis_id ORDER BY
            PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING)) IS NULL, PARSE_DATE('%Y%m', CAST(gjmo_bis AS STRING))
    ),
    INTERVAL 1 MONTH))
END) AS BIGNUMERIC), 0) <> gjmo) AS d
WHERE
    art_bewertungskreis_periode0.mandant_id = d.mandant_id AND art_bewertungskreis_periode0.art_id = d.art_id AND
    art_bewertungskreis_periode0.bewertungskreis_id = d.bewertungskreis_id AND art_bewertungskreis_periode0.gjmo_bis = d.gjmo_bis AND art_bewertungskreis_periode0.gjmo <> d.gjmo_ab_;
