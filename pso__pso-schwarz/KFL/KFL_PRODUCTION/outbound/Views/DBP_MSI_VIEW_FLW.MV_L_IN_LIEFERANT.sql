CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_lieferant (in_lief_id, mandant_id, lief_name, in_lief_nr
, gp_ort, lief_betreuer_id, werk_id, mandant_id_werk, in_lief_grp_id, in_lief_grp_mandant_id) AS SELECT DT1.flw_lief_id
 AS in_lief_id,
 DT1.mandant_id,
   TRIM(DT1.lief_name_1) || ' ' || TRIM(DT1.lief_name_2) AS lief_name,
 COLLATE(LTRIM(COLLATE(DT1.flw_lief_nr, ''), '0'), 'und:ci') AS in_lief_nr,
 DT1.gp_ort,
 DT1.lief_betreuer_id,
 DT1.werk_id_flw AS werk_id,
 DT1.mandant_id_werk,
  CASE
  WHEN DT1.mandant_id = 2 AND DT1.flw_lief_id_cz > 0
  THEN DT1.flw_lief_id_cz
  ELSE DT1.flw_lief_id
  END AS in_lief_grp_id,
  CASE
  WHEN DT1.mandant_id = 2 AND DT1.flw_lief_id_cz > 0
  THEN 1
  ELSE DT1.mandant_id
  END AS in_lief_grp_mandant_id
FROM kfl_production_dbp_view.v_flw_lieferant AS DT1
 INNER JOIN kfl_production_dbp_view.v_flw_lieferant_ekorg_zu AS DT2 ON DT1.mandant_id = DT2.mandant_id AND DT1.flw_lief_id
    = DT2.flw_lief_id
WHERE DT2.einkaufsorganisation_id IN (5000, 5013, 5014)
 AND DT1.mandant_id IN (1, 2);