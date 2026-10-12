
CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_IWT_SPR_ZU_1(
	MANDANT_ID,
	IWT_ID,
	IWT_BEZ,
	IWT_BEZ_DE,
	IWT_BEZ_CZ,
	IWT_BEZ_SK,
	IWT_BEZ_HR,
	IWT_BEZ_PL,
	IWT_BEZ_RO,
	IWT_BEZ_BG
) AS

SELECT
 v01.mandant_id
,v01.iwt_id
, Max(CASE WHEN v01.spr_id =  22 THEN iwt_bez END) AS iwt_bez                             -- standard == DE
, Max(CASE WHEN v01.spr_id =  22 THEN iwt_bez END) AS iwt_bez_de                          -- DE
, Coalesce(Max(CASE WHEN v01.spr_id = 124 THEN iwt_bez END), iwt_bez_de) AS iwt_bez_cz    -- CZ
, Coalesce(Max(CASE WHEN v01.spr_id = 108 THEN iwt_bez END), iwt_bez_de) AS iwt_bez_sk    -- SK
, Coalesce(Max(CASE WHEN v01.spr_id =  65 THEN iwt_bez END), iwt_bez_de) AS iwt_bez_hr    -- HR
, Coalesce(Max(CASE WHEN v01.spr_id =  90 THEN iwt_bez END), iwt_bez_de) AS iwt_bez_pl    -- PL
, Coalesce(Max(CASE WHEN v01.spr_id =  95 THEN iwt_bez END), iwt_bez_de) AS iwt_bez_ro    -- RO
, Coalesce(Max(CASE WHEN v01.spr_id =  18 THEN iwt_bez END), iwt_bez_de) AS iwt_bez_bg    -- BG
FROM DBP_VIEW.v_iwt_spr_zu_1 v01
GROUP BY v01.mandant_id
        ,v01.iwt_id;