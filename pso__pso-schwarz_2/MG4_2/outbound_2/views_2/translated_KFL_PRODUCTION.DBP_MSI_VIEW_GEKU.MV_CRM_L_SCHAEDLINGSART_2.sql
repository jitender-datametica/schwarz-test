-- 17.07.2019 twie: SPEC0059158 Lookup CRM Schaedlingsart

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_crm_l_schaedlingsart_2 (crm_schaedlingsart_id) AS SELECT crm_schaedlingsart_id
 
FROM kfl_production_dbp_view.v_crm_l_schaedlingsart_2;