CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_art_gp_wup_zu_per_1 (mandant_id, art_id, gp_id, wup_id, nb_id,
dat_von, dat_bis, ek_preis_brutto, ek_preis_netto1, ek_preis_netto2, ek_kal_basis, ek_mep, ek_kl_preis,
logistikkostenzuschlag, bezugsweg_id, kjmo, reihenfolge) AS SELECT A.mandant_id,
 A.art_id,
 A.gp_id,
 A.wup_id,
 A.nb_id,
 A.dat_von,
 A.dat_bis,
 A.ek_brutto AS ek_preis_brutto,
 A.ek_netto AS ek_preis_netto1,
 A.ek_nettonetto AS ek_preis_netto2,
 A.ek_kal_basis,
 A.ek_mep,
 A.einstandspreis AS ek_kl_preis,
 A.logistikkostenzuschlag,
 A.bezugsweg_id,
 M.kjmo,
  CASE
  WHEN A.wup_id = 6907
  THEN 1
  WHEN A.wup_id = 6906
  THEN 2
  WHEN A.wup_id = CAST(- 1 AS BIGNUMERIC)
  THEN 3
  ELSE 4
  END AS reihenfolge
FROM kfl_production_dbp_view.v_art_gp_wup_zu_per_1 AS A
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS M ON M.kjmo BETWEEN ROUND(CAST(FORMAT_DATE('%Y%m', A.dat_von) AS BIGNUMERIC)
   , 0) AND (ROUND(CAST(FORMAT_DATE('%Y%m', A.dat_bis) AS BIGNUMERIC), 0))
WHERE M.akt_mo <= 0
 AND A.mandant_id = 1
QUALIFY (SUM(1) OVER (PARTITION BY CAST(A.art_id AS STRING), CAST(M.kjmo AS STRING) ORDER BY M.kjmo IS NULL, M.kjmo,
      reihenfolge IS NULL, reihenfolge, A.dat_von IS NULL, A.dat_von ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))
  = 1;