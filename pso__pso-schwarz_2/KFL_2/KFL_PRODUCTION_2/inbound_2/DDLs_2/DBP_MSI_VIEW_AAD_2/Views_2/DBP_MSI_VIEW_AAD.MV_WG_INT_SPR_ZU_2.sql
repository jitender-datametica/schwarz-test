CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_WG_INT_SPR_ZU_2 AS
--10.07.2023 snik: SPEC0202038 WG SPR_ZU
SELECT DISTINCT
  wg.arthiertyp_id
, wg.wg_id
,COALESCE(MAX(CASE WHEN wg.spr_id =  22  THEN wg.wg_bez END),'N/A') 		AS wg_bez                      
,COALESCE(MAX(CASE WHEN wg.spr_id =  22  THEN wg.wg_bez END),'N/A')			AS wg_bez_DE                
,COALESCE(MAX(CASE WHEN wg.spr_id = 124  THEN wg.wg_bez END), wg_bez_DE)	AS wg_bez_CZ
,COALESCE(MAX(CASE WHEN wg.spr_id = 108  THEN wg.wg_bez END), wg_bez_DE)	AS wg_bez_SK
,COALESCE(MAX(CASE WHEN wg.spr_id =  65  THEN wg.wg_bez END), wg_bez_DE)	AS wg_bez_HR
,COALESCE(MAX(CASE WHEN wg.spr_id =  90  THEN wg.wg_bez END), wg_bez_DE)	AS wg_bez_PL
,COALESCE(MAX(CASE WHEN wg.spr_id =  95  THEN wg.wg_bez END), wg_bez_DE)	AS wg_bez_RO
,COALESCE(MAX(CASE WHEN wg.spr_id =  18  THEN wg.wg_bez END), wg_bez_DE)	AS wg_bez_BG
FROM dbp_view.v_wg_spr_zu_2  wg
WHERE wg.arthiertyp_id = 2
GROUP BY arthiertyp_id, wg_id;