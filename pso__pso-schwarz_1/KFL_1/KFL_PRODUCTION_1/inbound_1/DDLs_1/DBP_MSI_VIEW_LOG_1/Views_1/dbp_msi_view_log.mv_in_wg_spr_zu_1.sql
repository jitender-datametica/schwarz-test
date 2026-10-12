CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_WG_SPR_ZU_1(
	MANDANT_ID,
	IN_WG_ID,
	IN_WG_BEZ,
	IN_WG_BEZ_DE,
	IN_WG_BEZ_CZ,
	IN_WG_BEZ_SK,
	IN_WG_BEZ_HR,
	IN_WG_BEZ_PL,
	IN_WG_BEZ_RO,
	IN_WG_BEZ_BG,
	IN_WG_BEZ_LANG,
	IN_WG_BEZ_LANG_DE,
	IN_WG_BEZ_LANG_CZ,
	IN_WG_BEZ_LANG_SK,
	IN_WG_BEZ_LANG_HR,
	IN_WG_BEZ_LANG_PL,
	IN_WG_BEZ_LANG_RO,
	IN_WG_BEZ_LANG_BG
) AS
--AP0133256_SPEC0166769, dknop, initial
--2023-02-16, AP0133256_SPEC0166769, dknop, adding in_wg_bez_lang
SELECT
 v01.mandant_id
,v01.in_wg_id
,MAX(CASE WHEN v01.spr_id =  22 THEN v01.in_wg_bez END) AS in_wg_bez                 -- standard == DE
,MAX(CASE WHEN v01.spr_id =  22 THEN v01.in_wg_bez END) AS in_wg_bez_de                       -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.in_wg_bez END), in_wg_bez_de) AS in_wg_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.in_wg_bez END), in_wg_bez_de) AS in_wg_bez_sk   -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.in_wg_bez END), in_wg_bez_de) AS in_wg_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.in_wg_bez END), in_wg_bez_de) AS in_wg_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.in_wg_bez END), in_wg_bez_de) AS in_wg_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.in_wg_bez END), in_wg_bez_de) AS in_wg_bez_bg    -- BG
,MAX(CASE WHEN v01.spr_id =  22 THEN v01.in_wg_bez_lang  END) AS in_wg_bez_lang                 -- standard == DE
,MAX(CASE WHEN v01.spr_id =  22 THEN v01.in_wg_bez_lang  END) AS in_wg_bez_lang_de                       -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.in_wg_bez_lang  END), in_wg_bez_lang_de) AS in_wg_bez_lang_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.in_wg_bez_lang  END), in_wg_bez_lang_de) AS in_wg_bez_lang_sk   -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.in_wg_bez_lang  END), in_wg_bez_lang_de) AS in_wg_bez_lang_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.in_wg_bez_lang  END), in_wg_bez_lang_de) AS in_wg_bez_lang_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.in_wg_bez_lang  END), in_wg_bez_lang_de) AS in_wg_bez_lang_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.in_wg_bez_lang  END), in_wg_bez_lang_de) AS in_wg_bez_lang_bg    -- BG

FROM dbp_view.v_in_wg_spr_zu_1 v01
GROUP BY v01.mandant_id
        ,v01.in_wg_id;