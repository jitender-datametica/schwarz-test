CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_gf_kunde_zu_1 (vkl_id, gf_id, vkl_name, mandant_id,
in_kunde_id, kunde_nr, kunde_name) AS SELECT V01.vkl_id,
 V01.gf_id,
 V01.vkl_name,
 V01.mandant_id,
 V03.flw_kunde_id AS in_kunde_id,
 COLLATE(LTRIM(COLLATE(V03.kunde_nr, ''), '0'), 'und:ci') AS kunde_nr,
 V03.kunde_name
FROM kfl_production_dbp_view.v_vkl_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V02 ON V01.vkl_id = V02.vkl_id AND V01.mandant_id = V02.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_flw_kunde_1 AS V03 ON V02.wup_id = V03.wup_id AND V02.mandant_id = V03.mandant_id
WHERE V01.mandant_id IN (1, 2);