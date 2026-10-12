CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_F_ODS_BON_VERKAUF_1(
	BON_ID,
	BON_DAT,
	BON_BOOKING,
	DAT_BOOKING,
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	WRG_ID,
	KL_ART_ID,
	ART_ID,
	EAN_KASSE,
	WG_ID,
	VK_MENGE,
	VK_MENGE_SA,
	VK_MENGE_AF,
	EINH_ID,
	UMSATZ_BRUTTO,
	UMSATZ_BRUTTO_SA,
	UMSATZ_BRUTTO_AF,
	MWST,
	AKTION_ID,
	HEUTE_ZEIT_BIS
) AS
  -- SPEC0244443, prescherad, 18.04.2024, Neuanlage 
 SELECT
   v01.bon_id,
   v01.bon_dat,
   v01.bon_booking,
   v01.dat_booking,
   v01.wup_id,
   0,
   v01.mandant_id,
   CASE WHEN v06.wrg_typ_id = 0 THEN v200.nach_wrg_id ELSE v08.DEFAULT_WRG END AS wrg_id,
   v02.kl_art_id,
   v05.art_id,
   v02.ean_kasse,
   v02.wg_id,
   SUM (v02.menge),
   CASE WHEN aktion_id <> '' THEN SUM (v02.menge) END AS menge_sa,
   CASE WHEN aktion_id = '' THEN SUM (v02.menge) END AS menge_af,
   v02.einh_id,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   SUM(CASE
   WHEN v01.wrg_id <> 'EUR' AND v08.default_wrg = 'EUR' THEN v02.umsatz_brutto * v200.umrechnungskurs 
   WHEN v06.wrg_typ_id = 0 AND v06.berichtskurs_typ_id = 0 THEN v02.umsatz_brutto * v200.umrechnungskurs
   WHEN v06.wrg_typ_id = 0 AND v06.berichtskurs_typ_id = 1 THEN v02.umsatz_brutto * v300.umrechnungskurs
   ELSE v02.umsatz_brutto END) AS umsatz_brutto,
  
   CASE WHEN aktion_id <> '' THEN
		SUM(CASE
		WHEN v01.wrg_id <> 'EUR' AND v08.default_wrg = 'EUR' THEN v02.umsatz_brutto * v200.umrechnungskurs 
		WHEN v06.wrg_typ_id = 0 AND v06.berichtskurs_typ_id = 0 THEN v02.umsatz_brutto * v200.umrechnungskurs
        WHEN v06.wrg_typ_id = 0 AND v06.berichtskurs_typ_id = 1 THEN v02.umsatz_brutto * v300.umrechnungskurs
		ELSE v02.umsatz_brutto END) 
   END AS umsatz_brutto_sa,

   CASE WHEN aktion_id = '' THEN
		SUM(CASE
		WHEN v01.wrg_id <> 'EUR' AND v08.default_wrg = 'EUR' THEN v02.umsatz_brutto * v200.umrechnungskurs 
		WHEN v06.wrg_typ_id = 0 AND v06.berichtskurs_typ_id = 0 THEN v02.umsatz_brutto * v200.umrechnungskurs
        WHEN v06.wrg_typ_id = 0 AND v06.berichtskurs_typ_id = 1 THEN v02.umsatz_brutto * v300.umrechnungskurs
		ELSE v02.umsatz_brutto END) 
   END AS umsatz_brutto_af,
   v03.mwst,
   v02.aktion_id,
   v09.heute_zeit_bis
   FROM dbp_v_ods.v_ods_bon_kopf_1 v01
   INNER JOIN dbp_v_ods.v_ods_bon_verkauf_1 v02
   ON  v01.bon_id = v02.bon_id
   AND v01.wup_id = v02.wup_id
   AND v01.mandant_id = v02.mandant_id
   AND v01.bon_dat = v02.bon_dat
   INNER JOIN dbp_view.v_mwst_per_1 v03
   ON  v02.mandant_id = v03.mandant_id
   AND v02.mwst_id = v03.mwst_id
   AND v03.dat_bis = '9999-12-31'
   INNER JOIN dbp_view.v_art_1 v05
   ON  v02.mandant_id = v05.mandant_id
   AND v02.kl_art_id = v05.kl_art_id
   AND v05.dat_bis = '9999-12-31'
   
   --currency conversion
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v06
  
  /*JOIN dbp_view.v_kurs_1 v07
  ON v01.bon_dat BETWEEN v07.dat_von AND v07.dat_bis
  AND v01.wrg_id = v07.von_wrg_id
  AND v07.kurstyp_id = 9
  AND v07.nach_wrg_id ='EUR'*/

-- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_1 v200
   ON v200.dat_bis = '9999-12-31'
   AND v01.wrg_id = v200.von_wrg_id
   AND v200.kurstyp_id = 3
   AND v200.nach_wrg_id ='EUR'

-- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs_1 v300
   ON v01.bon_dat BETWEEN v300.dat_von AND v300.dat_bis
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

  JOIN dbp_view.v_mandant_1 v08
  ON v01.mandant_id = v08.mandant_id

  --Schließungszeitraum pro Filiale
  JOIN (
   SELECT mandant_id, wup_id,
   MAX(SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(zeit_bis)) AS heute_zeit_bis
   FROM dbp_view.v_vaus_wup_oeffnung_zu_per_1
   WHERE MANDANT_ID > 1
   GROUP BY 1,2 ) v09
  ON v01.mandant_id=v09.mandant_id
  AND v01.wup_id=v09.wup_id 

   WHERE (v01.bon_id, v01.wup_id, v01.mandant_id) NOT IN
   (
   SELECT v04.bon_id,
   v04.wup_id,
   v04.mandant_id
  FROM dbp_v_ods.v_ods_bon_storno_1 v04
   )
   AND v01.mandant_id > 1
   AND v01.bon_dat BETWEEN CURRENT_DATE -14 AND CURRENT_DATE
  --AP0242994/SPEC0276113 Filtern von wg_id = 961 / sschuecke 18.10.2024
   AND v02.wg_id <> 961
   GROUP BY
   v01.bon_id
   ,v01.bon_dat
   ,v01.bon_booking
   ,v01.dat_booking
   ,v01.wup_id
   ,v01.mandant_id
   ,CASE WHEN v06.wrg_typ_id = 0 THEN v200.nach_wrg_id ELSE v08.DEFAULT_WRG END
   ,v02.kl_art_id
   ,v05.art_id
   ,v02.ean_kasse
   ,v02.wg_id
   ,v02.einh_id
   ,v03.mwst
   ,v02.aktion_id
   ,v09.heute_zeit_bis;