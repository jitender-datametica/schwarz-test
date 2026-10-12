create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_VW_1(
	VW_ID,
	VW_BEZ,
	VK_ID,
	MANDANT_ID,
	VWVT_BEZ,
	SAP_VW_ID
) as
-- 03.09.2013 twie: Anlage_1 Lookup Vertriebsweg
-- für DE vw_id 0,1,2,3; in KMO nur Dummy_1 0, da es keinen Vertriebsweg gibt

   SELECT
   vw_id,
   TRIM(vw_bez) AS vw_bez,
   vk_id,
   mandant_id,
   TRIM(vwvt_bez) AS vwvt_bez,
   sap_vw_id

   FROM dbp_view.v_l_vw_1
   WHERE (mandant_id = 1 AND  vw_id IN (0,1,2,3))
   OR  (mandant_id <> 1 AND  vw_id =0);