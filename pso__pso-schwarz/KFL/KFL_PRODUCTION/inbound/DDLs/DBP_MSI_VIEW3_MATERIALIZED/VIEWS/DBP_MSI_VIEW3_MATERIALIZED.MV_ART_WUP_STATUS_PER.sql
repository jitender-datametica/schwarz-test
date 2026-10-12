create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_ART_WUP_STATUS_PER(
	ART_ID,
	DAT_BIS,
	DAT_VON,
	LOESCH_ID,
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WG_VERKETT_ID,
	FREMD_LAGERORT_ID,
	DISPONENT_ID,
	SYSTEM_ID,
	PPS_PLAN_KALENDER_ID,
	DISPOSITION_RHYTHMUS_ID,
	PLANLIEFERZEIT,
	DISPOMERKMAL,
	WE_BEARBEITUNGSZEIT,
	MIN_SICHERH_BESTAND,
	ANLIEFER_KALENDER,
	TERMINIERUNGSGRUPPE_1_ID,
	TERMINIERUNGSGRUPPE_2_ID,
	TERMINIERUNGSGRUPPE_3_ID,
	SELBSTABHOLUNG_FG,
	MIN_RESTLAUFZEIT
) as
   SELECT
  v01.art_id, v01.dat_bis, v01.dat_von, v01.loesch_id, v01.mandant_id, v01.nb_id, v01.wup_id, v01.wg_verkett_id, v01.fremd_lagerort_id, v01.disponent_id, v01.system_id, v01.pps_plan_kalender_id, v01.disposition_rhythmus_id, v01.planlieferzeit, v01.dispomerkmal, v01.we_bearbeitungszeit, v01.min_sicherh_bestand, v01.anliefer_kalender, v01.terminierungsgruppe_1_id, v01.terminierungsgruppe_2_id, v01.terminierungsgruppe_3_id, v01.selbstabholung_fg, v01.min_restlaufzeit
   FROM dbp_view.v_art_wup_status_per v01
   WHERE dat_bis = DATE '9999-12-31' AND nb_id = -111;