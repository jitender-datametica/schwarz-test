CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_vz_2 (vz_wup_id, mandant_id, nb_id, wup_typ_id, wup_standort, zu_id
) AS SELECT V01.wup_id AS vz_wup_id,
 V01.mandant_id,
 V01.nb_id,
 V01.wup_typ_id,
  CASE
  WHEN V01.wup_id = - 1
  THEN 'ZENTRAL GENERELL'
  WHEN V01.wup_id = - 2
  THEN 'DEZENTRAL'
  ELSE V01.wup_standort
  END AS wup_standort,
 ROUND(CAST(V02.zu_id AS BIGNUMERIC), 0) AS zu_id
FROM kfl_production_dbp_view.v_wup_2 AS V01
 LEFT JOIN kfl_production_dbp_msi_view2.mv_vz_zuordnung_2 AS V02 ON V01.vz_wup_id = V02.wup_id
WHERE V01.wup_typ_id IN (- 1, 2)
 AND V01.mandant_id = 1;