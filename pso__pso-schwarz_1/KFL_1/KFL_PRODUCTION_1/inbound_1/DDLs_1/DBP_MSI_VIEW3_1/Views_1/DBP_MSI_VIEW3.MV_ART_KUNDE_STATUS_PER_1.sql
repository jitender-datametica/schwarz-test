CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ART_KUNDE_STATUS_PER_1(
	ART_ID,
	DAT_BIS,
	DAT_VON,
	MANDANT_ID,
	NB_ID,
	KUNDE_ID,
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
	MANDANT_ID_KUNDE,
	TERMINIERUNGSGRUPPE_1_ID,
	TERMINIERUNGSGRUPPE_2_ID,
	TERMINIERUNGSGRUPPE_3_ID
) AS
--2024-07-23,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
   SELECT
   v01.art_id
  ,v01.dat_bis
  ,v01.dat_von
  ,v01.mandant_id
  ,v01.nb_id
  --,v01.wup_id
  --,CASE WHEN TRY_CAST(v01.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END kunde_id
  ,v05.aktuell_wup_id
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
  ,v01.mandant_id
  ,v01.terminierungsgruppe_1_id
  ,v01.terminierungsgruppe_2_id
  ,v01.terminierungsgruppe_3_id
   FROM dbp_view.v_art_wup_status_per_1 v01
   INNER JOIN dbp_view.v_wup_1 v05
   ON v05.mandant_id = v01.mandant_id
   --AND v05.wup_id = CASE WHEN TRY_CAST(v01.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(v01.wup_id AS INTEGER) END
   AND v05.wup_id = v01.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

   WHERE v01.dat_bis = DATE '9999-12-31' AND v01.nb_id = 0;