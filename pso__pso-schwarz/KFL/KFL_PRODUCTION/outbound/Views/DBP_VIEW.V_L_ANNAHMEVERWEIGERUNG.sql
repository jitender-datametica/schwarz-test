CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_annahmeverweigerung AS SELECT mandant_id,
 annahmeverweigerung_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_annahmeverweigerung;