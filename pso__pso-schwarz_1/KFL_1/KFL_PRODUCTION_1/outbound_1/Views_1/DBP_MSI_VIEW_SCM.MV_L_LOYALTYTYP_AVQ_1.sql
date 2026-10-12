CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_loyaltytyp_avq_1 (loyaltytyp_avq_id, loyaltytyp_avq_bez) AS
SELECT '1' AS loyaltytyp_avq_id,
 'KDP (ZAI)' AS loyaltytyp_avq_bez
UNION ALL
SELECT '2' AS loyaltytyp_avq_id,
 'KDI' AS loyaltytyp_avq_bez
UNION ALL
SELECT '3' AS loyaltytyp_avq_id,
 'KDX' AS loyaltytyp_avq_bez
UNION ALL
SELECT '4' AS loyaltytyp_avq_id,
 'KDP' AS loyaltytyp_avq_bez
UNION ALL
SELECT '5' AS loyaltytyp_avq_id,
 'KDN' AS loyaltytyp_avq_bez
UNION ALL
SELECT '-1' AS loyaltytyp_avq_id,
 'N/A' AS loyaltytyp_avq_bez;