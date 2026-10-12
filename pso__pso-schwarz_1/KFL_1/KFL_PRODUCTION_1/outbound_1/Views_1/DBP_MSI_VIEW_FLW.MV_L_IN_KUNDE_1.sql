CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_kunde_1 (in_kunde_id, mandant_id, kunde_nr, kunde_name,
kreistyp_gruppe_id, frueh_spaet_kz, kunde_land, kunde_plz, kunde_ort) AS SELECT V01.flw_kunde_id AS in_kunde_id,
 V01.mandant_id,
 COLLATE(LTRIM(COLLATE(V01.kunde_nr, ''), '0'), 'und:ci') AS kunde_nr,
 V01.kunde_name,
 COALESCE(V03.kreistyp_gruppe_id, '-1') AS kreistyp_gruppe_id,
 V01.frueh_spaet_kz,
 V01.kunde_land,
 V01.kunde_plz,
 V01.kunde_ort
FROM kfl_production_dbp_view.v_flw_kunde_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_kunde_vkorg_vw_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.flw_kunde_id
    = V02.flw_kunde_id
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.wup_id = V03.wup_id
WHERE V02.flw_vw_id IN (10, 20, 25)
GROUP BY in_kunde_id,
 V01.mandant_id,
 kunde_nr,
 V01.kunde_name,
 kreistyp_gruppe_id,
 V01.frueh_spaet_kz,
 V01.kunde_land,
 V01.kunde_plz,
 V01.kunde_ort;