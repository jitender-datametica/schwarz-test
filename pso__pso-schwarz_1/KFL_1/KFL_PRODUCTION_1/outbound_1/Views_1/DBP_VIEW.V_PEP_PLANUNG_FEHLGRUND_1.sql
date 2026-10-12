CREATE OR REPLACE VIEW kfl_production_dbp_view.v_pep_planung_fehlgrund_1 AS SELECT idpersonal,
 idcompany,
 dat,
 idfehlgrund
FROM kfl_production_dbp_data.pep_planung_fehlgrund_1;