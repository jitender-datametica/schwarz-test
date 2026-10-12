CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_ma_variable AS SELECT mandant_id,
 buchungskreis_id,
 kjmo,
 def_vollzeit_stunden,
 shr_freigabe_fg
FROM kfl_production_dbp_data.l_ma_variable;