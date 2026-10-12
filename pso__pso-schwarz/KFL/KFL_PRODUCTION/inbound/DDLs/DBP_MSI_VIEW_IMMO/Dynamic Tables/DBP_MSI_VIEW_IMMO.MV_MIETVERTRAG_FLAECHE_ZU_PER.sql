CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_MIETVERTRAG_FLAECHE_ZU_PER(
	MANDANT_ID,
	MIETVERTRAG_ID_HILFE,
	MIETVERTRAG_ID,
	FLAECHE_ID,
	DAT_VON,
	DAT_BIS,
	DAT_FLAECHE_UEBERGABE,
	DAT_FLAECHE_RUECKGABE,
	VERTRAG_AKTIV_FG,
	IMMO_OBJEKT_ID,
	FLAECHE_TYP_ID,
	BRANCHE_ID,
	MIETE_UMSATZ_PROZENT,
	MIETE_REFERENZ_ID,
	MIETART_ID,
	DAT_FREI_FLAECHE_SEIT,
	FLAECHE_FREI_SEIT_TAGEN,
	MIETE_BETRAG,
	NEBENKOSTEN_BETRAG,
	NEBENKOSTEN_ABSCHLAG,
	MIETE_UMSATZ_ABSCHLAG,
	INVESTMIETE_BETRAG,
	SONST_BETRAG,
	IMMO_VERW_BETRAG,
	WRG_ID,
	WRG_TYP_ID,
	FLAECHE_STATUS_ID
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   amvf.mandant_id,
   amvf.mietvertrag_id_hilfe,
   amvf.mietvertrag_id,
   amvf.flaeche_id,
   amvf.dat_von,
   amvf.dat_bis,
   amvf.dat_flaeche_uebergabe,
   amvf.dat_flaeche_rueckgabe,
   amvf.vertrag_aktiv_fg,
   amvf.immo_objekt_id,
   amvf.flaeche_typ_id,
   amvf.branche_id,
   amvf.miete_umsatz_prozent,
   amvf.miete_referenz_id,
   amvf.mietart_id,
   amvf.dat_frei_flaeche_seit,
   CASE WHEN CURRENT_DATE >= amvf.dat_frei_flaeche_seit
   THEN CURRENT_DATE - amvf.dat_frei_flaeche_seit
   END flaeche_frei_seit_tagen,
   amvf.miete_betrag          * kurs miete_betrag,
   amvf.nebenkosten_betrag    * kurs nebenkosten_betrag,
   amvf.nebenkosten_abschlag  * kurs nebenkosten_abschlag,
   amvf.miete_umsatz_abschlag * kurs miete_umsatz_abschlag,
   amvf.investmiete_betrag    * kurs investmiete_betrag,
   amvf.sonst_betrag          * kurs sonst_betrag,
   amvf.immo_verw_betrag      * kurs immo_verw_betrag,
   kurs.wrg_id,
   kurs.wrg_typ_id,
   amvf.flaeche_status_id
  FROM dbp_msi_v_view.v_ivs_mietvtg_fl_zu_per_msi amvf
   INNER JOIN dbp_msi_view_immo.mv_mand_wrg_kurs_zu_per  kurs
   ON kurs.mandant_id = amvf.mandant_id
   AND CURRENT_DATE BETWEEN kurs_dat_von AND kurs_dat_bis
;