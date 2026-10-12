create or replace view DBP_MSI_VIEW_IMS_MATERIALIZED.USER_KURSTYP_ZU_2(
	USER_ID,
	KURSTYP_ID
) as
   SELECT
   v01.user_id,
   v01.kurstyp_id
  FROM dbp_msi_v_view.v_user_kurstyp_zu_2 v01;