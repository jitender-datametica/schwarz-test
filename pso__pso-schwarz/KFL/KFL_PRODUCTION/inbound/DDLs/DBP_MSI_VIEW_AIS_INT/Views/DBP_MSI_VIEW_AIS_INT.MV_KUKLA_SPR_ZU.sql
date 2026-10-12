create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_AIS_INT.MV_KUKLA_SPR_ZU(
	MANDANT_ID,
	KUKLA_ID,
	KUKLA_BEZ,
	KUKLA_BEZ_DE,
	KUKLA_BEZ_CZ,
	KUKLA_BEZ_SK,
	KUKLA_BEZ_HR,
	KUKLA_BEZ_PL,
	KUKLA_BEZ_RO,
	KUKLA_BEZ_BG
) as
SELECT
v01.mandant_id
,v01.kukla_id
,COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.kukla_bez END),'N/A') AS kukla_bez   -- Standard == DE               
,COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.kukla_bez END),'N/A') AS kukla_bez_de                              
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.kukla_bez END), kukla_bez_de) AS kukla_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.kukla_bez END), kukla_bez_de) AS kukla_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65  THEN v01.kukla_bez END), kukla_bez_de) AS kukla_bez_hr     -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90  THEN v01.kukla_bez END), kukla_bez_de) AS kukla_bez_pl     -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95  THEN v01.kukla_bez END), kukla_bez_de) AS kukla_bez_ro     -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18  THEN v01.kukla_bez END), kukla_bez_de) AS kukla_bez_bg    -- BG
FROM dbp_data.kukla_spr_zu v01
GROUP BY v01.mandant_id
,v01.kukla_id;
