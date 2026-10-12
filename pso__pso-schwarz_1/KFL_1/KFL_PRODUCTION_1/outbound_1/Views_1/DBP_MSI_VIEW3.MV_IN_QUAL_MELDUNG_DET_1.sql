CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_in_qual_meldung_det_1 AS SELECT mandant_id,
 qual_meldung_id,
 qual_meldung_pos_id,
 problemcode_id
FROM kfl_production_dbp_view.v_in_qual_meldung_det_1 AS V01;