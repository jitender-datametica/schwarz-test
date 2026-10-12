CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_qual_meldung_det_1 (mandant_id, qual_meldung_id,
qual_meldung_pos_id, katalogart_id, codegruppe_id, pruefcode_id, fehlgrund_id, fehlerklasse_id, kopf_fehlerpunkte,
fehlgrund_gefiltert_bez) AS SELECT V01.mandant_id,
 V01.qual_meldung_id,
 V01.qual_meldung_pos_id,
 V01.katalogart_id,
 V01.codegruppe_id,
 V01.pruefcode_id,
 V01.fehlgrund_id,
 V01.fehlerklasse_id,
 CAST(IFNULL(V03.fehlerklasse_kennzahl_ber, 0) AS BIGNUMERIC) AS kopf_fehlerpunkte,
  CASE
  WHEN V02.fehlgrund_id IS NULL
  THEN ''
  ELSE V01.fehlgrund_id
  END AS fehlgrund_gefiltert_bez
FROM kfl_production_dbp_view.v_flw_qual_meldung_det_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_flw_l_fehlgrund_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.fehlgrund_id =
   V02.fehlgrund_id
 LEFT JOIN kfl_production_dbp_msi_view_flw.mv_l_flw_l_fehlerklasse_qual_1 AS V03 ON V01.fehlerklasse_id = V03.fehlerklasse_id
    AND V01.mandant_id = V03.mandant_id;