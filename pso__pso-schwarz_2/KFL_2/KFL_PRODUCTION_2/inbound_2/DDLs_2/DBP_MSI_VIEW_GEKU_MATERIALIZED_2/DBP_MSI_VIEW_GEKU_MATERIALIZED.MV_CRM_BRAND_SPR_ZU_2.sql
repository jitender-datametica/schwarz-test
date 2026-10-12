create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_CRM_BRAND_SPR_ZU_2(
	CRM_BRAND_ID,
	CRM_BRAND_BEZ,
	CRM_BRAND_BEZ_CZ,
	CRM_BRAND_BEZ_PL,
	CRM_BRAND_BEZ_SK,
	CRM_BRAND_BEZ_HR,
	CRM_BRAND_BEZ_RO,
	CRM_BRAND_BEZ_BG
) as
-- 10.05.2022 twie: SPEC0145413 Sprachview CRM Marke
-- 18.01.2024 twie: NSR4260499 da deutsch mit spr_id = 22 nicht immer gefüllt ist, sondern immer nur eine_2 der Sprachen
--            soll bei deutsch der Inhalt der anderen Sprachen gezeigt werden
--            man nimmt in Kauf das für den Fall dass es 2 oder mehr Übersetzungen gibt bei deutsch sozusagen zufällig eine_2 der vorhandenen angezeigt wird (MAX Funktion)

   SELECT

    v01.crm_brand_id
   ,MAX(v01.crm_brand_bez) AS crm_brand_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id = 124 THEN v01.crm_brand_bez ELSE NULL END)  AS crm_brand_bez_cz
   ,MAX(CASE WHEN v01.spr_id =   90 THEN v01.crm_brand_bez ELSE NULL END)  AS crm_brand_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108 THEN v01.crm_brand_bez ELSE NULL END)  AS crm_brand_bez_sk
   ,MAX(CASE WHEN v01.spr_id =   65 THEN v01.crm_brand_bez ELSE NULL END)  AS crm_brand_bez_hr
   ,MAX(CASE WHEN v01.spr_id =   95 THEN v01.crm_brand_bez ELSE NULL END)  AS crm_brand_bez_ro
   ,MAX(CASE WHEN v01.spr_id =   18 THEN v01.crm_brand_bez ELSE NULL END)  AS crm_brand_bez_bg

   FROM dbp_view.v_crm_brand_spr_zu_2 v01

   GROUP BY v01.crm_brand_id;
