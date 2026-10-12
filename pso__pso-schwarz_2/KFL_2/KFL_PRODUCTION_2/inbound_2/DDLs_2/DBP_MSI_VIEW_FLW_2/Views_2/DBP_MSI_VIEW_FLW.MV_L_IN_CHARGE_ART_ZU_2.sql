CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_CHARGE_ART_ZU_2
-- 26.10.2011 system_id entfernt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 29.05.2019 pjan1603: SPEC0045510 added objekt_nummer_id column from joined table flw_charge_art_objekt_zu_2

(
mandant_id
,in_art_id
,charge_id
,objekt_nummer_id
)
AS
   SELECT

   v01.mandant_id, v01.flw_art_id AS in_art_id, v01.charge_id, v02.objekt_nummer_id

   FROM dbp_view.v_flw_charge_art_zu_2 v01
   LEFT JOIN dbp_view.v_flw_charge_art_objekt_zu_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.objekt_schluessel_id = v02.objekt_schluessel_id;