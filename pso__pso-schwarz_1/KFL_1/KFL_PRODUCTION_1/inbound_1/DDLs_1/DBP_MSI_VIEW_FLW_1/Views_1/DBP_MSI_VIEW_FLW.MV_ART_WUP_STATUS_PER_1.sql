CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_ART_WUP_STATUS_PER_1
-- 10.01.2013 twie: Filterung auf mandant_id 1,2 wegen Projekt SAKO
(
art_id
,mandant_id
,wup_id
,nb_id
,dat
,loesch_id
,wg_verkett_id
,fremd_lagerort_id
,disponent_id
,pps_plan_kalender_id
,disposition_rhythmus_id
,planlieferzeit
,dispomerkmal
,we_bearbeitungszeit
,min_sicherh_bestand
,anliefer_kalender
,kdis
,bezugsweg_id

)
AS
   SELECT

   v01.art_id, v01.mandant_id, v01.wup_id, v01.nb_id, t.dat, v01.loesch_id, v01.wg_verkett_id, v01.fremd_lagerort_id, v01.disponent_id, v01.pps_plan_kalender_id, v01.disposition_rhythmus_id, v01.planlieferzeit, v01.dispomerkmal, v01.we_bearbeitungszeit, v01.min_sicherh_bestand, v01.anliefer_kalender, v01.kdis, v01.bezugsweg_id

   FROM dbp_view.v_art_wup_status_per_1   v01

   JOIN dbp_view.v_tag_1 t
   ON t.dat BETWEEN v01.dat_von AND v01.dat_bis
   
   WHERE v01.mandant_id IN (1,2);