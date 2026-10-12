create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART_WUP_STATUS_PER_VZ_2(
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
	KDIS,
	BEZUGSWEG_ID,
	TERMINIERUNGSGRUPPE_1_ID,
	TERMINIERUNGSGRUPPE_2_ID,
	TERMINIERUNGSGRUPPE_3_ID,
	SOLLBESTAND,
	DAT_LOESCH_ID,
	AKTUELLE_LISTUNG_FG,
	MIN_RESTLAUFZEIT,
	SELBSTABHOLUNG_FG
) as
SELECT
v01.art_id,
v01.dat_bis,
v01.dat_von,
v01.loesch_id,
v01.mandant_id,
v01.nb_id,
v01.wup_id,
v01.wg_verkett_id,
v01.fremd_lagerort_id,
v01.disponent_id,
v01.system_id,
v01.pps_plan_kalender_id,
v01.disposition_rhythmus_id,
v01.planlieferzeit,
v01.dispomerkmal,
v01.we_bearbeitungszeit,
v01.min_sicherh_bestand,
v01.anliefer_kalender,
v01.kdis,
v01.bezugsweg_id,
v01.terminierungsgruppe_1_id,
v01.terminierungsgruppe_2_id,
v01.terminierungsgruppe_3_id,
v01.sollbestand,
v01.dat_loesch_id,

CASE WHEN EXISTS (SELECT 1
FROM DBP_VIEW.V_ART_LIST_WUP_ZU_PER_2 V02
WHERE CURRENT_DATE-1 BETWEEN V02.DAT_VON AND V02.DAT_BIS
AND V01.MANDANT_ID=V02.MANDANT_ID
AND V01.WUP_ID=V02.WUP_ID
AND V01.ART_ID=V02.ART_ID) THEN 1 ELSE 0 END AS AKTUELLE_LISTUNG_FG,
v01.min_restlaufzeit,
v01.selbstabholung_fg

FROM dbp_view.v_art_wup_status_per_2 v01

















WHERE v01.dat_bis  = DATE '9999-12-31'
AND v01.nb_id = -111;