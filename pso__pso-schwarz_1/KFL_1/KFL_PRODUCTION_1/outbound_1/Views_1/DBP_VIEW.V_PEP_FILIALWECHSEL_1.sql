CREATE OR REPLACE VIEW kfl_production_dbp_view.v_pep_filialwechsel_1 AS SELECT idpersonal,
 idcompany,
 dat_von,
 idcompany_nach,
 idabteilungen,
 dat_bis
FROM kfl_production_dbp_data.pep_filialwechsel_1;