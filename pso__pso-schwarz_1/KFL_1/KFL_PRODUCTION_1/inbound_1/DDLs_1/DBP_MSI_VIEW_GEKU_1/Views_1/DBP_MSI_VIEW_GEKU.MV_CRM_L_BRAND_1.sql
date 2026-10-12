CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_L_BRAND_1
AS
-- 10.05.2022 twie: SPEC0145413 Lookup CRM Marke

   SELECT
   crm_brand_id
   FROM dbp_view.v_crm_l_brand_1;