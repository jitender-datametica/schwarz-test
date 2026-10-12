CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SHR_KENNZAHLEN
(
mandant_id
, kjmo
, hr_objekt_id
, anz_kopf_ist
, anz_kopf_vj
, anz_kopf_gjkum_ist
, anz_kopf_gjkum_vj
, abr_stunden_mo_ist
, abr_stunden_mo_vj
, abwesenheit_tage_ist
, abwesenheit_tage_vj
, abwesenheit_tage_gjkum_ist
, abwesenheit_tage_gjkum_vj
, soll_stunden_mo_ist
, soll_stunden_mo_vj
, soll_stunden_mo_an_ist
, soll_stunden_mo_an_vj
, soll_stunden_mo_ag_ist
, soll_stunden_mo_ag_vj
, soll_stunden_mo_gjkum_ist
, soll_stunden_mo_gjkum_vj
, soll_stunden_mo_an_gjkum_ist
, soll_stunden_mo_an_gjkum_vj
, soll_stunden_mo_ag_gjkum_ist
, soll_stunden_mo_ag_gjkum_vj
, shr_freigabe_fg
)
AS
   SELECT
   v01.mandant_id, v01.kjmo, v01.hr_objekt_id, v01.anz_kopf_ist, v01.anz_kopf_vj, v01.anz_kopf_gjkum_ist, v01.anz_kopf_gjkum_vj, v01.abr_stunden_mo_ist, v01.abr_stunden_mo_vj, v01.abwesenheit_tage_ist, v01.abwesenheit_tage_vj, v01.abwesenheit_tage_gjkum_ist, v01.abwesenheit_tage_gjkum_vj, v01.soll_stunden_mo_ist, v01.soll_stunden_mo_vj, v01.soll_stunden_mo_an_ist, v01.soll_stunden_mo_an_vj, v01.soll_stunden_mo_ag_ist, v01.soll_stunden_mo_ag_vj, v01.soll_stunden_mo_gjkum_ist, v01.soll_stunden_mo_gjkum_vj, v01.soll_stunden_mo_an_gjkum_ist, v01.soll_stunden_mo_an_gjkum_vj, v01.soll_stunden_mo_ag_gjkum_ist, v01.soll_stunden_mo_ag_gjkum_vj, v01.shr_freigabe_fg

   FROM dbp_view.v_shr_kennzahlen v01;