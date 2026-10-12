CREATE OR REPLACE VIEW kfl_production_dbp_view.v_besch_faktura_kondit_columnar_2 AS SELECT mandant_id,
 faktura_beleg_id,
 faktura_beleg_pos_id,
 beleg_kondition_id,
 kondition_schl_id,
 kondition_wert,
 kappl
FROM kfl_production_dbp_data.besch_faktura_kondit_columnar_2;