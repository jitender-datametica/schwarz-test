create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_MDL_L_BEREICH(
	BEREICH_ID,
	HAUPTBEREICH_FG
) as
-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 

SELECT
  v01.bereich_id
 ,v01.hauptbereich_fg
 FROM dbp_view.v_mdl_l_bereich v01;
