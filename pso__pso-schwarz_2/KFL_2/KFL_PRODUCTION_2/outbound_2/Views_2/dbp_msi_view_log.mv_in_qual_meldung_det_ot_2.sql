CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_qual_meldung_det_ot_2 (mandant_id, qual_meldung_id,
qual_meldung_pos_id, katalogart_id_ot, codegruppe_id_ot, pruefcode_id_ot) AS SELECT IN_Q_M_DET.mandant_id,
 IN_Q_M_DET.qual_meldung_id,
 IN_Q_M_DET.qual_meldung_pos_id,
 COALESCE(IN_Q_M_DET.katalogart_id_ot, '0') AS katalogart_id_ot,
 COALESCE(IN_Q_M_DET.codegruppe_id_ot, '-1') AS codegruppe_id_ot,
 COALESCE(IN_Q_M_DET.pruefcode_id_ot, '-1') AS pruefcode_id_ot
FROM kfl_production_dbp_view.v_in_qual_meldung_det_2 AS IN_Q_M_DET
 INNER JOIN (SELECT mandant_id,
   qual_meldung_id,
   MIN(qual_meldung_pos_id) AS qual_meldung_pos_id
  FROM kfl_production_dbp_view.v_in_qual_meldung_det_2
  GROUP BY mandant_id,
   qual_meldung_id) AS qm_pos ON IN_Q_M_DET.qual_meldung_pos_id = qm_pos.qual_meldung_pos_id AND IN_Q_M_DET.qual_meldung_id
     = qm_pos.qual_meldung_id AND IN_Q_M_DET.mandant_id = qm_pos.mandant_id
WHERE CAST(IN_Q_M_DET.problemcode_id AS FLOAT64) <> 0;