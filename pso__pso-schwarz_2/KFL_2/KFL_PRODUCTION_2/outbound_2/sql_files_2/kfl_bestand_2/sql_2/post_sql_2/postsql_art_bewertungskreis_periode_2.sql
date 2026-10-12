CREATE OR REPLACE TEMPORARY TABLE _dedup AS
SELECT *
FROM ${TEMP_TABLE}
WHERE mbew_fg = 1
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, mandant_id, bewertungskreis_id ORDER BY
        art_id IS NULL, art_id,
        mandant_id IS NULL, mandant_id, bewertungskreis_id IS NULL, bewertungskreis_id, dat_aenderung IS NULL DESC,
        dat_aenderung DESC
)) = 1;


DELETE FROM ${TEMP_TABLE}
WHERE mbew_fg = 1;


INSERT INTO ${TEMP_TABLE}
(
    SELECT *
    FROM `_dedup`
);


INSERT INTO ${TEMP_TABLE} (
    gjmo, art_id,
    mandant_id, bewertungskreis_id, wrg_id, dat_aenderung, menge_bestand_bme, wert_bestand, vk_wert, mbew_fg, gjmo_bis,
    bewertung_klasse_id, preis_steuer_kz, gld, standard_preis, dat_letzte_preisaenderung, vk_wert_netto
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
FROM dbp_data.art_bewertungskreis_periode_2
WHERE (
    mandant_id, art_id, bewertungskreis_id, gjmo_bis) IN (
    SELECT (A.mandant_id, A.art_id, A.bewertungskreis_id, MAX(A.gjmo_bis))
    FROM dbp_data.art_bewertungskreis_periode_2 AS A
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            bewertungskreis_id,
            MIN(gjmo_bis) AS gjmo_bis_
        FROM ${TEMP_TABLE}
        WHERE mbew_fg = 0
        GROUP BY
            mandant_id,
            art_id,
            bewertungskreis_id
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.bewertungskreis_id = b.bewertungskreis_id
            AND A.gjmo_bis < b.gjmo_bis_
    GROUP BY A.mandant_id,
    A.art_id,
    A.bewertungskreis_id
)
AND mbew_fg = 0);


/*
#------------------------------------------------------------------------------
# 4.) Loeschen bestehender Datensätze
#     das koennen entweder neue Mbew Sätze sein (diese sind bis unendlich gueltig)
#     oder bestehende mbewh Daten
#------------------------------------------------------------------------------
*/


DELETE FROM dbp_data.art_bewertungskreis_periode_2
WHERE (mandant_id, art_id, bewertungskreis_id, gjmo_bis, mbew_fg) IN (SELECT (
    mandant_id, art_id, bewertungskreis_id,
    gjmo_bis, mbew_fg
)
FROM ${TEMP_TABLE}
WHERE mbew_fg = 1);


DELETE FROM dbp_data.art_bewertungskreis_periode_2
WHERE (mandant_id, art_id, bewertungskreis_id, gjmo_bis, mbew_fg) IN (
    SELECT (
        A.mandant_id, A.art_id, A.bewertungskreis_id,
        A.gjmo_bis, A.mbew_fg
    )
    FROM dbp_data.art_bewertungskreis_periode_2 AS A
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            bewertungskreis_id,
            MIN(gjmo_bis) AS gjmo_bis_
        FROM ${TEMP_TABLE}
        WHERE mbew_fg = 0
        GROUP BY
            art_id,
            mandant_id,
            bewertungskreis_id
    ) AS t1_2
        ON
            A.mandant_id = t1.mandant_id AND A.art_id = t1.art_id AND A.bewertungskreis_id = t1.bewertungskreis_id
            AND A.gjmo_bis >= t1.gjmo_bis_
);


/*
#------------------------------------------------------------------------------
# 6.) Korrigieren der Historie
#     (nur bei den MBEWH Daten erforderlich, MBEW MUSS bereits korrekt sein)
#------------------------------------------------------------------------------
*/


UPDATE
    ${TEMP_TABLE}
        AS
        art_bewertungskreis_periode_tmp_ec8f8e4c2cf45ac2945871a70a5fbc200
SET
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
FROM ${TEMP_TABLE}
WHERE mbew_fg = 0 AND SAFE.PARSE_DATE('%Y%m', CAST(gjmo AS STRING)) IS NOT NULL
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
    art_bewertungskreis_periode_tmp_ec8f8e4c2cf45ac2945871a70a5fbc200.mandant_id = d.mandant_id AND
    art_bewertungskreis_periode_tmp_ec8f8e4c2cf45ac2945871a70a5fbc200.art_id = d.art_id AND
    art_bewertungskreis_periode_tmp_ec8f8e4c2cf45ac2945871a70a5fbc200.bewertungskreis_id = d.bewertungskreis_id AND
    art_bewertungskreis_periode_tmp_ec8f8e4c2cf45ac2945871a70a5fbc200.gjmo_bis = d.gjmo_bis AND
    art_bewertungskreis_periode_tmp_ec8f8e4c2cf45ac2945871a70a5fbc200.gjmo <> d.gjmo_ab_;


/*
#------------------------------------------------------------------------------
# 7.) Aktualisieren der Artikel_2-Bewertungskreis Kombinationen in der Zieltabelle
#------------------------------------------------------------------------------
*/


INSERT INTO dbp_data.art_bewertungskreis_periode_2 (
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
FROM ${TEMP_TABLE});


UPDATE dbp_data.art_bewertungskreis_periode_2 SET
    gjmo = art_bewertungskreis_periode.gjmo_bis
WHERE gjmo = 190001;
