create or replace view DBP_MSI_VIEW_IOS_MATERIALIZED.MV_T_DIM_IOT_DEVICE_1(
	DEVICE_ID,
	DEVICE_NUMBER,
	DEVICE_MODEL,
	DEVICE_LOCATION
) as
SELECT  
    v01.device_id
    , v01.device_number
    , v01.device_model
    , v01.device_location
FROM  dbp_view.v_t_dim_iot_device_1 v01;