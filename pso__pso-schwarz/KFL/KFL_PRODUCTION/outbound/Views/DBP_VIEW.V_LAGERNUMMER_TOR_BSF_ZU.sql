CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lagernummer_tor_bsf_zu AS SELECT mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 tor_id,
 bsf_gruppe_id,
 bsf_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.lagernummer_tor_bsf_zu;