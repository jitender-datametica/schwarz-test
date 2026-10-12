CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_CROSSDOCKING
(
 mandant_id
,crossdocking_id
)
AS
 SELECT 
 mandant_id
,crossdocking_id 
 FROM dbp_data.l_crossdocking
 WHERE mandant_id <> 1;