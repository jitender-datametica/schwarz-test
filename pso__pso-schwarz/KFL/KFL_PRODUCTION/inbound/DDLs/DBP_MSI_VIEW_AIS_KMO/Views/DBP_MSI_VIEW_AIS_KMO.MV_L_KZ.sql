CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_KZ

AS

SELECT 
mandant_id
,0 as kz_id
FROM dbp_view.v_mandant
WHERE mandant_id<>1

UNION ALL

SELECT 
mandant_id
,1 as kz_id
FROM dbp_view.v_mandant
WHERE mandant_id<>1;