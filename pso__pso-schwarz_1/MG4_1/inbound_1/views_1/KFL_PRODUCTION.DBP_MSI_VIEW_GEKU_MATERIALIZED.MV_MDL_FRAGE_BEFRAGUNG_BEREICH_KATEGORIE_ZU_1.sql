create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_MDL_FRAGE_BEFRAGUNG_BEREICH_KATEGORIE_ZU_1(
	FRAGE_ID,
	BEFRAGUNG_ID,
	BEREICH_ID,
	KATEGORIE_ID
) as
-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 

SELECT
  v01.frage_id
 ,v01.befragung_id
 ,v01.bereich_id
 ,v01.kategorie_id
 FROM dbp_view.v_mdl_frage_befragung_bereich_kategorie_zu_1 v01;