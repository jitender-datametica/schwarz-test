CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_HWG_SPR_ZU_2(
	HWG_ID,
	HWG_BEZ,
	HWG_BEZ_DE,
	HWG_BEZ_CZ,
	HWG_BEZ_SK,
	HWG_BEZ_HR,
	HWG_BEZ_PL,
	HWG_BEZ_RO,
	HWG_BEZ_BG,
	MANDANT_ID,
	ARTHIERTYP_ID,
	ABT_ID
) AS SELECT
   v01.hwg_id, COALESCE(MAX(CASE WHEN v02.spr_id =  22  THEN v02.hwg_bez END),'N/A') AS hwg_bez     -- Standard == DE
   , COALESCE(MAX(CASE WHEN v02.spr_id =  22   THEN v02.hwg_bez END),'N/A') AS hwg_bez_de           -- DE
   , COALESCE(MAX(CASE WHEN v02.spr_id = 124   THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_cz     -- CZ
   , COALESCE(MAX(CASE WHEN v02.spr_id = 108   THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_sk     -- SK
   , COALESCE(MAX(CASE WHEN v02.spr_id =  65   THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_hr     -- HR
   , COALESCE(MAX(CASE WHEN v02.spr_id =  90   THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_pl     -- PL
   , COALESCE(MAX(CASE WHEN v02.spr_id =  95   THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_ro     -- RO
   , COALESCE(MAX(CASE WHEN v02.spr_id =  18   THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_bg     -- BG
   , v01.mandant_id, v01.arthiertyp_id, v01.abt_id
FROM dbp_view.v_hwg_per_2 v01
INNER JOIN dbp_view.v_hwg_spr_zu_2 v02
    ON v02.mandant_id = v01.mandant_id
    AND v02.hwg_id = v01.hwg_id
WHERE v01.arthiertyp_id = 2
    AND v01.dat_bis = '9999-12-31'
GROUP BY
    v01.hwg_id
    ,v01.mandant_id
    ,v01.arthiertyp_id
    ,v01.abt_id;