CREATE OR REPLACE VIEW kfl_production_dbp_view.v_besch_faktura_kondit AS SELECT mandant_id,
 faktura_beleg_id,
 faktura_beleg_pos_id,
 beleg_kondition_id,
 kondition_schl_id,
 wrg_id,
 kondition_wert,
 kappl
FROM kfl_production_dbp_data.besch_faktura_kondit;