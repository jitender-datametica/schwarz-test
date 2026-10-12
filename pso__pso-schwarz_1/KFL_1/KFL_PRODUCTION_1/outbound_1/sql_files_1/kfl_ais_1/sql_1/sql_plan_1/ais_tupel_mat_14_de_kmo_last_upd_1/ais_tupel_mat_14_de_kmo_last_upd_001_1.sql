--final updates with no impact on testing


CREATE OR REPLACE TEMPORARY TABLE _nielsen_group AS
SELECT
    mandant_id,
    art_matching_id
FROM dbp_etl.art_matching_nielsen_per_kmo_1
GROUP BY
    mandant_id,
    art_matching_id
HAVING COUNT(DISTINCT art_id) = 1 AND COUNT(*) > 1;


CREATE OR REPLACE TEMPORARY TABLE _mgtin_update AS
SELECT
    mandant_id,
    art_matching_id,
    STRING_AGG(DISTINCT CAST(gtin_id AS STRING), ',' ORDER BY CAST(gtin_id AS STRING)) AS kombi_gtin_id  --pe_review
FROM dbp_etl.art_matching_nielsen_per_kmo_1
WHERE (
    mandant_id, art_matching_id) IN (
    SELECT (mandant_id, art_matching_id)
    FROM (
        SELECT DISTINCT *
        FROM `_nielsen_group`
        WHERE art_matching_nielsen_per_kmo.art_id = -1
    ) AS t2
)
GROUP BY
    mandant_id,
    art_matching_id;


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    nielsen_gtin = b.kombi_gtin_id
FROM `_mgtin_update` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.art_matching_id AND tupel_mat_etl.a500_kjwo_update
    IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
    );


UPDATE dbp_msi_data.tupel_mat_quarantaene_1 SET
    nielsen_gtin = b.kombi_gtin_id
FROM `_mgtin_update` AS b
WHERE
    tupel_mat_quarantaene.mandant_id = b.mandant_id AND tupel_mat_quarantaene.matching_id = b.art_matching_id AND
    tupel_mat_quarantaene.a500_kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
    );


DELETE FROM dbp_etl.art_matching_nielsen_per_1
WHERE (
    mandant_id, art_matching_id, kjwo_update) IN (
    SELECT (mandant_id, art_matching_id, kjwo_update)
    FROM dbp_etl.art_matching_nielsen_per_olds_1
);


DELETE FROM dbp_etl.art_matching_nielsen_per_kmo_1
WHERE (
    mandant_id, art_matching_id, kjwo_update) IN (
    SELECT (mandant_id, art_matching_id, kjwo_update)
    FROM dbp_etl.art_matching_nielsen_per_kmo_olds_1
);


INSERT INTO dbp_etl.art_matching_nielsen_per_1
(
    SELECT *
    FROM dbp_etl.art_matching_nielsen_per_olds_1
);


INSERT INTO dbp_etl.art_matching_nielsen_per_kmo_1
(SELECT
    mandant_id,
    art_matching_id,
    art_id,
    art_nielsen_id,
    gtin_id,
    kl_art_kat_id,
    kl_wg_id,
    kl_owg_id,
    kl_uwg_id,
    ROUND(CAST(umrech_faktor AS NUMERIC), 5) AS umrech_faktor,
    status_1,
    list_kz,
    komponente_fg,
    kjwo_update,
    td_update,
    td_insert
FROM dbp_etl.art_matching_nielsen_per_kmo_olds_1);
