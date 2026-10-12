CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_FLAECHENKUERZEL_2
(
MANDANT_ID,
WERBEFLAECHENTHEMA_CD,
WERBEFLAECHENTHEMA_BEZ
)
AS
SELECT
 v01.mandant_id
,v02.werbeflaechenthema_cd
,v01.werbeflaechenthema_bez
FROM DBP_DATA.ANGEBOT_WERBEMITTEL_PROMOTION_EVENT_ZU_2 v01
LEFT JOIN DBP_DATA.promotion_event_2 v02
ON  v01.mandant_id = v02.mandant_id
AND v01.promotion_event_id = v02.promotion_event_id
AND v01.werbemittelkanal_id = v02.werbemittelkanal_id
AND v01.werbeflaechenthema_cd = v02.werbeflaechenthema_cd
GROUP BY ALL;