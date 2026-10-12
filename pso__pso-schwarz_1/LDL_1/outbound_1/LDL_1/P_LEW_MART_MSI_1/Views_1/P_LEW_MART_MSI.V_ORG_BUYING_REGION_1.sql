CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_org_buying_region_1 (client_id, buying_region, region_sequence) AS SELECT
 client_id,
 buying_region,
 MIN(region_sequence) AS region_sequence
FROM ldl_p_lew_core_ac.v_wawi_org_wh_buying_region_1
GROUP BY client_id,
 buying_region;