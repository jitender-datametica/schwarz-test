create or replace view KFL_PRODUCTION.DBP_MSI.AKT_MSI_USER_2(
	USER_ID,
	SESSION_ID
) as
SELECT
  v01.user_id
 , v01.session_id
FROM dbp_msi_data.akt_msi_user_2 v01
WHERE session_id = current_session()
GROUP BY 1,2
;