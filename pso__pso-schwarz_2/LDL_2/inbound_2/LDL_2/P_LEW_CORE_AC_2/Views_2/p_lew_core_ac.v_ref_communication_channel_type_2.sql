CREATE OR REPLACE VIEW p_lew_core_ac.v_ref_communication_channel_type_2
(
 comm_channel_type_cd
,comm_channel_type_descr
,dwh_load_id
,dwh_created
,dwh_updated
)
AS
SELECT
comm_channel_type_cd,
comm_channel_type_descr,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_core.t_ref_communication_channel_type_2
;



