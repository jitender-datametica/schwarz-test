CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MDL_KATEGORIE_GRUPPE_ZU_1
AS
-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 

SELECT
  v01.kategorie_id
 ,v01.kategorie_gruppe_id
 FROM dbp_view.v_mdl_kategorie_gruppe_zu_1 v01;