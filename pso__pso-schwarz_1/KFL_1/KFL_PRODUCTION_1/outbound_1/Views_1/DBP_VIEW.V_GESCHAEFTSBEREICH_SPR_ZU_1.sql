CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geschaeftsbereich_spr_zu_1 AS SELECT mandant_id,
 geschaeftsbereich_id,
 spr_id,
 geschaeftsbereich_bez,
 system_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geschaeftsbereich_spr_zu_1;