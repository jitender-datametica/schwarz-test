CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_qual_meldung_det_1 AS SELECT mandant_id,
 qual_meldung_id,
 qual_meldung_pos_id,
 problemcode_id,
 katalogart_id_pc,
 codegruppe_id_pc,
 katalogart_id_ot,
 codegruppe_id_ot,
 pruefcode_id_ot
FROM kfl_production_dbp_data.in_qual_meldung_det_1;