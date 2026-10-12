CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_L_EIGENMARKE_1
AS
-- 17.07.2019 twie: SPEC0059158 Lookup CRM Eigenmarke

   SELECT

   crm_eigenmarke_id

   FROM dbp_view.v_crm_l_eigenmarke_1;