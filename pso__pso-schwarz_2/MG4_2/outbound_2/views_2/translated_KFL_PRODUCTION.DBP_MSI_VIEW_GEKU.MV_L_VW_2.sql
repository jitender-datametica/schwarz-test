-- 03.09.2013 twie: Anlage_2 Lookup Vertriebsweg

-- für DE vw_id 0,1,2,3; in KMO nur Dummy_2 0, da es keinen Vertriebsweg gibt

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_l_vw_2 (vw_id, vw_bez, vk_id, mandant_id, vwvt_bez, sap_vw_id) AS SELECT vw_id
 ,
 TRIM(vw_bez) AS vw_bez,
 vk_id,
 mandant_id,
 TRIM(vwvt_bez) AS vwvt_bez,
 sap_vw_id
FROM kfl_production_dbp_view.v_l_vw_2
WHERE mandant_id = 1 AND vw_id IN (0, 1, 2, 3)
 OR mandant_id <> 1 AND vw_id = 0;