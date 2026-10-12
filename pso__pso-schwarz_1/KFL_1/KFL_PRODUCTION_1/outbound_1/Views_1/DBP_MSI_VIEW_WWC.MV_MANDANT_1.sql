CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_mandant_1 (mandant_id, mandant_bez, mandant_kbez, wrg_id) AS
SELECT V01.mandant_id,
 V01.mandant_bez,
 V01.mandant_kbez,
  CASE
  WHEN V02.wrg_typ_id = 1
  THEN V01.default_wrg
  ELSE 'EUR'
  END AS wrg_id
FROM kfl_production_dbp_view.v_mandant_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V02 ON TRUE;