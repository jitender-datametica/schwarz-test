CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_cos_bonuspunkte_transaction_1 (crm_konto_id,
dat_bonuspunkte_transaktion, mandant_id, bonuspunkte_transaktion_id, anz_bonuspunkte_transaktion,
eingeloeste_bonuspunkte_fg, bonuspunkte_transaktion_richtung) AS SELECT crm_konto_id,
 DATE(datzeit_bonuspunkte_transaktion) AS dat_bonuspunkte_transaktion,
 mandant_id,
 bonuspunkte_transaktion_id,
 SUM(anz_bonuspunkte_transaktion) AS anz_bonuspunkte_transaktion,
  CASE
  WHEN bonuspunkte_transaktion_richtung = 2
  THEN '1'
  ELSE NULL
  END AS eingeloeste_bonuspunkte_fg,
 bonuspunkte_transaktion_richtung
FROM kfl_production_dbp_view.v_cos_bonuspunkte_transaktion_1
GROUP BY crm_konto_id,
 datzeit_bonuspunkte_transaktion,
 mandant_id,
 bonuspunkte_transaktion_id,
 bonuspunkte_transaktion_richtung;