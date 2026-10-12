CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tp_objekt_status_per AS SELECT mandant_id,
 tp_objekt_nr,
 tp_objekt_status_id,
 dat_von,
 dat_bis,
 tp_objekt_id,
 tp_objekt_status_fg
FROM kfl_production_dbp_data.tp_objekt_status_per;