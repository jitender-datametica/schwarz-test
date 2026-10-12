CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_ma_variable (mandant_id, buchungskreis_id, kjmo, def_vollzeit_stunden
, shr_freigabe_fg) AS SELECT mandant_id,
 buchungskreis_id,
 kjmo,
 def_vollzeit_stunden,
 shr_freigabe_fg
FROM kfl_production_dbp_data.l_ma_variable;