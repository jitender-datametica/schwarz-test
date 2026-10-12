CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_in_qual_meldung_det (mandant_id, qual_meldung_id,
qual_meldung_pos_id, problemcode_id) AS SELECT mandant_id,
 qual_meldung_id,
 qual_meldung_pos_id,
 problemcode_id
FROM kfl_production_dbp_view.v_in_qual_meldung_det AS V01;