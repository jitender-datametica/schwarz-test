CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ART_LIEF_WERK_STATUS_PER_1
(
art_id
,dat_bis
,dat_von
,loesch_id
,mandant_id
,lieferndeswerk_nb_id
,lieferndeswerk
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
)
AS
   SELECT
  art_id, dat_bis, dat_von, loesch_id, mandant_id, nb_id, wup_id, wg_verkett_id, fremd_lagerort_id, disponent_id, system_id, pps_plan_kalender_id, disposition_rhythmus_id, planlieferzeit, dispomerkmal, we_bearbeitungszeit, min_sicherh_bestand, anliefer_kalender
   FROM dbp_view.v_art_wup_status_per_1
   WHERE dat_bis = DATE '9999-12-31' and nb_id = -111;