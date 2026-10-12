CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_standort_typ AS SELECT mandant_id,
 standort_typ_id,
 standort_typ_bez
FROM kfl_production_dbp_data.l_standort_typ;