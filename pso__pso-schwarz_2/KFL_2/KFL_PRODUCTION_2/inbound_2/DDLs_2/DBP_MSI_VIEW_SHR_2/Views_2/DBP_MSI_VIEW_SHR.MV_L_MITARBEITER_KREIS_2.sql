CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_MITARBEITER_KREIS_2
(
mandant_id
, mitarbeiter_kreis_id
)
AS
   SELECT
   v01.mandant_id, v01.mitarbeiter_kreis_id

   FROM dbp_view.v_l_mitarbeiter_kreis_2 v01;