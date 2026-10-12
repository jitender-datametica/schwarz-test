CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_l_bestellart_1 (mandant_id, bestellart_id, bestell_typ_id)
AS SELECT mandant_id,
 bestellart_id,
 bestell_typ_id
FROM kfl_production_dbp_view.v_flw_l_bestellart_1;