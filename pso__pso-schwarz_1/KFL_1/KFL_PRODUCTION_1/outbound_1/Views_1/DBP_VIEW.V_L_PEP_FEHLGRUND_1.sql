CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_pep_fehlgrund_1 AS SELECT idfehlgrund,
 pep_fehlgrund_id,
 pep_fehlgrund_bez_k,
 pep_fehlgrund_bez_l
FROM kfl_production_dbp_data.l_pep_fehlgrund_1;