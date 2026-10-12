create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_ART_WUP_STATUS_PER_HIST_2(
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
	AKTUELLE_LISTUNG_FG
) as
-- 2022-09-13, AP0141509,SPEC0169569, dknop, initial
SELECT 
 v01.art_id
,v01.loesch_id
,v01.mandant_id
,v01.nb_id
,v01.wup_id
,v01.wg_verkett_id
,v01.fremd_lagerort_id
,v01.disponent_id
,v01.system_id
,v01.pps_plan_kalender_id
,v01.disposition_rhythmus_id
,v01.planlieferzeit
,v01.dispomerkmal
,v01.we_bearbeitungszeit
,v01.min_sicherh_bestand
,v01.anliefer_kalender
,v01.kdis
,v01.bezugsweg_id
,v01.terminierungsgruppe_1_id
,v01.terminierungsgruppe_2_id
,v01.terminierungsgruppe_3_id
,v01.dat_loesch_id
,v03.dat
,MAX(CASE WHEN v02.wup_id IS NULL THEN 0 ELSE 1 END) AS aktuelle_listung_fg
FROM DBP_VIEW.v_art_wup_status_per_2 v01
JOIN DBP_VIEW.v_tag_2 v03
  ON v03.dat BETWEEN v01.dat_von AND v01.dat_bis

LEFT JOIN DBP_VIEW.v_art_list_wup_zu_per_2 v02
  ON v01.mandant_id = v02.mandant_id
 AND v01.wup_id     = v02.wup_id
 AND v01.art_id     = v02.art_id
 AND v03.dat BETWEEN  v02.dat_von AND v02.dat_bis
WHERE v03.dat BETWEEN CURRENT_DATE - 1460 AND CURRENT_DATE
GROUP BY v01.art_id
        ,v01.loesch_id
        ,v01.mandant_id
        ,v01.nb_id
        ,v01.wup_id
        ,v01.wg_verkett_id
        ,v01.fremd_lagerort_id
        ,v01.disponent_id
        ,v01.system_id
        ,v01.pps_plan_kalender_id
        ,v01.disposition_rhythmus_id
        ,v01.planlieferzeit
        ,v01.dispomerkmal
        ,v01.we_bearbeitungszeit
        ,v01.min_sicherh_bestand
        ,v01.anliefer_kalender
        ,v01.kdis
        ,v01.bezugsweg_id
        ,v01.terminierungsgruppe_1_id
        ,v01.terminierungsgruppe_2_id
        ,v01.terminierungsgruppe_3_id
        ,v01.dat_loesch_id
        ,v03.dat;