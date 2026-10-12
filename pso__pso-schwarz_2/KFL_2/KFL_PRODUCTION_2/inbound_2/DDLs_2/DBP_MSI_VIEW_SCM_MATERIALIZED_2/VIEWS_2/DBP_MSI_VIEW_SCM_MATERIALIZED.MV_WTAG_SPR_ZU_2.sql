create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WTAG_SPR_ZU_2(
	WTAG_ID,
	WTAG_BEZ,
	WTAG_BEZ_DE,
	WTAG_BEZ_CZ,
	WTAG_BEZ_PL,
	WTAG_BEZ_SK,
	WTAG_BEZ_HR,
	WTAG_BEZ_RO,
	WTAG_BEZ_BG,
	WTAG_KBEZ,
	WTAG_KBEZ_DE,
	WTAG_KBEZ_CZ,
	WTAG_KBEZ_PL,
	WTAG_KBEZ_SK,
	WTAG_KBEZ_HR,
	WTAG_KBEZ_RO,
	WTAG_KBEZ_BG
) as


   SELECT
     spr.wtag_id
   , MAX(CASE WHEN spr_id =  22 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez      
   , MAX(CASE WHEN spr_id =  22 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_de   
   , MAX(CASE WHEN spr_id = 124 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_cz   
   , MAX(CASE WHEN spr_id =  90 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_pl   
   , MAX(CASE WHEN spr_id = 108 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_sk   
   , MAX(CASE WHEN spr_id =  65 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_hr   
   , MAX(CASE WHEN spr_id =  95 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_ro   
   , MAX(CASE WHEN spr_id =  18 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_bg   
   , MAX(CASE WHEN spr_id =  22 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez      
   , MAX(CASE WHEN spr_id =  22 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_de   
   , MAX(CASE WHEN spr_id = 124 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_cz   
   , MAX(CASE WHEN spr_id =  90 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_pl   
   , MAX(CASE WHEN spr_id = 108 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_sk   
   , MAX(CASE WHEN spr_id =  65 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_hr   
   , MAX(CASE WHEN spr_id =  95 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_ro   
   , MAX(CASE WHEN spr_id =  18 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_bg   
   FROM dbp_view.v_wtag_spr_zu_2 spr_2
     GROUP BY  spr.wtag_id;