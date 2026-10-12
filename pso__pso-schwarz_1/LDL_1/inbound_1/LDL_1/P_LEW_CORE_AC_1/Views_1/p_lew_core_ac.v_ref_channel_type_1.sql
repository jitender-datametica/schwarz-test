CREATE OR REPLACE VIEW p_lew_core_ac.v_ref_channel_type_1
(
 channel_type_cd
,channel_type_descr
,dwh_load_id
,dwh_created
,dwh_updated
)
AS
SELECT
channel_type_cd,
channel_type_descr,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_core.t_ref_channel_type_1
;




