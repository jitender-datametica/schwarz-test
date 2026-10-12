CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_KOMMBEREICH_1 as
   SELECT
   mandant_id, nb_id, wup_id, lagernummer_id, CASE WHEN TRIM(COALESCE(komm_bereich,'')) <> '' THEN komm_bereich ELSE 'kein Kommbereich' END AS komm_bereich, MIN(dat_von) dat_von, MAX(dat_bis) dat_bis
   FROM dbp_view.v_l_lagerplatz_1
   GROUP BY
   mandant_id
   ,nb_id
   ,wup_id
   ,lagernummer_id
   ,komm_bereich;