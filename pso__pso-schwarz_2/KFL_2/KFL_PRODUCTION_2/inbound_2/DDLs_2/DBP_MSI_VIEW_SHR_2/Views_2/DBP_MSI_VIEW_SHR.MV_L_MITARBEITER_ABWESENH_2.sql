CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_MITARBEITER_ABWESENH_2
(
mandant_id
, abwesenheit_id
)
AS
   SELECT
   v01.mandant_id, v01.abwesenheit_id

   FROM dbp_view.v_l_mitarbeiter_abwesenh_2 v01;