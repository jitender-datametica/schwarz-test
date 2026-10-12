CREATE OR REPLACE VIEW kfl_production_dbp_view.v_quartal_gj AS SELECT gjqu,
 akt_gjqu,
 akt_gjqu_komplett,
 gj,
 akt_gj,
 akt_gj_komplett,
 gjhj
FROM kfl_production_dbp_data.quartal_gj;