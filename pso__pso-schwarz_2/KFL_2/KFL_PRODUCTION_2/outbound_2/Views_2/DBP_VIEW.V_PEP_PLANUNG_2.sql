CREATE OR REPLACE VIEW kfl_production_dbp_view.v_pep_planung_2 AS SELECT idpersonal,
 idcompany,
 dat,
 plan_fg,
 nettozeit,
 pzw_fg
FROM kfl_production_dbp_data.pep_planung_2;