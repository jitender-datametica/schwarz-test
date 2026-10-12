CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_AKTION_THEMA_GRUPPE

(
aktion_thema_gruppe_id
,aktion_thema_gruppe_bez
)
AS
   SELECT
   aktion_thema_gruppe_id, aktion_thema_gruppe_bez

   FROM dbp_view.v_l_aktion_thema_gruppe;