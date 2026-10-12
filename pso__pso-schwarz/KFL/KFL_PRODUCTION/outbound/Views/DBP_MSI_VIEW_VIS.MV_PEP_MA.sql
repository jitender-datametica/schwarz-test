CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_pep_ma AS SELECT PEPER.idpersonal AS pep_ma_id,
 PEP.pep_ma_name,
 PEP.pep_ma_vorname,
 PEP.geschlecht_id,
  CASE
  WHEN PEP.geschlecht_id = 1
  THEN 'Herr'
  WHEN PEP.geschlecht_id = 2
  THEN 'Frau'
  ELSE ' - '
  END AS pep_ma_anrede,
 PEPER.pep_ma_funktion_id,
 CAST(CASE
   WHEN PEPER.pep_ma_funktion_id = 2206
   THEN 'HL'
   WHEN PEPER.pep_ma_funktion_id = 2215
   THEN 'stv. HML'
   WHEN PEPER.pep_ma_funktion_id = 2279
   THEN 'CL'
   WHEN PEPER.pep_ma_funktion_id = 2280
   THEN 'HML'
   WHEN PEPER.pep_ma_funktion_id = 2309
   THEN 'RL'
   ELSE ' - '
   END AS STRING) AS pep_ma_funktion,
 PEPER.idabteilungen AS pep_abt_id,
 PEPER.idmastatus AS pep_ma_status_id,
 PEPER.stunden_woche AS pep_ma_std_woche,
 PEPER.stunden_monat AS pep_ma_std_monat,
 PEPER.dat_von,
 PEPER.dat_bis,
 PEP.dat_austritt
FROM kfl_production_dbp_view.v_pep_personal_per AS PEPER
 INNER JOIN kfl_production_dbp_view.v_pep_personal AS PEP ON PEPER.idpersonal = PEP.idpersonal
 INNER JOIN kfl_production_dbp_view.v_tag AS ZEIT ON ZEIT.dat > DATE '2014-02-28' AND ZEIT.akt_tag <= - 1 AND ZEIT.dat
    BETWEEN PEPER.dat_von AND PEPER.dat_bis AND (PEP.dat_austritt IS NULL OR PEP.dat_austritt > ZEIT.dat)
WHERE PEPER.idabteilungen NOT IN (32, 33)
 AND PEPER.pep_ma_funktion_id IS NOT NULL;