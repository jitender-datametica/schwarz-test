CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_revisor AS SELECT revisor_id,
 revisor_anrede,
 revisor_nachname,
 revisor_vorname
FROM kfl_production_dbp_data.amx_revisor;