CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ART_WUP_STATUS_PER
-- 24.08.2017, AP0018098 - Disporhythmus, srom0404, Erweiterung Terminierungsgruppen
-- 24.01.2020, nw +selbstabholung_fg
-- 05.02.2020, baranowska, SPEC0070027, adding min_restlaufzeit
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
,terminierungsgruppe_1_id
,terminierungsgruppe_2_id
,terminierungsgruppe_3_id
,selbstabholung_fg
,min_restlaufzeit
)
AS
   SELECT
  v01.art_id, v01.dat_bis, v01.dat_von, v01.loesch_id, v01.mandant_id, v01.nb_id, v01.wup_id, v01.wg_verkett_id, v01.fremd_lagerort_id, v01.disponent_id, v01.system_id, v01.pps_plan_kalender_id, v01.disposition_rhythmus_id, v01.planlieferzeit, v01.dispomerkmal, v01.we_bearbeitungszeit, v01.min_sicherh_bestand, v01.anliefer_kalender, v01.terminierungsgruppe_1_id, v01.terminierungsgruppe_2_id, v01.terminierungsgruppe_3_id, v01.selbstabholung_fg, v01.min_restlaufzeit
   FROM dbp_view.v_art_wup_status_per v01
   WHERE dat_bis = DATE '9999-12-31' AND nb_id = -111;