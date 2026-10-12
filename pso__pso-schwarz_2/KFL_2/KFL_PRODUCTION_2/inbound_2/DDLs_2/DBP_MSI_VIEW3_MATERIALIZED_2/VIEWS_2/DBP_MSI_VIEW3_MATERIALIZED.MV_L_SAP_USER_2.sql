create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_L_SAP_USER_2(
	MANDANT_ID,
	SAP_USER,
	GRUPPE_ID
) as
   SELECT
  mandant_id, sap_user, gruppe_id

   FROM dbp_view.v_l_sap_user_2;