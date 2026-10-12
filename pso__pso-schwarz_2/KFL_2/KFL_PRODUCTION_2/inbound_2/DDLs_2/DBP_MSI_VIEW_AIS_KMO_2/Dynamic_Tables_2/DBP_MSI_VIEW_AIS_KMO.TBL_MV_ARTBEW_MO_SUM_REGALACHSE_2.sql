CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.TBL_MV_ARTBEW_MO_SUM_REGALACHSE_2
(
	KJMO,
	ART_ID,
	FBB_NR,
	FACHBODEN_NR,
	FACHBODEN_POS,
	BEWART_ID,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	GP_ID,
	HERST_ID,
	DIFF_EK_MEP_KONZ,
    EK_MEP,
    DIFF_UMSATZ_MWST_BETRAG_KONZ,
    UMSATZ_MWST_BETRAG,
    KAPAZITAET_FAKTOR,
    DIFF_UMSATZ_NETTO_KONZ,
	UMSATZ_NETTO,
	MENGE,
	DIFF_EINSTANDSPREIS_KONZ,
	EINSTANDSPREIS,
    UMRECHNUNGSKURS_HIST
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
   kjmo,
   v01.art_id,
   fbb_nr,
   fachboden_nr,
   fachboden_pos,
   bewart_id,
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.gp_id,
   herst_id,
   v01.diff_ek_mep_konz,
   v01.ek_mep,
   v01.diff_umsatz_mwst_betrag_konz,
   v01.umsatz_mwst_betrag,
   kapazitaet_faktor,
   v01.diff_umsatz_netto_konz,
   v01.umsatz_netto,
   menge,
   v01.diff_einstandspreis_konz,
   v01.einstandspreis,
   v01.umrechnungskurs_hist

  FROM DBP_DATA.ARTBEW_MO_SUM_2 v01

   JOIN DBP_DATA.REGALACHSE_AKT_2 v02
   ON v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id
   AND v01.nb_id =v02.nb_id

   WHERE v01.mandant_id <> 1
   --AP0190987/SPEC0225041 Filter E-Loading Artikel_2 / sschuecke 17.11.2023
   AND NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
   --AP0227085/SPEC0284781 Filter E-Loading Artikel_2 / sschuecke 25.02.2025
   AND NOT (v01.mandant_id = 2 AND v01.art_id = 208124500)
   AND NOT (v01.mandant_id = 3 AND v01.art_id = 208113690)
   AND NOT (v01.mandant_id = 6 AND v01.art_id = 208131570)
   AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 208114740)
   AND NOT (v01.mandant_id = 8 AND v01.art_id = 208131640);