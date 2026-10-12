CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bvv_projekt_tage_1 AS SELECT projekt_id,
 projekt_nr,
 cpr_bauabnahme,
 baubeginn,
 cpr_baubeg_kaelte,
 kbe_fs_vp_verabschiedet,
 stille_eroeffnung,
 beginn_einrichtung,
 dat_termin_gj,
 MAX(DATE_DIFF(cpr_bauabnahme, baubeginn, DAY)) AS massnahme_gesamt,
 MAX(DATE_DIFF(baubeginn, kbe_fs_vp_verabschiedet, DAY)) AS tage_baubeginn_minus_vs_verabschiedet,
 MAX(DATE_DIFF(dat_termin_gj, baubeginn, DAY)) AS tage_letzter_tag_im_akt_gj_minus_baubeginn,
 MAX(DATE_DIFF(dat_termin_gj, kbe_fs_vp_verabschiedet, DAY)) AS tage_letzter_tag_im_akt_gj_minus_vs_verabschiedet,
 MAX(DATE_DIFF(dat_termin_gj, cpr_baubeg_kaelte, DAY)) AS tage_letzter_tag_im_akt_gj_minus_beginn_kaelte,
 MAX(DATE_DIFF(dat_termin_gj, beginn_einrichtung, DAY)) AS tage_letzter_tag_im_akt_gj_minus_beginn_einrichtung,
 MAX(DATE_DIFF(dat_termin_gj, cpr_bauabnahme, DAY)) AS tage_letzter_tag_im_akt_gj_minus_bauabnahme,
 MAX(DATE_DIFF(stille_eroeffnung, cpr_baubeg_kaelte, DAY)) AS tage_stille_eoe_minus_beginn_kaelte,
 MAX(DATE_DIFF(stille_eroeffnung, beginn_einrichtung, DAY)) AS tage_stille_eoe_minus_beginn_einrichtung,
 MAX(DATE_DIFF(stille_eroeffnung, cpr_bauabnahme, DAY)) AS tage_stille_eoe_minus_bauabnahme,
 MAX(DATE_DIFF(CURRENT_DATE, cpr_baubeg_kaelte, DAY)) AS tage_date_minus_beginn_kaelte,
 MAX(DATE_DIFF(CURRENT_DATE, beginn_einrichtung, DAY)) AS tage_date_minus_beginn_einrichtung,
 MAX(DATE_DIFF(CURRENT_DATE, kbe_fs_vp_verabschiedet, DAY)) AS tage_date_minus_vs_verabschiedet,
 MAX(DATE_DIFF(CURRENT_DATE, baubeginn, DAY)) AS tage_date_minus_baubeginn,
 MAX(DATE_DIFF(CURRENT_DATE, cpr_bauabnahme, DAY)) AS tage_date_minus_bauabnahme,
  CASE
  WHEN CURRENT_DATE > stille_eroeffnung
  THEN MAX(DATE_DIFF(stille_eroeffnung, cpr_baubeg_kaelte, DAY))
  ELSE MAX(DATE_DIFF(CURRENT_DATE, cpr_baubeg_kaelte, DAY))
  END AS tage_seit_baubeginn_kuehlung_kaelte,
  CASE
  WHEN CURRENT_DATE > stille_eroeffnung
  THEN MAX(DATE_DIFF(stille_eroeffnung, beginn_einrichtung, DAY))
  ELSE MAX(DATE_DIFF(CURRENT_DATE, beginn_einrichtung, DAY))
  END AS tage_seit_baubeginn_einrichtung,
  CASE
  WHEN CURRENT_DATE > stille_eroeffnung
  THEN MAX(DATE_DIFF(stille_eroeffnung, beginn_einrichtung, DAY))
  ELSE MAX(DATE_DIFF(CURRENT_DATE, beginn_einrichtung, DAY))
  END AS tage_seit_baubeginn_it,
  CASE
  WHEN CURRENT_DATE > cpr_bauabnahme
  THEN MAX(DATE_DIFF(cpr_bauabnahme, baubeginn, DAY))
  ELSE MAX(DATE_DIFF(CURRENT_DATE, cpr_bauabnahme, DAY))
  END AS tage_seit_baubeginn_baunebenkosten_35,
  CASE
  WHEN CURRENT_DATE > baubeginn
  THEN MAX(DATE_DIFF(baubeginn, kbe_fs_vp_verabschiedet, DAY))
  ELSE MAX(DATE_DIFF(dat_termin_gj, baubeginn, DAY))
  END AS tage_seit_baubeginn_baunebenkosten_65,
  CASE
  WHEN CURRENT_DATE > cpr_bauabnahme
  THEN MAX(DATE_DIFF(cpr_bauabnahme, baubeginn, DAY))
  ELSE MAX(DATE_DIFF(dat_termin_gj, baubeginn, DAY))
  END AS tage_seit_baubeginn_baukosten,
  CASE
  WHEN dat_termin_gj > stille_eroeffnung
  THEN MAX(DATE_DIFF(stille_eroeffnung, cpr_baubeg_kaelte, DAY))
  ELSE MAX(DATE_DIFF(dat_termin_gj, cpr_baubeg_kaelte, DAY))
  END AS tage_bis_fertigstellung_kaelte,
  CASE
  WHEN dat_termin_gj > stille_eroeffnung
  THEN MAX(DATE_DIFF(stille_eroeffnung, beginn_einrichtung, DAY))
  ELSE MAX(DATE_DIFF(dat_termin_gj, beginn_einrichtung, DAY))
  END AS tage_bis_fertigstellung_einrichtung,
  CASE
  WHEN dat_termin_gj > stille_eroeffnung
  THEN MAX(DATE_DIFF(stille_eroeffnung, beginn_einrichtung, DAY))
  ELSE MAX(DATE_DIFF(dat_termin_gj, beginn_einrichtung, DAY))
  END AS tage_bis_fertigstellung_it,
  CASE
  WHEN dat_termin_gj > cpr_bauabnahme
  THEN MAX(DATE_DIFF(cpr_bauabnahme, baubeginn, DAY))
  ELSE MAX(DATE_DIFF(dat_termin_gj, beginn_einrichtung, DAY))
  END AS tage_bis_fertigstellung_35,
  CASE
  WHEN dat_termin_gj > cpr_bauabnahme
  THEN MAX(DATE_DIFF(baubeginn, kbe_fs_vp_verabschiedet, DAY))
  ELSE MAX(DATE_DIFF(dat_termin_gj, kbe_fs_vp_verabschiedet, DAY))
  END AS tage_bis_fertigstellung_65,
  CASE
  WHEN dat_termin_gj > baubeginn
  THEN MAX(DATE_DIFF(cpr_bauabnahme, baubeginn, DAY))
  ELSE MAX(DATE_DIFF(dat_termin_gj, baubeginn, DAY))
  END AS tage_bis_baukosten
FROM kfl_production_dbp_msi_view_ios.mv_bvv_projekt_tage_einzeln_1 AS V01
GROUP BY projekt_id,
 projekt_nr,
 cpr_bauabnahme,
 baubeginn,
 cpr_baubeg_kaelte,
 kbe_fs_vp_verabschiedet,
 stille_eroeffnung,
 beginn_einrichtung,
 dat_termin_gj;