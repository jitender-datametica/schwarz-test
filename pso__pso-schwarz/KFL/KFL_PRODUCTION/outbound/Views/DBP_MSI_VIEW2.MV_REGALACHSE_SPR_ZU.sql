CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_regalachse_spr_zu (mandant_id, fbb_nr, spr_id, regalachse_bez,
dat_bis_neu) AS SELECT R.mandant_id,
 R.fbb_nr,
 L.spr_id,
 L.layoutbaustein_bez AS regalachse_bez,
  CASE
  WHEN SUBSTR(R.fbb_nr, 1, 4) >= 'P150' AND R.dat_bis <> DATE '9999-12-31'
  THEN DATE_ADD(R.dat_bis, INTERVAL 150 DAY)
  ELSE R.dat_bis
  END AS dat_bis_neu
FROM kfl_production_dbp_view.v_regalachse AS R
 INNER JOIN kfl_production_dbp_view.v_layoutbaustein_spr_zu AS L ON R.mandant_id = L.mandant_id AND R.layoutbaustein_id
   = L.layoutbaustein_id
WHERE R.mandant_id = 1
 AND CASE
   WHEN SUBSTR(R.fbb_nr, 1, 4) >= 'P150' AND R.dat_bis <> DATE '9999-12-31'
   THEN DATE_ADD(R.dat_bis, INTERVAL 150 DAY)
   ELSE R.dat_bis
   END >= CURRENT_DATE
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(R.mandant_id AS STRING), R.fbb_nr ORDER BY dat_bis_neu IS NULL,
      dat_bis_neu)) = 1;