CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_cos_bonuspunkte (crm_konto_id, dat_verfall_bonuspunkte,
mandant_id, anz_bonuspunkte, einloesbare_bonuspunkte, verfallene_bonuspunkte, bonuspunkt_fg, dat_update) AS SELECT
 crm_konto_id,
 dat_verfall_bonuspunkte,
 mandant_id,
 anz_bonuspunkte,
  CASE
  WHEN dat_verfall_bonuspunkte >= CURRENT_DATE
  THEN SUM(anz_bonuspunkte)
  ELSE 0
  END AS einloesbare_bonuspunkte,
  CASE
  WHEN dat_verfall_bonuspunkte < CURRENT_DATE
  THEN SUM(anz_bonuspunkte)
  ELSE 0
  END AS verfallene_bonuspunkte,
  CASE
  WHEN CASE
    WHEN dat_verfall_bonuspunkte >= CURRENT_DATE
    THEN SUM(anz_bonuspunkte)
    ELSE 0
    END > 0
  THEN '1'
  ELSE '0'
  END AS bonuspunkt_fg,
 DATE(datzeit_update) AS dat_update
FROM kfl_production_dbp_view.v_cos_bonuspunkte
GROUP BY crm_konto_id,
 dat_verfall_bonuspunkte,
 mandant_id,
 anz_bonuspunkte,
 dat_update;