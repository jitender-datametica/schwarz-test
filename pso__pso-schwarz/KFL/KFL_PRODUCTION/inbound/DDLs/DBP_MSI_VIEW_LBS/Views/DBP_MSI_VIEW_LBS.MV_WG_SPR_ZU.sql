CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_WG_SPR_ZU(
	MANDANT_ID,
	WG_ID,
	ARTHIERTYP_ID,
	WG_BEZ,
	WG_BEZ_DE,
	WG_BEZ_CZ,
	WG_BEZ_SK,
	WG_BEZ_HR,
	WG_BEZ_PL,
	WG_BEZ_RO,
	WG_BEZ_BG
) AS SELECT
   v01.mandant_id
   ,v01.wg_id
   ,v01.arthiertyp_id
   ,Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.wg_bez END),'N/A') AS wg_bez              -- Standard == DE
   ,Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.wg_bez END),'N/A') AS wg_bez_de          -- DE
   ,Coalesce(Max(CASE WHEN v01.spr_id = 124 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_cz      -- CZ
   ,Coalesce(Max(CASE WHEN v01.spr_id = 108 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_sk      -- SK
   ,Coalesce(Max(CASE WHEN v01.spr_id =  65  THEN v01.wg_bez END), wg_bez_de) AS wg_bez_hr     -- HR
   ,Coalesce(Max(CASE WHEN v01.spr_id =  90  THEN v01.wg_bez END), wg_bez_de) AS wg_bez_pl     -- PL
   ,Coalesce(Max(CASE WHEN v01.spr_id =  95  THEN v01.wg_bez END), wg_bez_de) AS wg_bez_ro     -- RO
   ,Coalesce(Max(CASE WHEN v01.spr_id =  18  THEN v01.wg_bez END), wg_bez_de) AS wg_bez_bg     -- BG
FROM dbp_view.v_wg_spr_zu v01
WHERE v01.arthiertyp_id = 2
GROUP BY 1,2,3;