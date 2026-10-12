create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_ART_WUP_STATUS_PER_2(
	ART_ID,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DAT,
	LOESCH_ID,
	WG_VERKETT_ID,
	FREMD_LAGERORT_ID,
	DISPONENT_ID,
	PPS_PLAN_KALENDER_ID,
	DISPOSITION_RHYTHMUS_ID,
	PLANLIEFERZEIT,
	DISPOMERKMAL,
	WE_BEARBEITUNGSZEIT,
	MIN_SICHERH_BESTAND,
	ANLIEFER_KALENDER,
	KDIS,
	BEZUGSWEG_ID
) as
   SELECT

   v01.art_id, v01.mandant_id, v01.wup_id, v01.nb_id, t.dat, v01.loesch_id, v01.wg_verkett_id, v01.fremd_lagerort_id, v01.disponent_id, v01.pps_plan_kalender_id, v01.disposition_rhythmus_id, v01.planlieferzeit, v01.dispomerkmal, v01.we_bearbeitungszeit, v01.min_sicherh_bestand, v01.anliefer_kalender, v01.kdis, v01.bezugsweg_id

   FROM dbp_view.v_art_wup_status_per_2   v01

   JOIN dbp_view.v_tag_2 t
   ON t.dat BETWEEN v01.dat_von AND v01.dat_bis
   
   WHERE v01.mandant_id IN (1,2);