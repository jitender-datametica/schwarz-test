CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MDL_L_KATEGORIE
AS
-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 

SELECT
 v01.kategorie_id
 FROM dbp_view.v_mdl_l_kategorie v01;