CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_L_SCHAEDLINGSART_1
AS
-- 17.07.2019 twie: SPEC0059158 Lookup CRM Schaedlingsart

   SELECT

   crm_schaedlingsart_id

   FROM dbp_view.v_crm_l_schaedlingsart_1;