CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_f_besch_faktura_kondit_1 (mandant_id, faktura_beleg_id,
faktura_beleg_pos_id, beleg_kondition_id, kondition_schl_id, kondition_wert, kappl) AS SELECT V01.mandant_id,
 V01.faktura_beleg_id,
 V01.faktura_beleg_pos_id,
 V01.beleg_kondition_id,
 V01.kondition_schl_id,
  CASE
  WHEN V200.wrg_typ_id = 1
  THEN V01.kondition_wert
  ELSE TRUNC(CAST(V01.kondition_wert / V02.kurrf AS BIGNUMERIC))
  END AS kondition_wert,
 V01.kappl
FROM kfl_production_dbp_view.v_besch_faktura_kondit_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_besch_faktura_kmo_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.faktura_beleg_id
    = V02.faktura_beleg_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE;