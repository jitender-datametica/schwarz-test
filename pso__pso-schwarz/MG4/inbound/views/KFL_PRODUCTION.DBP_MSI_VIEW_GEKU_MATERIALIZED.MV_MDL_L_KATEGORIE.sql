create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_MDL_L_KATEGORIE(
	KATEGORIE_ID
) as
-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 

SELECT
 v01.kategorie_id
 FROM dbp_view.v_mdl_l_kategorie v01;