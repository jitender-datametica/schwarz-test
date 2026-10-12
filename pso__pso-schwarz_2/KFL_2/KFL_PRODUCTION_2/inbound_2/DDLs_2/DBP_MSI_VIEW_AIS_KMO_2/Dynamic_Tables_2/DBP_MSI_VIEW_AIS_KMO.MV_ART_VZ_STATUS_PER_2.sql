CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_ART_VZ_STATUS_PER_2
-- sschuecke 20.02.2014 separate Views für VZ und Markt
--SPEC0078143, adding selbstabholung_fg, 04.06.2020, baranowska
(
 art_id
,dat_bis
,dat_von
,loesch_id
,mandant_id
,nb_id
,wup_id
,wg_verkett_id
,fremd_lagerort_id
,disponent_id
,system_id
,pps_plan_kalender_id
,disposition_rhythmus_id
,planlieferzeit
,dispomerkmal
,we_bearbeitungszeit
,min_sicherh_bestand
,anliefer_kalender
,selbstabholung_fg
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
   p.art_id,
   p.dat_bis,
   p.dat_von,
   CASE WHEN p.loesch_id = '' THEN a.loesch_id ELSE p.loesch_id END,
   p.mandant_id,
   nb_id,
   wup_id,
   p.wg_verkett_id,
   p.fremd_lagerort_id,
   p.disponent_id,
   p.system_id,
   p.pps_plan_kalender_id,
   p.disposition_rhythmus_id,
   p.planlieferzeit,
   p.dispomerkmal,
   p.we_bearbeitungszeit,
   p.min_sicherh_bestand,
   p.anliefer_kalender,
   p.selbstabholung_fg
   FROM dbp_view.v_art_wup_status_per_2 p
   INNER JOIN dbp_view.v_art_2 a
   ON a.art_id = p.art_id
   AND a.mandant_id = p.mandant_id
   WHERE p.dat_bis = '9999-12-31'
   AND p.mandant_id <> 1
   -- 20100330 Filterung der IWT Betriebe
   AND p.nb_id = -111;