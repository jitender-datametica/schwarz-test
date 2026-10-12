create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_ART_LIEF_WERK_STATUS_PER_1(
	ART_ID,
	DAT_BIS,
	DAT_VON,
	LOESCH_ID,
	MANDANT_ID,
	LIEFERNDESWERK_NB_ID,
	LIEFERNDESWERK,
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
	ANLIEFER_KALENDER
) as
   SELECT
  art_id, dat_bis, dat_von, loesch_id, mandant_id, nb_id, wup_id, wg_verkett_id, fremd_lagerort_id, disponent_id, system_id, pps_plan_kalender_id, disposition_rhythmus_id, planlieferzeit, dispomerkmal, we_bearbeitungszeit, min_sicherh_bestand, anliefer_kalender
   FROM dbp_view.v_art_wup_status_per_1
   WHERE dat_bis = DATE '9999-12-31' and nb_id = -111;