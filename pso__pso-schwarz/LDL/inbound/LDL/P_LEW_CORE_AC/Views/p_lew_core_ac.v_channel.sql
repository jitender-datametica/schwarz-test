CREATE OR REPLACE VIEW p_lew_core_ac.v_channel
(
 client_id
,channel_sid
,src_srcinst_cd
,src_advmed_id
,src_salestype_value
,channel_type_cd
,comm_channel_type_cd
,dwh_load_id
,dwh_created
,dwh_updated
)
AS
SELECT
client_id,
channel_sid,
src_srcinst_cd,
src_advmed_id,
src_salestype_value,
channel_type_cd,
comm_channel_type_cd,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_core.t_channel
;




