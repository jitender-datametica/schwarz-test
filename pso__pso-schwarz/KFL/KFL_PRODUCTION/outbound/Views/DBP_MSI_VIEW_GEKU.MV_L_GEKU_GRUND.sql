CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_geku_grund (geku_grund_uid, geku_grund_id, geku_bereich_uid
) AS SELECT geku_grund_uid,
 geku_grund_id,
 geku_bereich_uid
FROM kfl_production_dbp_view.v_l_geku_grund
WHERE geku_grund_uid IN (SELECT geku_grund_uid
   FROM kfl_production_dbp_view.v_l_geku_dwh_artikel);