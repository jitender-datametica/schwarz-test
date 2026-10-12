CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_OUG_ID_2
AS
SELECT
mandant_id
,oug_id
FROM dbp_view.v_l_oug_id_2
WHERE mandant_id <> 1
UNION ALL
SELECT 
mandant_id
,CAST(0 AS NUMBER(38,0)) AS oug_id
FROM dbp_view.v_mandant_2
WHERE mandant_id <> 1;