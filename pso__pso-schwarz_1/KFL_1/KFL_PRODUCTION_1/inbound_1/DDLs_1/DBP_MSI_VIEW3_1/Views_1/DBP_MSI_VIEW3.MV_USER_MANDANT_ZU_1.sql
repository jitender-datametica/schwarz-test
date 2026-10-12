CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_USER_MANDANT_ZU_1
(
mandant_id
, user_id
)
AS
   SELECT
  mandant_id, LOWER(user_id) AS user_id
   FROM dbp_msi_v_view.v_user_mandant_zu_1;