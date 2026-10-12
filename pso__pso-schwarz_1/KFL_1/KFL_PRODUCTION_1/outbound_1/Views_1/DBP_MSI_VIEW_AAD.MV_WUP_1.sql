CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_wup_1 (wup_id, nb_id, mandant_id, wup_standort, dat_von, vf_id,
vkl_id, hl_id, dat_bis, dat_eroeffnung, breitengrad, laengengrad, vs_id, land_id) AS SELECT wup_id,
 nb_id,
 mandant_id,
  CASE
  WHEN wup_id = 0
  THEN land_id || ' (unbekannt)'
  ELSE wup_standort
  END AS wup_standort,
 dat_von,
 vf_id,
 vkl_id,
 hl_id,
 dat_bis,
 dat_eroeffnung,
 breitengrad,
 laengengrad,
 vs_id,
 land_id
FROM kfl_production_dbp_view.v_wup_1 AS V01
WHERE (nb_id = 0 AND dat_von < CURRENT_DATE AND dat_eroeffnung < CURRENT_DATE OR wup_id = 0)
 AND wup_id = aktuell_wup_id;