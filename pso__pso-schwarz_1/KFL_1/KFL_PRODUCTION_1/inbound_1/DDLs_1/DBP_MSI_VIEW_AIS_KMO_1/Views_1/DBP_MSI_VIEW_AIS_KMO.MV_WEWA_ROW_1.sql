CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_WEWA_ROW_1
(
   MANDANT_ID,
	RECH_BELEG_ID,
	RECH_BELEG_KONT_POS_ID,
	WUP_ID,
	NB_ID,
	GP_ID,
	DAT_BUCH,
	ART_ID,
	BETRAG_BELEG,
	WEWA_JAHR,
	POSTEN_KZ_PER
)
   AS 
   SELECT
   mandant_id,
   rech_beleg_id,
   rech_beleg_kont_pos_id,
   wup_id,
   nb_id,
   gp_id,
   dat_buch,
   art_id,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CAST(CASE WHEN   mandant_id_br = 5 AND kursf_br < 0 THEN (betrag_beleg_brk / ABS(kursf_br))
             WHEN   v200.wrg_typ_id  = 1 THEN betrag_beleg_brk * kursf_br
             WHEN   v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  betrag_beleg_brk  * kursf_br * umrechnungskurs_0
             WHEN   v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  betrag_beleg_brk  * kursf_br * umrechnungskurs_1
   END AS NUMBER(38,5)) AS betrag_beleg,
   wewa_jahr,
   v01.posten_kz_per

   FROM dbp_msi_view_ais_kmo.TBL_MV_WEWA_ROW_1 v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200;