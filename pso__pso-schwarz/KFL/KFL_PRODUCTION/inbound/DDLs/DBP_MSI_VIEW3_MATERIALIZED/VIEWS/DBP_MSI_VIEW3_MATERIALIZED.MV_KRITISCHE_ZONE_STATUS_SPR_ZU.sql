create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_KRITISCHE_ZONE_STATUS_SPR_ZU(
	MANDANT_ID,
	KRITISCHE_ZONE_STATUS_ID,
	SPR_ID,
	KRITISCHE_ZONE_STATUS_BEZ
) as 



SELECT
   v01_de.mandant_id,
   v01_de.kritische_zone_status_id,
   v02.spr_id,
   COALESCE(v01.kritische_zone_status_bez,v01_de.kritische_zone_status_bez) AS kritische_zone_status_bez
FROM
   dbp_view.v_kritische_zone_status_spr_zu v01_de
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 
   LEFT JOIN dbp_view.v_kritische_zone_status_spr_zu v01 ON v01.mandant_id=v01_de.mandant_id AND v01.kritische_zone_status_id=v01_de.kritische_zone_status_id 
   AND v01.spr_id = v02.spr_id
   WHERE v01_de.spr_id = 22;