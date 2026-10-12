CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_L_STATUS
AS
-- 17.07.2019 twie: SPEC0059158 Lookup CRM Status

   SELECT

   crm_status_id

   FROM dbp_view.v_crm_l_status;