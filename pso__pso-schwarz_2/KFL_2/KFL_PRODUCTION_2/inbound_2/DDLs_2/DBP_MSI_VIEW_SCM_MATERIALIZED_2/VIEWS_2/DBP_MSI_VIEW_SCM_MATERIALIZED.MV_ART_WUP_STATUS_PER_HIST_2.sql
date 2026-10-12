create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART_WUP_STATUS_PER_HIST_2(
	ART_ID,
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
	DAT_LOESCH_ID,
	DAT,
	DAT_LIEFERSPERRE_BIS,
	AKTUELLE_LISTUNG_FG
) as
SELECT
v01.art_id,
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
v01.dat_loesch_id,
v03.dat,
v01.dat_liefersperre_bis,
CASE
WHEN v02.wup_id IS NULL THEN 0
ELSE 1 END AS aktuelle_listung_fg
FROM dbp_view.v_art_wup_status_per_2 v01

JOIN dbp_view.v_tag_2 v03
ON v03.dat BETWEEN v01.dat_von AND v01.dat_bis

LEFT JOIN (SELECT
v01.mandant_id,
v01.wup_id,
v01.nb_id,
v01.art_id,
v03.dat
FROM dbp_view.v_art_list_wup_zu_per_2 v01
JOIN dbp_view.v_tag_2 v03
ON v03.dat BETWEEN v01.dat_von AND v01.dat_bis
WHERE v01.nb_id=-111
AND v03.dat BETWEEN CURRENT_DATE - 1095 AND CURRENT_DATE
GROUP BY v01.mandant_id, v01.wup_id, v01.nb_id, v01.art_id, v03.dat ) v02 
ON  v01.mandant_id = v02.mandant_id
AND v01.wup_id     = v02.wup_id
AND v01.art_id     = v02.art_id
AND v01.nb_id      = v02.nb_id
AND v03.dat =  v02.dat

WHERE v03.dat BETWEEN CURRENT_DATE - 1095 AND CURRENT_DATE
AND v03.akt_kj BETWEEN -2 AND 0
AND v01.nb_id=-111;