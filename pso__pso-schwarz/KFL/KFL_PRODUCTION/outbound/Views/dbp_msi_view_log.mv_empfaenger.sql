CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_empfaenger AS SELECT wup_id AS empfaenger_id,
 nb_id,
 mandant_id AS mandant_id_empfaenger,
 dat_von,
  CASE
  WHEN nb_id = - 1
  THEN '---'
  ELSE wup_standort
  END AS empfaenger_bez,
 dat_bis,
 buchungskreis_id,
 verkaufsorganisation_id,
 wup_typ_id,
 breitengrad,
 laengengrad,
 vkl_id,
 vs_id
FROM kfl_production_dbp_view.v_wup
WHERE nb_id IN (2, 0, - 111) AND wup_id > 0
 OR nb_id = - 1 AND wup_id = 0;