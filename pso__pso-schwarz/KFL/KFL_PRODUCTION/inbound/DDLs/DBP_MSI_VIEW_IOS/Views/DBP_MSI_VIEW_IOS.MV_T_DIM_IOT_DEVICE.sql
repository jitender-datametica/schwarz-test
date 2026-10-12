CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_T_DIM_IOT_DEVICE
-- 20200619 SPEC0074701 sanadze: Initialisierung 
(
    device_id
    , device_number
    , device_model
    , device_location
) 
AS
SELECT  
    v01.device_id
    , v01.device_number
    , v01.device_model
    , v01.device_location
FROM  dbp_view.v_t_dim_iot_device v01;