CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_ewm_exception_2 AS SELECT mandant_id,
 lagernummer_id,
 ewm_exception_id,
 wup_id,
 nb_id,
 ewm_exc_kategorie_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_ewm_exception_2;