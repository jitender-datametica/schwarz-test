-- 26.01.2022 richternic: Neu Anlage - Migration AI Cloud

-- 30.03.2022 richternic: Einschränkung auf max dat_berechnung

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_wbs_referenzartikel AS WITH MAX_DAT_BERECHNUNG AS
  (SELECT mandant_id,
   MAX(dat_berechnung) AS max_dat_berechnung
  FROM kfl_production_dbp_view.v_wbs_referenzartikel
  GROUP BY mandant_id) (SELECT V01.mandant_id,
   V01.art_id,
   V01.ref_art_id,
   V01.ref_anz_maerkte,
   V01.avg_vk_brutto,
   V01.avg_ref_vk_brutto,
   V01.ref_score_rang,
   V01.ref_score,
   V01.diff_vk,
   V01.diff_absatz,
   V01.diff_absatz_absolut,
   V01.diff_absatz_kennz,
   V01.diff_cosinus,
   V01.diff_gewicht,
   V01.diff_wug,
   V01.aktion_id,
   V01.ref_ltz_dat_von,
   V01.dat_von,
   V01.ltz_dat_von,
   V01.berechnung_typ,
   V01.dat_berechnung,
   V01.selektor_fg,
   V01.berechnung_subtyp
  FROM kfl_production_dbp_view.v_wbs_referenzartikel AS V01
   INNER JOIN MAX_DAT_BERECHNUNG AS v02 ON V01.mandant_id = v02.mandant_id AND V01.dat_berechnung = v02.max_dat_berechnung
     );