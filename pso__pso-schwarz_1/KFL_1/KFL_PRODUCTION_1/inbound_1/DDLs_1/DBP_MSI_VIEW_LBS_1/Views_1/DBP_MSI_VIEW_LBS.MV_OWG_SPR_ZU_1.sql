CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_OWG_SPR_ZU_1(
	OWG_ID,
	ARTHIERTYP_ID,
	MANDANT_ID,
	OWG_BEZ,
	OWG_BEZ_DE,
	OWG_BEZ_CZ,
	OWG_BEZ_SK,
	OWG_BEZ_HR,
	OWG_BEZ_PL,
	OWG_BEZ_RO,
	OWG_BEZ_BG
) AS SELECT
   v01.owg_id
   ,v01.arthiertyp_id
   ,v01.mandant_id
   ,COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.owg_bez END),'N/A') AS owg_bez            -- Standard == DE
   , COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.owg_bez END),'N/A') AS owg_bez_de        -- DE
   , COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_cz   -- CZ
   , COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_sk   -- SK
   , COALESCE(MAX(CASE WHEN v01.spr_id =  65  THEN v01.owg_bez END), owg_bez_de) AS owg_bez_hr  -- HR
   , COALESCE(MAX(CASE WHEN v01.spr_id =  90  THEN v01.owg_bez END), owg_bez_de) AS owg_bez_pl  -- PL
   , COALESCE(MAX(CASE WHEN v01.spr_id =  95  THEN v01.owg_bez END), owg_bez_de) AS owg_bez_ro  -- RO
   , COALESCE(MAX(CASE WHEN v01.spr_id =  18  THEN v01.owg_bez END), owg_bez_de) AS owg_bez_bg  -- BG
FROM dbp_view.v_owg_spr_zu_1 v01
WHERE v01.arthiertyp_id = 2
GROUP BY 1,2,3;