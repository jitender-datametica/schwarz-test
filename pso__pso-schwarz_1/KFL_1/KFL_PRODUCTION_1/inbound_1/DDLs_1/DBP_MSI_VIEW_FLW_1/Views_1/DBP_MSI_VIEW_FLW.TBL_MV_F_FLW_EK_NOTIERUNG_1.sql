CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_EK_NOTIERUNG_1
-- 26.10.2011 system_id entfernt
-- 19.04.2022 EK_NOTIERUNG_ID ist nun die FLW_ART_ID 
--            -> Im SQL Umbenannt damit wir im FE nichts umstellen müssen.
(
mandant_id
--, system_id
, ek_notierung_id
, dat
, plan_fg
, pjwo
, default_wrg
, wrg_id
, betrag

)
AS
   SELECT
   v01.mandant_id, 
   v01.FLW_ART_ID AS ek_notierung_id, 
   v01.dat, 
   v01.plan_fg, 
   v01.pjwo,
   v100.default_wrg,
   v01.wrg_id,
   v01.betrag

   FROM dbp_view.v_flw_ek_notierung_1 v01

   JOIN dbp_view.v_mandant_1 v100
   ON v01.mandant_id = v100.mandant_id;