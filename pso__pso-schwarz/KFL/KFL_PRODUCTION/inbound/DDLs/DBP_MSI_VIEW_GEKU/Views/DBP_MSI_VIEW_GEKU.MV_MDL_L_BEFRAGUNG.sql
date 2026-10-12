CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MDL_L_BEFRAGUNG
AS
-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 

SELECT
 v01.befragung_id
 FROM dbp_view.v_mdl_l_befragung v01;