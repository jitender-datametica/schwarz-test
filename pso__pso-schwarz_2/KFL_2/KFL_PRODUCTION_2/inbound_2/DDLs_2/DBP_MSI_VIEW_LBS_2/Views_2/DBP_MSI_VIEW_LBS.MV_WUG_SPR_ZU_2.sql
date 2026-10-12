CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_WUG_SPR_ZU_2(
	MANDANT_ID,
	WG_ID,
	WUG_ID,
	ARTHIERTYP_ID,
	WUG_BEZ,
	WUG_BEZ_DE,
	WUG_BEZ_CZ,
	WUG_BEZ_SK,
	WUG_BEZ_HR,
	WUG_BEZ_PL,
	WUG_BEZ_RO,
	WUG_BEZ_BG
) AS SELECT
    v01.mandant_id
    ,v01.wg_id
    ,v01.wug_id
    ,v01.arthiertyp_id
    ,COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.wug_bez END),'N/A') AS wug_bez           -- Standard == DE
    ,COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.wug_bez END),'N/A') AS wug_bez_de        -- DE
    ,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.wug_bez END), wug_bez_de) AS wug_bez_cz   -- CZ
    ,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.wug_bez END), wug_bez_de) AS wug_bez_sk   -- SK
    ,COALESCE(MAX(CASE WHEN v01.spr_id =  65  THEN v01.wug_bez END), wug_bez_de) AS wug_bez_hr  -- HR
    ,COALESCE(MAX(CASE WHEN v01.spr_id =  90  THEN v01.wug_bez END), wug_bez_de) AS wug_bez_pl  -- PL
    ,COALESCE(MAX(CASE WHEN v01.spr_id =  95  THEN v01.wug_bez END), wug_bez_de) AS wug_bez_ro  -- RO
    ,COALESCE(MAX(CASE WHEN v01.spr_id =  18  THEN v01.wug_bez END), wug_bez_de) AS wug_bez_bg  -- BG
FROM dbp_view.v_wug_spr_zu_2 v01
WHERE v01.arthiertyp_id = 2
GROUP BY 1,2,3,4;