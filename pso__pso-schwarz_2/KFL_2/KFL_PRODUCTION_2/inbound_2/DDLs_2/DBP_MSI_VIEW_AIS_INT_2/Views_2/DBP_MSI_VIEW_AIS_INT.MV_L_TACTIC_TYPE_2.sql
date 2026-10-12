CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_TACTIC_TYPE_2
(
MANDANT_ID,
WERBEMITTELKANAL_ID,
WERBEMITTELKANAL_BEZ
) 
AS
SELECT
 v01.mandant_id
,v02.werbemittelkanal_id
,v01.werbemittelkanal_bez
FROM DBP_DATA.ANGEBOT_WERBEMITTEL_PROMOTION_EVENT_ZU_2 v01
JOIN DBP_DATA.promotion_event_2 v02
ON  v01.mandant_id = v02.mandant_id
AND v01.promotion_event_id = v02.promotion_event_id
AND v01.werbemittelkanal_id = v02.werbemittelkanal_id
GROUP BY ALL;