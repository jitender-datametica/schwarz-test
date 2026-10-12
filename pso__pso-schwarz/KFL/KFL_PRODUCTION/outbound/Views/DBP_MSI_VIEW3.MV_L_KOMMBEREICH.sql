CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_kommbereich AS SELECT mandant_id,
 nb_id,
 wup_id,
 lagernummer_id,
  CASE
  WHEN TRIM(COALESCE(komm_bereich, '')) <> ''
  THEN komm_bereich
  ELSE 'kein Kommbereich'
  END AS komm_bereich,
 MIN(dat_von) AS dat_von,
 MAX(dat_bis) AS dat_bis
FROM kfl_production_dbp_view.v_l_lagerplatz
GROUP BY mandant_id,
 nb_id,
 wup_id,
 lagernummer_id,
 komm_bereich;