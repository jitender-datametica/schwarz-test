CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_l_auftragsart (mandant_id, auftragsart_id) AS SELECT
 mandant_id,
 auftragsart_id
FROM kfl_production_dbp_view.v_flw_l_auftragsart;