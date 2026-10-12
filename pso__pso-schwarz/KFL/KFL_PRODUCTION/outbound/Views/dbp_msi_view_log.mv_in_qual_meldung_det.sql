CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_qual_meldung_det (mandant_id, qual_meldung_id,
qual_meldung_pos_id, problemcode_id, katalogart_id_pc, codegruppe_id_pc, katalogart_id_ot, codegruppe_id_ot,
pruefcode_id_ot) AS SELECT mandant_id,
 qual_meldung_id,
 qual_meldung_pos_id,
 problemcode_id,
 COALESCE(katalogart_id_pc, '0') AS katalogart_id_pc,
 COALESCE(codegruppe_id_pc, '-1') AS codegruppe_id_pc,
 COALESCE(katalogart_id_ot, '0') AS katalogart_id_ot,
 COALESCE(codegruppe_id_ot, '-1') AS codegruppe_id_ot,
 COALESCE(pruefcode_id_ot, '-1') AS pruefcode_id_ot
FROM kfl_production_dbp_view.v_in_qual_meldung_det;