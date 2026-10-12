create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_PLANUNGSART_SPR_ZU_1(
	MANDANT_ID,
	PLANUNGSART_ID,
	SPR_ID,
	PLANUNGSART_BEZ
) as 



SELECT
   v01_de.mandant_id,
   v01_de.planungsart_id,
   v02.spr_id,
      COALESCE(v01.planungsart_bez,v01_de.planungsart_bez) AS planungsart_bez
FROM
   dbp_view.v_planungsart_spr_zu_1 v01_de
    JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 
   LEFT JOIN dbp_view.v_planungsart_spr_zu_1 v01 ON v01.mandant_id=v01_de.mandant_id AND v01.planungsart_id=v01_de.planungsart_id 
   AND v01.spr_id = v02.spr_id
   WHERE v01_de.spr_id = 22;