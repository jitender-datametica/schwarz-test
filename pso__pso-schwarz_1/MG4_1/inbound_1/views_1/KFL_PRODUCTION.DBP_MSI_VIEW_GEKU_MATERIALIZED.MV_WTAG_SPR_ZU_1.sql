create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_WTAG_SPR_ZU_1(
	WTAG_ID,
	WTAG_BEZ,
	WTAG_BEZ_CZ,
	WTAG_BEZ_PL,
	WTAG_BEZ_SK,
	WTAG_BEZ_HR,
	WTAG_BEZ_RO,
	WTAG_BEZ_BG
) as
-- 18.10.2021 twie: SPEC0129990	neues Attribut Wochentag

   SELECT
    v01.wtag_id
   ,MAX(CASE WHEN v01.spr_id =  22 THEN v01.wtag_bez ELSE NULL END) AS wtag_bez   
   ,MAX(CASE WHEN v01.spr_id = 124 THEN v01.wtag_bez ELSE NULL END) AS wtag_bez_cz
   ,MAX(CASE WHEN v01.spr_id =  90 THEN v01.wtag_bez ELSE NULL END) AS wtag_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108 THEN v01.wtag_bez ELSE NULL END) AS wtag_bez_sk
   ,MAX(CASE WHEN v01.spr_id =  65 THEN v01.wtag_bez ELSE NULL END) AS wtag_bez_hr
   ,MAX(CASE WHEN v01.spr_id =  95 THEN v01.wtag_bez ELSE NULL END) AS wtag_bez_ro
   ,MAX(CASE WHEN v01.spr_id =  18 THEN v01.wtag_bez ELSE NULL END) AS wtag_bez_bg

   FROM dbp_view.v_wtag_spr_zu_1 v01

   GROUP BY v01.wtag_id;