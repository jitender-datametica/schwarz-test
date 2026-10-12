create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_MDL_L_ZEITSPANNE_EINKAUF_2(
	ZEITSPANNE_EINKAUF_ID,
	ZEITSPANNE_EINKAUF_SORT_ID
) as
-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 

SELECT
  v01.zeitspanne_einkauf_id
 ,v01.zeitspanne_einkauf_sort_id
 FROM dbp_view.v_mdl_l_zeitspanne_einkauf_2 v01;
