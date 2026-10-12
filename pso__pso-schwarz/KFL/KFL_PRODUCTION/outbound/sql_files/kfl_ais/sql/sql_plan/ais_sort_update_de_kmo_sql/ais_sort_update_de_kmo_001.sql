CREATE OR REPLACE TEMPORARY TABLE _art_nielsen AS
SELECT *
FROM dbp_data.art_nielsen
WHERE dat_bis = DATE '9999-12-31';


UPDATE dbp_data.art_nielsen_wug_zu_pflege SET
    art_nielsen_bez = b.art_nielsen_bez
FROM `_art_nielsen` AS b
WHERE
    art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id
    AND art_nielsen_wug_zu_pflege.art_nielsen_id = b.art_nielsen_id
    AND art_nielsen_wug_zu_pflege.art_nielsen_bez <> b.art_nielsen_bez;


UPDATE dbp_data.art_nielsen_wug_zu_pflege SET
    nielsen_abteilung_bez = b.nielsen_abteilung_bez
FROM `_art_nielsen` AS b
WHERE
    art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id
    AND art_nielsen_wug_zu_pflege.art_nielsen_id = b.art_nielsen_id
    AND art_nielsen_wug_zu_pflege.nielsen_abteilung_bez <> b.nielsen_abteilung_bez;


UPDATE dbp_data.art_nielsen_wug_zu_pflege SET
    nielsen_wg_bez = b.nielsen_wg_bez
FROM `_art_nielsen` AS b
WHERE
    art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id
    AND art_nielsen_wug_zu_pflege.art_nielsen_id = b.art_nielsen_id
    AND art_nielsen_wug_zu_pflege.nielsen_wg_bez <> b.nielsen_wg_bez;


UPDATE dbp_data.art_nielsen_wug_zu_pflege SET
    nielsen_uwg1_bez = b.nielsen_uwg1_bez
FROM `_art_nielsen` AS b
WHERE
    art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id
    AND art_nielsen_wug_zu_pflege.art_nielsen_id = b.art_nielsen_id
    AND art_nielsen_wug_zu_pflege.nielsen_uwg1_bez <> b.nielsen_uwg1_bez;


UPDATE dbp_data.art_nielsen_wug_zu_pflege SET
    nielsen_uwg2_bez = b.nielsen_uwg2_bez
FROM `_art_nielsen` AS b
WHERE
    art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id
    AND art_nielsen_wug_zu_pflege.art_nielsen_id = b.art_nielsen_id
    AND art_nielsen_wug_zu_pflege.nielsen_uwg2_bez <> b.nielsen_uwg2_bez;


UPDATE dbp_data.sortiment_leistung AS sortiment_leistung0 SET
    kl_art_id = b.kl_art_id FROM (
    SELECT
        matching_id,
        art_id,
        kjwo_update,
        mandant_id,
        MAX(LPAD(kl_art_id, 8, '0')) AS kl_art_id
    FROM dbp_data.sortiment_leistung
    WHERE
        art_id IS NOT NULL
        AND INSTR(kl_art_id, ',') = 0
        AND kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.art_kl_preislage_zu_per
        )
    GROUP BY
        matching_id,
        art_id,
        kjwo_update,
        mandant_id
) AS b
WHERE
    sortiment_leistung0.mandant_id = b.mandant_id
    AND sortiment_leistung0.art_id = b.art_id
    AND sortiment_leistung0.matching_id
    = b.matching_id AND sortiment_leistung0.kjwo_update = b.kjwo_update;


CREATE OR REPLACE TEMPORARY TABLE _art_bez1_1 AS
SELECT
    c.status,
    A.mandant_id,
    A.kjwo_update,
    A.matching_id,
    CAST(A.art_bez AS STRING) AS art_bez_alt,
    CAST(B.art_bez AS STRING) AS art_bez_neu
FROM dbp_data.sortiment_leistung AS A
INNER JOIN dbp_data.art_spr_zu AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.spr_id
        = 22
INNER JOIN (
    SELECT
        art_matching_id,
        status
    FROM dbp_etl.art_matching_nielsen_per
    GROUP BY
        art_matching_id,
        status
) AS c ON A.matching_id = c.art_matching_id
WHERE
    (A.art_bez <> B.art_bez OR A.art_bez IS NULL AND B.art_bez IS NOT NULL)
    AND A.mandant_id = 1
    AND A.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = 1
    )
    AND c.status <> 'G';


INSERT INTO `_art_bez1_1` (
    status, mandant_id, kjwo_update, matching_id, art_bez_alt, art_bez_neu
)
(
    SELECT
        'G' AS status,
        A.mandant_id,
        A.kjwo_update,
        A.matching_id,
        A.art_bez AS art_bez_alt,
        c.art_gruppe_bez AS art_bez_neu
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.art_matching_id,
            MAX(C.art_gruppe_bez) AS art_gruppe_bez
        FROM dbp_etl.art_matching_nielsen_per AS A0
        INNER JOIN dbp_data.art_gruppe_art_zu AS B ON A0.art_id = B.art_id
        INNER JOIN
            dbp_data.art_gruppe AS C
            ON B.art_gruppe_id = C.art_gruppe_id
        WHERE A0.status = 'G'
        GROUP BY A0.art_matching_id
    ) AS c ON A.matching_id = c.art_matching_id
    WHERE
        (
            A.art_bez <> c.art_gruppe_bez
            OR A.art_bez IS NULL AND c.art_gruppe_bez IS NOT NULL
        )
        AND A.mandant_id = 1
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update)
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id = 1
        )
);


UPDATE dbp_data.sortiment_leistung SET
    art_bez = b.art_bez_neu FROM (
    SELECT
        mandant_id,
        kjwo_update,
        matching_id,
        MAX(art_bez_alt) AS art_bez_alt,
        MAX(art_bez_neu) AS art_bez_neu
    FROM `_art_bez1_1`
    GROUP BY
        mandant_id,
        kjwo_update,
        matching_id
) AS b
WHERE
    sortiment_leistung.matching_id = b.matching_id
    AND sortiment_leistung.mandant_id = 1
    AND sortiment_leistung.kjwo_update
    = b.kjwo_update AND COALESCE(sortiment_leistung.art_bez, 'murks') = COALESCE(b.art_bez_alt, 'murks');
