CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_L_FREMDKOERPER_2
AS
-- 22.07.2019 twie: SPEC0059158 Lookup CRM Fremdkoerper

   SELECT

   crm_fremdkoerper_id

   FROM dbp_view.v_crm_l_fremdkoerper_2;