CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_messpunkt AS SELECT mandant_id,
 messpunkt_id,
 tp_objekt_id,
 tp_objekt_nr
FROM kfl_production_dbp_data.in_messpunkt;