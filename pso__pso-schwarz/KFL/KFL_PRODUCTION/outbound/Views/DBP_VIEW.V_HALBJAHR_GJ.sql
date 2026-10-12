CREATE OR REPLACE VIEW kfl_production_dbp_view.v_halbjahr_gj AS SELECT gjhj,
 akt_gjhj,
 akt_gjhj_komplett,
 gj
FROM kfl_production_dbp_data.halbjahr_gj;