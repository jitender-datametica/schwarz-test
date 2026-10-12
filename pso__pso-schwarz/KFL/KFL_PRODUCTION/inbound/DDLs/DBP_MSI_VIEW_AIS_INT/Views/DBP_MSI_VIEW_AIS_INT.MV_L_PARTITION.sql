CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_PARTITION
(
MANDANT_ID,
WERBEFLAECHENABSCHNITT_NAME
)
AS
SELECT
 v01.mandant_id
,v01.werbeflaechenabschnitt_name
FROM DBP_DATA.ANGEBOT_WERBEMITTEL_PROMOTION_EVENT_ZU v01
LEFT JOIN DBP_DATA.promotion_event v02
ON  v01.mandant_id = v02.mandant_id
AND v01.promotion_event_id = v02.promotion_event_id
AND v01.werbemittelkanal_id = v02.werbemittelkanal_id
AND v01.werbemittel_id = v02.werbemittel_id
GROUP BY ALL;