CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_USER_EK_ANZEIGE_ZU
(
user_id
, ek_anzeige_fg
)
AS
   SELECT
   user_id, ek_anzeige_fg
   FROM dbp_security.user_ek_anzeige_zu;