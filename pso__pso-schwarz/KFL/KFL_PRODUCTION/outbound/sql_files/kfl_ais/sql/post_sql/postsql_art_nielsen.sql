TRUNCATE TABLE dbp_etl_process.art_nielsen_gtin_zu;


CREATE OR REPLACE TEMPORARY TABLE _art_nielsen_multi_gtin AS
SELECT *
FROM dbp_data.art_nielsen
WHERE
    gtin_ref_id IS NOT NULL
    AND gtin_ref_id LIKE '%,%'
    AND dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _art_nielsen_norm AS
SELECT DISTINCT
    `_art_nielsen_multi_gtin`.mandant_id,
    `_art_nielsen_multi_gtin`.art_nielsen_id,
    `_art_nielsen_multi_gtin`.art_nielsen_tag,
    `_art_nielsen_multi_gtin`.art_nielsen_bez,
    `_art_nielsen_multi_gtin`.hersteller_bez,
    `_art_nielsen_multi_gtin`.gtin_id,
    `_art_nielsen_multi_gtin`.inhalt_menge,
    `_art_nielsen_multi_gtin`.inhalt_einheit,
    `_art_nielsen_multi_gtin`.nielsen_abteilung_bez,
    `_art_nielsen_multi_gtin`.nielsen_wg_bez,
    `_art_nielsen_multi_gtin`.nielsen_uwg1_bez,
    `_art_nielsen_multi_gtin`.nielsen_uwg2_bez,
    `_art_nielsen_multi_gtin`.td_update,
    `_art_nielsen_multi_gtin`.td_insert,
    `_art_nielsen_multi_gtin`.marke_bez,
    `_art_nielsen_multi_gtin`.bio_organic_kz,
    `_art_nielsen_multi_gtin`.veggy_split_kz,
    `_art_nielsen_multi_gtin`.laktosefrei_kz,
    `_art_nielsen_multi_gtin`.glutenfrei_kz,
    `_art_nielsen_multi_gtin`.duft_geschmack_bez,
    `_art_nielsen_multi_gtin`.nielsen_vorschl_wg_id,
    `_art_nielsen_multi_gtin`.nielsen_vorschl_wug_id,
    `_art_nielsen_multi_gtin`.datzeit_letzte_eintragung_nielsen_vorschl,
    STRING(C.value) AS gtin_ref_id --PE-Review
FROM `_art_nielsen_multi_gtin`
INNER JOIN UNNEST(UDF_SCHEMA.flatten(
    PARSE_JSON(TO_JSON_STRING(SPLIT(`_ART_NIELSEN_MULTI_GTIN`.GTIN_REF_ID, ','))), '', --PE-Review
    FALSE, FALSE, 'both'
)) AS C ON TRUE;


DELETE FROM `_art_nielsen_norm`
WHERE ROUND(SAFE_CAST(gtin_ref_id AS BIGNUMERIC), 0) IS NULL;


INSERT INTO dbp_etl_process.art_nielsen_gtin_zu (
    mandant_id, art_nielsen_id, art_nielsen_tag,
    art_nielsen_bez, hersteller_bez, gtin_id, inhalt_menge, inhalt_einheit, nielsen_abteilung_bez, nielsen_wg_bez,
    nielsen_uwg1_bez, nielsen_uwg2_bez, gtin_ref_id, marke_bez, bio_organic_kz, veggy_split_kz, laktosefrei_kz,
    glutenfrei_kz, duft_geschmack_bez, nielsen_vorschl_wg_id, nielsen_vorschl_wug_id,
    datzeit_letzte_eintragung_nielsen_vorschl
)
(SELECT
    mandant_id,
    art_nielsen_id,
    art_nielsen_tag,
    art_nielsen_bez,
    hersteller_bez,
    gtin_id,
    inhalt_menge,
    inhalt_einheit,
    nielsen_abteilung_bez,
    nielsen_wg_bez,
    nielsen_uwg1_bez,
    nielsen_uwg2_bez,
    CAST(gtin_ref_id AS INTEGER) AS gtin_ref_id,
    marke_bez,
    bio_organic_kz,
    veggy_split_kz,
    laktosefrei_kz,
    glutenfrei_kz,
    duft_geschmack_bez,
    nielsen_vorschl_wg_id,
    nielsen_vorschl_wug_id,
    datzeit_letzte_eintragung_nielsen_vorschl
FROM `_art_nielsen_norm`
WHERE (
    mandant_id, art_nielsen_id, CAST(gtin_ref_id AS INTEGER)) NOT IN (
    SELECT (mandant_id, art_nielsen_id, gtin_id)
    FROM dbp_data.art_nielsen
    WHERE dat_bis = DATE '9999-12-31'
));
