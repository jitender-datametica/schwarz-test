CREATE OR REPLACE VIEW kfl_production_dbp_view.v_pep_personal_1 AS SELECT idpersonal,
 dat_austritt,
 pep_ma_name,
 pep_ma_vorname,
 geschlecht_id
FROM kfl_production_dbp_data.pep_personal_1;