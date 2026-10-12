CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_OUG_ID_SPR_ZU_1

AS 

SELECT 
oug_id 
,oug_id_bez
FROM dbp_view.v_oug_id_spr_zu_1
WHERE mandant_id = 1
AND spr_id = 22

UNION ALL

SELECT
0
,'nicht gepflegt'
FROM dbp_view.v_mandant_1
WHERE mandant_id = 1;