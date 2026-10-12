create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_SORTIMENTSGRUPPE_SPR_ZU_1(
	SORTIMENTSGRUPPE_ID,
	SORTIMENTSGRUPPE_BEZ,
	SORTIMENTSGRUPPE_BEZ_DE,
	SORTIMENTSGRUPPE_BEZ_CZ,
	SORTIMENTSGRUPPE_BEZ_SK,
	SORTIMENTSGRUPPE_BEZ_HR,
	SORTIMENTSGRUPPE_BEZ_PL,
	SORTIMENTSGRUPPE_BEZ_RO,
	SORTIMENTSGRUPPE_BEZ_BG
) as
--2023-08-07, AP0182383, SPEC0207712, dknop, initial
SELECT 
 WG_HIERARCHIE_ID AS sortimentsgruppe_id
--use spr_1 ID 22 as fallback for all languages if local language is not maintained (which is currently the case)
,MAX(CASE WHEN spr_id=22 THEN WG_HIERARCHIE_bez END) AS sortimentsgruppe_bez
,MAX(CASE WHEN spr_id=22 THEN WG_HIERARCHIE_bez END) AS sortimentsgruppe_bez_de
-- _de / _pl / etc. -> different for LIS
,COALESCE(MAX(CASE WHEN spr_id = 124 THEN WG_HIERARCHIE_bez END), sortimentsgruppe_bez_de ) AS sortimentsgruppe_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN spr_id = 108 THEN WG_HIERARCHIE_bez END), sortimentsgruppe_bez_de ) AS sortimentsgruppe_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN spr_id =  65 THEN WG_HIERARCHIE_bez END), sortimentsgruppe_bez_de ) AS sortimentsgruppe_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN spr_id =  90 THEN WG_HIERARCHIE_bez END), sortimentsgruppe_bez_de ) AS sortimentsgruppe_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN spr_id =  95 THEN WG_HIERARCHIE_bez END), sortimentsgruppe_bez_de ) AS sortimentsgruppe_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN spr_id =  18 THEN WG_HIERARCHIE_bez END), sortimentsgruppe_bez_de ) AS sortimentsgruppe_bez_bg    -- BG

FROM dbp_view.v_WG_HIERARCHIE_SPR_ZU_1 WHERE  ARTHIERTYP_ID=11 AND WG_HIERARCHIE_EBENE_ID=1
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