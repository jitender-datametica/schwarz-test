CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_beleg_typ_2 (system_id, mandant_id, beleg_typ_id) AS SELECT 7
 AS system_id,
 mandant_id,
 beleg_typ_id
FROM kfl_production_dbp_view.v_l_beleg_typ_2
WHERE mandant_id = 1;