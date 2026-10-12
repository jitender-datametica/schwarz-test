CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_EINGANGSKANAL_SPR_ZU
AS
-- 17.07.2019 twie: SPEC0059158 Sprachview CRM Eingangskanal

   SELECT

   v01.crm_eingangskanal_id
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.crm_eingangskanal_bez ELSE NULL END)  AS crm_eingangskanal_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.crm_eingangskanal_bez ELSE NULL END)  AS crm_eingangskanal_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.crm_eingangskanal_bez ELSE NULL END)  AS crm_eingangskanal_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.crm_eingangskanal_bez ELSE NULL END)  AS crm_eingangskanal_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.crm_eingangskanal_bez ELSE NULL END)  AS crm_eingangskanal_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.crm_eingangskanal_bez ELSE NULL END)  AS crm_eingangskanal_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.crm_eingangskanal_bez ELSE NULL END)  AS crm_eingangskanal_bez_bg

   FROM dbp_view.v_crm_eingangskanal_spr_zu v01

   GROUP BY v01.crm_eingangskanal_id;