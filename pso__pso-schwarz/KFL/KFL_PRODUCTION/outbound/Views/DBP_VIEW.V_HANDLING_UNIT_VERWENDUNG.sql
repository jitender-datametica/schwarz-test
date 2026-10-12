CREATE OR REPLACE VIEW kfl_production_dbp_view.v_handling_unit_verwendung AS SELECT mandant_id,
 handle,
 beleg_typ,
 beleg_id,
 datzeit,
 richtung,
 td_update,
 td_insert
FROM kfl_production_dbp_data.handling_unit_verwendung;