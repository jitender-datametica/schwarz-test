CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_OUG_ID
AS 
SELECT 
oug_id 
FROM dbp_view.v_l_oug_id
WHERE mandant_id = 1

UNION ALL

SELECT 
CAST(0 AS NUMBER(38,0)) AS oug_id
FROM dbp_view.v_mandant
WHERE mandant_id = 1;