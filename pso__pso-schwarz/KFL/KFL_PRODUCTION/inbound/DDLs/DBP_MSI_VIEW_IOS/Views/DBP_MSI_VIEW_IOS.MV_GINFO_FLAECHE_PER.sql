CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_GINFO_FLAECHE_PER as
   SELECT
   mandant_id, techn_platz_id, ginfo_flaeche_id, kjmo, ginfo_flaeche_netto, ginfo_flaeche_brutto, ginfo_achse_wert, ginfo_achse_typ_id, ginfo_flaeche_typ_id

   FROM dbp_view.v_ginfo_flaeche_per ginfo_fl
   INNER JOIN
   (SELECT MAX(dat)  max_tag,
   kjmo
   FROM dbp_view.v_tag
   WHERE dat BETWEEN '2008-07-01' AND CURRENT_DATE
   GROUP BY kjmo) t
   ON
   max_tag BETWEEN dat_von AND dat_bis;