CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_WE_MESSAGE_STATUS_2
-- 03.12.2018, mkub1811, AP0027269, neue View
(
mandant_id
,we_message_status_id
)
AS
   SELECT
   mandant_id, we_message_status_id
   FROM dbp_view.v_l_we_message_status_2;