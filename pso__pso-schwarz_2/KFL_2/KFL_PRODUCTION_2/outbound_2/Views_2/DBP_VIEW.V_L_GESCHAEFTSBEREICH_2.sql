CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geschaeftsbereich_2 AS SELECT mandant_id,
 geschaeftsbereich_id,
 system_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_geschaeftsbereich_2;