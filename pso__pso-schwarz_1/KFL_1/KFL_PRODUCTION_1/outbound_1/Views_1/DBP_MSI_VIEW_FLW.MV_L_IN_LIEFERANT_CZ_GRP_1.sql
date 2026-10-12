CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_lieferant_cz_grp_1 (in_lief_grp_id, in_lief_grp_mandant_id
, lief_name, in_lief_nr, gp_ort, lief_betreuer_id) AS SELECT V00.flw_lief_id AS in_lief_grp_id,
 V00.mandant_id AS in_lief_grp_mandant_id,
   TRIM(V00.lief_name_1) || ' ' || TRIM(V00.lief_name_2) AS lief_name,
 COLLATE(LTRIM(COLLATE(V00.flw_lief_nr, ''), '0'), 'und:ci') AS in_lief_nr,
 V00.gp_ort,
 V00.lief_betreuer_id
FROM kfl_production_dbp_view.v_flw_lieferant_1 AS V00
 INNER JOIN kfl_production_dbp_view.v_flw_lieferant_ekorg_zu_1 AS DT2 ON V00.mandant_id = DT2.mandant_id AND V00.flw_lief_id
     = DT2.flw_lief_id AND DT2.einkaufsorganisation_id IN (5000, 5013, 5014)
WHERE V00.flw_lief_id_cz = 0
 OR V00.mandant_id = 1 AND V00.flw_lief_id_cz > 0;