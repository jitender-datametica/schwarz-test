create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_WE_MESSAGE_STATUS_SPR_ZU_2(
	MANDANT_ID,
	WE_MESSAGE_STATUS_ID,
	SPR_ID,
	WE_MESSAGE_STATUS_BEZ
) as 



SELECT
   v01_de.mandant_id,
   v01_de.we_message_status_id,
   v02.spr_id,
   
   COALESCE(v01.we_message_status_bez,v01_de.we_message_status_bez) AS we_message_status_bez
FROM
   dbp_view.v_we_message_status_spr_zu_2 v01_de
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 
   LEFT JOIN dbp_view.v_we_message_status_spr_zu_2 v01 ON v01.mandant_id=v01_de.mandant_id AND v01.we_message_status_id=v01_de.we_message_status_id 
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
   dbp_view.v_we_message_status_spr_zu_2 v01
WHERE
   v01.we_message_status_id = 0;