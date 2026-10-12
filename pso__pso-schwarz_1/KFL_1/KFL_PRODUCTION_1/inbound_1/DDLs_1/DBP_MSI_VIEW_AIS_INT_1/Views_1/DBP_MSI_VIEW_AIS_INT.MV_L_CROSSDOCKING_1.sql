CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_CROSSDOCKING_1
(
 mandant_id
,crossdocking_id
)
AS
 SELECT 
 mandant_id
,crossdocking_id 
 FROM dbp_data.l_crossdocking_1;