CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MDL_L_BEREICH_1
AS
-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 

SELECT
  v01.bereich_id
 ,v01.hauptbereich_fg
 FROM dbp_view.v_mdl_l_bereich_1 v01;