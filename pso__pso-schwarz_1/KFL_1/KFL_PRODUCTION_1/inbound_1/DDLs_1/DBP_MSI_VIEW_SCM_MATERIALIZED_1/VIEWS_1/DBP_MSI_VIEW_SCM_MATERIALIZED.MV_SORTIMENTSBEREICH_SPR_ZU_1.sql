create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_SORTIMENTSBEREICH_SPR_ZU_1(
	SORTIMENTSBEREICH_ID,
	SORTIMENTSBEREICH_BEZ,
	SORTIMENTSBEREICH_BEZ_DE,
	SORTIMENTSBEREICH_BEZ_CZ,
	SORTIMENTSBEREICH_BEZ_SK,
	SORTIMENTSBEREICH_BEZ_HR,
	SORTIMENTSBEREICH_BEZ_PL,
	SORTIMENTSBEREICH_BEZ_RO,
	SSORTIMENTSBEREICH_BEZ_BG
) as
--2024-03-22, AP0212955, SPEC0242926, dknop, initial
SELECT 
 WG_HIERARCHIE_ID AS sortimentsbereich_id
--use spr_1 ID 22 as fallback for all languages if local language is not maintained (which is currently the case)
,MAX(CASE WHEN spr_id=22 THEN WG_HIERARCHIE_bez END) AS sortimentsbereich_bez
,MAX(CASE WHEN spr_id=22 THEN WG_HIERARCHIE_bez END) AS sortimentsbereich_bez_de
-- _de / _pl / etc. -> different for LIS
,COALESCE(MAX(CASE WHEN spr_id = 124 THEN WG_HIERARCHIE_bez END), sortimentsbereich_bez_de ) AS sortimentsbereich_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN spr_id = 108 THEN WG_HIERARCHIE_bez END), sortimentsbereich_bez_de ) AS sortimentsbereich_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN spr_id =  65 THEN WG_HIERARCHIE_bez END), sortimentsbereich_bez_de ) AS sortimentsbereich_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN spr_id =  90 THEN WG_HIERARCHIE_bez END), sortimentsbereich_bez_de ) AS sortimentsbereich_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN spr_id =  95 THEN WG_HIERARCHIE_bez END), sortimentsbereich_bez_de ) AS sortimentsbereich_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN spr_id =  18 THEN WG_HIERARCHIE_bez END), sortimentsbereich_bez_de ) AS ssortimentsbereich_bez_bg    -- BG

FROM dbp_view.v_WG_HIERARCHIE_SPR_ZU_1 WHERE  ARTHIERTYP_ID=13 AND WG_HIERARCHIE_EBENE_ID=1
GROUP BY WG_HIERARCHIE_ID

UNION
--missing WG_HIERARCHIE_ID='-1'
SELECT
 -1
,'Keine Zuordnung'
,'Keine Zuordnung'
,'Keine Zuordnung'
,'Keine Zuordnung'
,'Keine Zuordnung'
,'Keine Zuordnung'
,'Keine Zuordnung'
,'Keine Zuordnung';