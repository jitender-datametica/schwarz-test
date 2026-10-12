CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_L_VW
-- 26.10.2011 system_id entfernt
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--,system_id
,in_vw_id
)
AS
   SELECT mandant_id, flw_vw_id AS in_vw_id

   FROM dbp_view.v_flw_l_vw;