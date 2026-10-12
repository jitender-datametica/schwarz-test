CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_zzz_pack_type_fromxtzlax008_cust4updsel_2 (itemid,
zzz_pack_type, zzz_pack_typenew) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.zzz_pack_type,
 xtzlax008_cust4.targetvalue1 AS zzz_pack_typenew
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks_calculation.xtzlax008_cust4_2 ON stmara_eks_item.zlegacyzz_pack_type = xtzlax008_cust4.legacyvalue
  
WHERE stmara_eks_item.zzz_pack_type IS NULL
 AND xtzlax008_cust4.notrelevant = 0
 AND xtzlax008_cust4.targetvalue IS NOT NULL;