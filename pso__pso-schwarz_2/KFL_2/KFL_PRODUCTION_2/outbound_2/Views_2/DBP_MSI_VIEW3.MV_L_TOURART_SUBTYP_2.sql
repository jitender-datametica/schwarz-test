CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_tourart_subtyp_2 (mandant_id, tourart_subtyp_id) AS SELECT
 mandant_id,
 tourart_subtyp_id
FROM kfl_production_dbp_view.v_l_tourart_subtyp_2;