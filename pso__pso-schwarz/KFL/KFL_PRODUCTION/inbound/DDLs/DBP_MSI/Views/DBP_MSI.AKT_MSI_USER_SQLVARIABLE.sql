CREATE OR REPLACE VIEW DBP_MSI.AKT_MSI_USER_SQLVARIABLE
AS
SELECT
  v01.user_id
 , v01.session_id
FROM dbp_msi_data.akt_msi_user v01
WHERE v01.user_id = $userid
GROUP BY 1,2;
