CREATE OR REPLACE VIEW kfl_production_dbp_view.v_pep_filiale AS SELECT idcompany,
 wup_id,
 nb_id,
 mandant_id
FROM kfl_production_dbp_data.pep_filiale;