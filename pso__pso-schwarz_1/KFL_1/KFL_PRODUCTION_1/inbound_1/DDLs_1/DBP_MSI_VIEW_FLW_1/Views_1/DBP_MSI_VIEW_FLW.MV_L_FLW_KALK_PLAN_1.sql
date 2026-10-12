CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_KALK_PLAN_1
-- 26.10.2011 system_id entfernt
(
mandant_id
--,system_id
,plan_kalk_id
,schnittliste_id
,werk_id
,dat_kalk_ab
,dat_kalk_bis
,fortgesch_kalk_fg
,kalk_variante_id
)
AS
   SELECT mandant_id, plan_kalk_id, schnittliste_id, werk_id, dat_kalk_ab, dat_kalk_bis, fortgesch_kalk_fg, kalk_variante_id
   FROM dbp_view.v_flw_kalk_plan_1;