CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_regalachse (mandant_id, regalachse_id, layoutbaustein_id,
layoutbaustein_version, dat_von, dat_bis_neu, fbb_nr, platzierungsstufe_id, wup_id, nb_id, achsgruppe_id,
regalachse_flaeche, achs_nr) AS SELECT mandant_id,
 regalachse_id,
 layoutbaustein_id,
 layoutbaustein_version,
 dat_von,
  CASE
  WHEN SUBSTR(fbb_nr, 1, 4) >= 'P150' AND dat_bis <> DATE '9999-12-31'
  THEN DATE_ADD(dat_bis, INTERVAL 150 DAY)
  ELSE dat_bis
  END AS dat_bis_neu,
 fbb_nr,
 platzierungsstufe_id,
 wup_id,
 nb_id,
 achsgruppe_id,
 regalachse_flaeche,
 SUBSTR(fbb_nr, LENGTH(fbb_nr) - 3, 3) AS achs_nr
FROM kfl_production_dbp_view.v_regalachse
WHERE mandant_id <> 1
 AND (SUBSTR(platzierungsstufe_id, 1, 1) IN ('X', 'Y', 'Z') OR CAST(SUBSTR(platzierungsstufe_id, 3, 1) AS FLOAT64) = 0
    AND SUBSTR(platzierungsstufe_id, 1, 1) NOT IN ('X', 'Y', 'Z'))
 AND CASE
   WHEN SUBSTR(fbb_nr, 1, 4) >= 'P150' AND dat_bis <> DATE '9999-12-31'
   THEN DATE_ADD(dat_bis, INTERVAL 150 DAY)
   ELSE dat_bis
   END >= CURRENT_DATE
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), fbb_nr ORDER BY CASE
       WHEN SUBSTR(fbb_nr, 1, 4) >= 'P150' AND dat_bis <> DATE '9999-12-31'
       THEN DATE_ADD(dat_bis, INTERVAL 150 DAY)
       ELSE dat_bis
       END IS NULL, CASE
       WHEN SUBSTR(fbb_nr, 1, 4) >= 'P150' AND dat_bis <> DATE '9999-12-31'
       THEN DATE_ADD(dat_bis, INTERVAL 150 DAY)
       ELSE dat_bis
       END)) = 1;