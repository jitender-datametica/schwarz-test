CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ART_UMBEWERTUNG_1
   AS 
    SELECT
   v01.mandant_id,
   v01.umbew_beleg_id,
   v01.umbew_beleg_pos_id,
   v01.kj,
   v01.preis_aend_grund_id,
   v01.art_id,
   v01.wup_id,
   v01.nb_id,
   v01.dat_umbew,
 -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE( v01.vk_brutto_alt ,0)
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.vk_brutto_alt ,0) * umrechnungskurs_0
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.vk_brutto_alt ,0) * umrechnungskurs_1
             END AS DECIMAL(18,6)) AS vk_brutto_alt,
   menge_umbew,
  CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE( v01.diff_wert_bestand_brutto ,0)
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.diff_wert_bestand_brutto ,0) * umrechnungskurs_0
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.diff_wert_bestand_brutto ,0) * umrechnungskurs_1
             END AS DECIMAL(18,6)) AS diff_wert_bestand_brutto,
   CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE( v01.diff_wert_bestand_netto ,0)
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.diff_wert_bestand_netto ,0) * umrechnungskurs_0
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.diff_wert_bestand_netto ,0) * umrechnungskurs_1
             END AS DECIMAL(18,6)) AS diff_wert_bestand_netto,
   wrg_id,
   menge_berechnet,
   gp_id
   FROM DBP_MSI_VIEW_AIS_KMO.TBL_MV_ART_UMBEWERTUNG_1 v01 
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200;