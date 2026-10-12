CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_user_wrg_typ_2 (mandant_id, user_id, wrg_typ_id,
currency_type) AS SELECT V02.mandant_id,
 V01.user_id,
 V01.wrg_typ_id,
  CASE
  WHEN V01.wrg_typ_id = 1
  THEN 'Local Currency'
  WHEN V01.wrg_typ_id = 0 AND V01.berichtskurs_typ_id = 0
  THEN 'EURO - akt. Berichtskurs'
  WHEN V01.wrg_typ_id = 0 AND V01.berichtskurs_typ_id = 1
  THEN 'EURO - Berichtskurs je GJ'
  ELSE NULL
  END AS currency_type
FROM kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V02 ON TRUE;