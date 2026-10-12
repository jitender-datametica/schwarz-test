CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_ART_WUP_STATUS_PER_2
--SPEC0034860, Erweiterung um Sollbestand, 04.07.2018, mkub1811
--SPEC0070027, adding min_restlaufzeit, 05.02.2020, baranowska
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
,sollbestand
,min_restlaufzeit
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
    v01.art_id,
   v01.dat_bis,
   v01.dat_von,
   CASE WHEN v01.loesch_id = '' THEN v02.loesch_id ELSE v01.loesch_id END,
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
   v01.sollbestand,
   v01.min_restlaufzeit
   FROM dbp_view.v_art_wup_status_per_2 v01
   INNER JOIN dbp_view.v_art_2 v02
   ON  v02.art_id = v01.art_id
   AND v02.mandant_id = v01.mandant_id
   WHERE v01.dat_bis = DATE '9999-12-31'
   AND v01.mandant_id > 1
   -- Filterung der IWT Betriebe
   AND v01.nb_id = 0;