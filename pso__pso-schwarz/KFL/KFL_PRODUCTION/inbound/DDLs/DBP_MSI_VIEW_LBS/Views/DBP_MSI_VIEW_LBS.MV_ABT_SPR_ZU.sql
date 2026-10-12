CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_ABT_SPR_ZU(
	MANDANT_ID,
	ABT_ID,
	ARTHIERTYP_ID,
	ABT_BEZ,
	ABT_BEZ_DE,
	ABT_BEZ_CZ,
	ABT_BEZ_SK,
	ABT_BEZ_HR,
	ABT_BEZ_PL,
	ABT_BEZ_RO,
	ABT_BEZ_BG
) AS SELECT
    v01.mandant_id
    ,v01.abt_id
    ,v01.arthiertyp_id
    ,COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.abt_bez END),'N/A') AS abt_bez               -- Standard == DE
    ,COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.abt_bez END),'N/A') AS abt_bez_de            -- DE
    ,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.abt_bez END), abt_bez_de) AS abt_bez_cz       -- CZ
    ,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.abt_bez END), abt_bez_de) AS abt_bez_sk       -- SK
    ,COALESCE(MAX(CASE WHEN v01.spr_id =  65  THEN v01.abt_bez END), abt_bez_de) AS abt_bez_hr      -- HR
    ,COALESCE(MAX(CASE WHEN v01.spr_id =  90  THEN v01.abt_bez END), abt_bez_de) AS abt_bez_pl      -- PL
    ,COALESCE(MAX(CASE WHEN v01.spr_id =  95  THEN v01.abt_bez END), abt_bez_de) AS abt_bez_ro      -- RO
    ,COALESCE(MAX(CASE WHEN v01.spr_id =  18  THEN v01.abt_bez END), abt_bez_de) AS abt_bez_bg      -- BG
FROM dbp_view.v_abt_spr_zu v01
WHERE v01.arthiertyp_id = 2
GROUP BY 1,2,3;