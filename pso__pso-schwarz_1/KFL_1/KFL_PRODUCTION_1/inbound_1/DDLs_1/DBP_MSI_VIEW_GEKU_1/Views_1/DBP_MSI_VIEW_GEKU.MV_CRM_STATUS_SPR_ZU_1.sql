CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_STATUS_SPR_ZU_1
AS
-- 17.07.2019 twie: SPEC0059158 Sprachview CRM Status_1

   SELECT

   v01.crm_status_id
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_bg

   FROM dbp_view.v_crm_status_spr_zu_1 v01

   GROUP BY v01.crm_status_id;