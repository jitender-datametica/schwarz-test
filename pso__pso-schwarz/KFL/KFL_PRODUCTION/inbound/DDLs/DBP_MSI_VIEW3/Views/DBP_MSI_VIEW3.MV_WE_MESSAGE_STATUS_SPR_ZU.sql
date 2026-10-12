CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WE_MESSAGE_STATUS_SPR_ZU (
   mandant_id,
   we_message_status_id,
   spr_id,
   we_message_status_bez
) AS 
-- 13.12.2018, aszu1204, AP0027269, neue View
-- 20230717 staeblern Umstellung auf Session Variable
-- 20250425 nwag, DE as fallback
SELECT
   v01_de.mandant_id,
   v01_de.we_message_status_id,
   v02.spr_id,
   --CASE WHEN v01.we_message_status_bez IS NULL THEN 1 ELSE 0 END AS fallback_fg,
   COALESCE(v01.we_message_status_bez,v01_de.we_message_status_bez) AS we_message_status_bez
FROM
   dbp_view.v_we_message_status_spr_zu v01_de
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   LEFT JOIN dbp_view.v_we_message_status_spr_zu v01 ON v01.mandant_id=v01_de.mandant_id AND v01.we_message_status_id=v01_de.we_message_status_id 
   AND v01.spr_id = v02.spr_id
   WHERE v01_de.spr_id = 22
UNION
ALL
SELECT
   v01.mandant_id,
   -1 AS we_message_status_id,
   v01.spr_id,
   '-' AS we_message_status_bez
FROM
   dbp_view.v_we_message_status_spr_zu v01
WHERE
   v01.we_message_status_id = 0;