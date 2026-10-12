CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_cos_bonuskauf_unique_kunden (bonuskauf_id, mandant_id,
bonuskauf_partner_fg, anz_unique_kunden_bp_flag0, anz_unique_kunden_bp_flag1) AS SELECT V01.bonuskauf_id,
 V01.mandant_id,
 V02.bonuskauf_partner_fg,
  CASE
  WHEN V02.bonuskauf_partner_fg = 0
  THEN COUNT(DISTINCT V01.crm_kunde_id)
  ELSE NULL
  END AS anz_unique_kunden_bp_flag0,
  CASE
  WHEN V02.bonuskauf_partner_fg = 1
  THEN COUNT(DISTINCT V01.crm_kunde_id)
  ELSE NULL
  END AS anz_unique_kunden_bp_flag1
FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf AS V02 ON V01.mandant_id = V02.mandant_id AND V01.bonuskauf_id = V02
   .bonuskauf_id
WHERE V01.anz_einloesung > 0
GROUP BY V01.bonuskauf_id,
 V01.mandant_id,
 V02.bonuskauf_partner_fg;