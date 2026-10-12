CREATE TEMPORARY TABLE IF NOT EXISTS _gp_unique AS
SELECT
    mandant_id,
    gp_id,
    einkaufsorganisation_id,
    dat_von,
    dat_bis,
    anlieferung_id,
    gp_name,
    gp_strasse,
    gp_plz,
    gp_ort,
    land_id,
    hgp_id,
    zek_id,
    lieferzeit,
    zahlungsziel_id,
    agb_id,
    iso_id,
    eigenverpackung_id,
    eigenmarke_id,
    audit_id,
    audit_dat,
    herst_fg,
    zahlart_id,
    retour_sperr_fg,
    system_id,
    gp_branche_id,
    wewa_fg,
    loesch_fg,
    region_id,
    min_pal_faktor_lkw,
    gln_bbnr,
    gln_bsnr,
    gln_bubkz,
    breitengrad,
    laengengrad,
    gp_name_lat,
    ivn,
    isd_fg,
    markant_id,
    td_update,
    td_insert,
    CASE
        WHEN
            mandant_id = 2 AND einkaufsorganisation_id = 1000 OR mandant_id = 3 AND einkaufsorganisation_id = 1060 OR
            mandant_id = 4 AND einkaufsorganisation_id = 1040 OR mandant_id = 5 AND einkaufsorganisation_id = 1020 OR
            mandant_id = 6 AND einkaufsorganisation_id = 1030 OR mandant_id = 7 AND einkaufsorganisation_id = 1070 OR
            mandant_id = 8 AND einkaufsorganisation_id = 1090
            THEN 0
        ELSE 1
    END AS sort_fld
FROM ${TEMP_TABLE} AS A
QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, gp_id ORDER BY CASE
    WHEN
        mandant_id = 2 AND einkaufsorganisation_id = 1000 OR mandant_id = 3 AND einkaufsorganisation_id = 1060 OR
        mandant_id = 4 AND einkaufsorganisation_id = 1040 OR mandant_id = 5 AND einkaufsorganisation_id = 1020 OR
        mandant_id = 6 AND einkaufsorganisation_id = 1030 OR mandant_id = 7 AND einkaufsorganisation_id = 1070 OR
        mandant_id = 8 AND einkaufsorganisation_id = 1090
        THEN 0
    ELSE 1
END IS NULL, CASE
    WHEN
        mandant_id = 2 AND einkaufsorganisation_id = 1000 OR mandant_id = 3 AND einkaufsorganisation_id = 1060 OR
        mandant_id = 4 AND einkaufsorganisation_id = 1040 OR mandant_id = 5 AND einkaufsorganisation_id = 1020 OR
        mandant_id = 6 AND einkaufsorganisation_id = 1030 OR mandant_id = 7 AND einkaufsorganisation_id = 1070 OR
        mandant_id = 8 AND einkaufsorganisation_id = 1090
        THEN 0
    ELSE 1
END, einkaufsorganisation_id IS NULL, einkaufsorganisation_id)) = 1;


UPDATE dbp_data.gp SET
    min_pal_faktor_lkw = t1.`_min_pal_faktor_lkw`,
    zahlungsziel_id = t1.`_zahlungsziel_id`,
    zek_id = t1.`_zek_id`,
    einkaufsorganisation_id = t1.`_einkaufsorganisation_id`,
    lieferzeit = t1.`_lieferzeit`,
    hgp_id = t1.`_hgp_id` FROM (SELECT
    mandant_id AS `_mandant_id`,
    gp_id AS `_gp_id`,
    einkaufsorganisation_id AS `_einkaufsorganisation_id`,
    hgp_id AS `_hgp_id`,
    zek_id AS `_zek_id`,
    lieferzeit AS `_lieferzeit`,
    zahlungsziel_id AS `_zahlungsziel_id`,
    min_pal_faktor_lkw AS `_min_pal_faktor_lkw`
FROM `_gp_unique`) AS t1
WHERE gp.mandant_id = t1.`_mandant_id` AND gp.gp_id = t1.`_gp_id`;


CREATE TEMPORARY TABLE IF NOT EXISTS _md_killing AS
SELECT gp_id
FROM `_gp_unique`
WHERE
    mandant_id IN (4, 7)
    AND gp_id <> 6100
GROUP BY gp_id
HAVING COUNT(*) > 1;


DELETE FROM dbp_data.gp
WHERE mandant_id = 7 AND gp_id IN (
    SELECT gp_id
    FROM `_md_killing`
);
