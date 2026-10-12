CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_l_lieferposition_typ (mandant_id, lief_pos_typ_id) AS SELECT
 mandant_id,
 lief_pos_typ_id
FROM kfl_production_dbp_view.v_flw_l_lieferpos_typ AS V01;