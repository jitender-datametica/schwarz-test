CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MDL_L_FRAGE_1
AS
-- 21.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 

SELECT
 v01.frage_id
 FROM dbp_view.v_mdl_l_frage_1 v01;