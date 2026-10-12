CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_revisor (revisor_id, revisor_anrede, revisor_nachname,
revisor_vorname, revisor_name) AS SELECT revisor_id,
 revisor_anrede,
 revisor_nachname,
 revisor_vorname,
     TRIM(revisor_anrede) || ' ' || TRIM(revisor_vorname) || ' ' || TRIM(revisor_nachname) AS revisor_name
FROM kfl_production_dbp_view.v_amx_revisor;