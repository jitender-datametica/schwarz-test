CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MDL_FRAGE_BEFRAGUNG_BEREICH_KATEGORIE_ZU_1
AS
-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 

SELECT
  v01.frage_id
 ,v01.befragung_id
 ,v01.bereich_id
 ,v01.kategorie_id
 FROM dbp_view.v_mdl_frage_befragung_bereich_kategorie_zu_1 v01;