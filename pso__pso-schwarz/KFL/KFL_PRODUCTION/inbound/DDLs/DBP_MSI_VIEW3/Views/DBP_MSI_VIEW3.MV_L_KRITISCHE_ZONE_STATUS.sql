CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_KRITISCHE_ZONE_STATUS
-- -- 03.12.2018, mkub1811, AP0027269, neue View
(
mandant_id
,kritische_zone_status_id
)
AS
   SELECT
   mandant_id, kritische_zone_status_id
   FROM dbp_view.v_l_kritische_zone_status;