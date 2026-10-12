create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_CRM_GENDER_SPR_ZU_2(
	GENDER_ID,
	GENDER_BEZ,
	GENDER_BEZ_DE,
	GENDER_BEZ_EN,
	GENDER_BEZ_CZ,
	GENDER_BEZ_SK,
	GENDER_BEZ_HR,
	GENDER_BEZ_PL,
	GENDER_BEZ_RO,
	GENDER_BEZ_BG
) as
SELECT
gender_id
, Max(CASE WHEN spr_id =  22 THEN gender_bez END) AS gender_bez   --standard
, Max(CASE WHEN spr_id =  22 THEN gender_bez END) AS gender_bez_de --DE (for coalesce only)
, Coalesce(Max(CASE WHEN spr_id = 24   THEN gender_bez END), gender_bez_de)  AS gender_bez_en --EN
, Coalesce(Coalesce(Max(CASE WHEN spr_id = 124 THEN gender_bez END), gender_bez_en),gender_bez_de)  AS gender_bez_cz -- CZ
, Coalesce(Coalesce(Max(CASE WHEN spr_id = 108 THEN gender_bez END), gender_bez_en),gender_bez_de)   AS gender_bez_sk -- SK
, Coalesce(Coalesce(Max(CASE WHEN spr_id = 65   THEN gender_bez END), gender_bez_en),gender_bez_de)   AS gender_bez_hr -- HR
, Coalesce(Coalesce(Max(CASE WHEN spr_id = 90   THEN gender_bez END), gender_bez_en),gender_bez_de)   AS gender_bez_pl -- PL
, Coalesce(Coalesce(Max(CASE WHEN spr_id = 95   THEN gender_bez END), gender_bez_en),gender_bez_de)   AS gender_bez_ro -- RO
, Coalesce(Coalesce(Max(CASE WHEN spr_id = 18   THEN gender_bez END), gender_bez_en),gender_bez_de)   AS gender_bez_bg -- BG
FROM dbp_view.v_crm_gender_spr_zu_2
GROUP BY 
 gender_id
 ;