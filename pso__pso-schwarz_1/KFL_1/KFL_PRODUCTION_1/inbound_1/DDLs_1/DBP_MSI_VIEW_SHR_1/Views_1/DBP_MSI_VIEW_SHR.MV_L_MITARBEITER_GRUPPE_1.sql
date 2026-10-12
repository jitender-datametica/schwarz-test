CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_MITARBEITER_GRUPPE_1
(
mandant_id
, mitarbeiter_gruppe_id
)
AS
   SELECT
   v01.mandant_id, v01.mitarbeiter_gruppe_id

   FROM dbp_view.v_l_mitarbeiter_gruppe_1 v01;