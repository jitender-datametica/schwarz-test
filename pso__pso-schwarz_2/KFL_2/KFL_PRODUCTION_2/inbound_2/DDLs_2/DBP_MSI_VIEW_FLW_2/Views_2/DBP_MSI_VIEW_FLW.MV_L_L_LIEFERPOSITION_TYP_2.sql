CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_L_LIEFERPOSITION_TYP_2
-- 26.10.2011 system_id entfernt
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
-- ,system_id
,lief_pos_typ_id
)
AS

   SELECT v01.mandant_id, v01.lief_pos_typ_id

   FROM dbp_view.v_flw_l_lieferpos_typ_2 v01;