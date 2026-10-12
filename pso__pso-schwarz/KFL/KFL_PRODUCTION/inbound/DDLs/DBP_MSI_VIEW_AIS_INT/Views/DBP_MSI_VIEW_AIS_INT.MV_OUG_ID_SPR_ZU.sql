CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_OUG_ID_SPR_ZU
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 24.01.2022
(
 mandant_id
,oug_id
,oug_id_bez
,oug_id_bez_de
,oug_id_bez_cz
,oug_id_bez_sk
,oug_id_bez_hr
,oug_id_bez_pl
,oug_id_bez_ro
,oug_id_bez_bg
)
AS
SELECT DISTINCT
 mandant_id
,oug_id
, Coalesce(Max(CASE WHEN spr_id =  22  THEN oug_id_bez END),'N/A') AS oug_id_bez   
, Coalesce(Max(CASE WHEN spr_id =  22  THEN oug_id_bez END),'N/A') AS oug_id_bez_de       
, Coalesce(Max(CASE WHEN spr_id = 124 THEN oug_id_bez END), oug_id_bez_de) AS oug_id_bez_cz  
, Coalesce(Max(CASE WHEN spr_id = 108 THEN oug_id_bez END), oug_id_bez_de) AS oug_id_bez_sk 
, Coalesce(Max(CASE WHEN spr_id =  65  THEN oug_id_bez END), oug_id_bez_de) AS oug_id_bez_hr    
, Coalesce(Max(CASE WHEN spr_id =  90  THEN oug_id_bez END), oug_id_bez_de) AS oug_id_bez_pl    
, Coalesce(Max(CASE WHEN spr_id =  95  THEN oug_id_bez END), oug_id_bez_de) AS oug_id_bez_ro   
, Coalesce(Max(CASE WHEN spr_id =  18  THEN oug_id_bez END), oug_id_bez_de) AS oug_id_bez_bg  
FROM DBP_VIEW.V_OUG_ID_SPR_ZU
GROUP BY
 mandant_id
,oug_id

UNION ALL

SELECT DISTINCT
 mandant_id
,0 AS oug_id
,'nicht gepflegt' AS oug_id_bez
,'nicht gepflegt' AS oug_id_bez_de
,'žádné specifikace' AS oug_id_bez_cz
,'žiadne špecifikácie' AS oug_id_bez_sk
,'nema specifikacija' AS oug_id_bez_hr
,'bez specyfikacji' AS oug_id_bez_pl
,'fara precizare' AS oug_id_bez_ro
,'без спецификация' AS oug_id_bez_bg
FROM dbp_view.v_mandant_spr_zu;