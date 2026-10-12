CREATE OR REPLACE VIEW p_lew_core_ac.v_ref_plan_status_1
(
 plan_status_cd
,plan_status_descr
,dwh_load_id
,dwh_created
,dwh_updated
)
AS
SELECT
plan_status_cd,
plan_status_descr,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_core.t_ref_plan_status_1
;



