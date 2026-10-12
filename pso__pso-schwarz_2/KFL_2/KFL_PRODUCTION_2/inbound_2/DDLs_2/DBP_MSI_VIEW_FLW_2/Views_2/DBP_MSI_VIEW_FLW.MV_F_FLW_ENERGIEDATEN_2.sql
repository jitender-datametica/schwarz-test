CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_ENERGIEDATEN_2
-- 26.10.2011 system_id entfernt
(
mandant_id
--,system_id
,zaehler_id
,dat
,kjmo
,pc_id
,krk_id
,menge_verbraucht
)
AS

   SELECT
   v01.mandant_id, v01.zaehler_id, v01.dat, v01.kjmo, v01.pc_id, v01.krk_id, v01.menge_verbrauch
   FROM dbp_view.v_flw_energiedaten_2 v01;