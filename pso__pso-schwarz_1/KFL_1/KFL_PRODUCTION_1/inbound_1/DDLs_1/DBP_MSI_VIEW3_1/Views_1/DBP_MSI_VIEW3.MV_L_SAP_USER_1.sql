CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_SAP_USER_1
(
mandant_id
, sap_user
, gruppe_id
)
AS
   SELECT
  mandant_id, sap_user, gruppe_id

   FROM dbp_view.v_l_sap_user_1;