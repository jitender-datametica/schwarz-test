create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_USER_MANDANT_ZU_2(
	MANDANT_ID,
	USER_ID
) as
   SELECT
  mandant_id, LOWER(user_id) AS user_id
   FROM dbp_msi_v_view.v_user_mandant_zu_2;