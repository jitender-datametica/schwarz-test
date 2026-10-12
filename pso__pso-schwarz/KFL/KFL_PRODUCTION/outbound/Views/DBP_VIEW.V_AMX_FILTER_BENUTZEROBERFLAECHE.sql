CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_filter_benutzeroberflaeche AS SELECT amx_filter_typ_id,
 platzhalter_id,
 platzhalter_string,
 amx_system_id,
 platzhalter_sort,
 td_insert,
 td_update
FROM kfl_production_dbp_data.amx_filter_benutzeroberflaeche;