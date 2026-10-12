CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_ZAEHLER_1
-- 26.10.2011 system_id entfernt
(
mandant_id
--,system_id
,zaehler_id
,zaehlerart
--,einh_id
)

AS

   SELECT
   v01.mandant_id, v01.zaehler_id, trim(v01.zaehlerart)
   --,v01.einh_id
   FROM
   dbp_view.v_flw_l_zaehler_1 v01;