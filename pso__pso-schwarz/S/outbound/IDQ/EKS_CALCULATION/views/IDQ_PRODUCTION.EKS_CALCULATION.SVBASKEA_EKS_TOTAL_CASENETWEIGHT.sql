CREATE OR REPLACE VIEW idq_production_eks_calculation.svbaskea_eks_total_casenetweight (total_casenetweight, sk_itemid)
AS SELECT SUM(ROUND(SAFE_CAST(T_EA_SORT.quantity * CAST(T_EA_DETAIL.netweight AS FLOAT64) AS BIGNUMERIC), 5)) AS
 total_casenetweight,
 T_SK.itemid AS sk_itemid
FROM idq_production_eks_calculation.stmara_eks_item AS T_BA
 INNER JOIN idq_production_eks.itemsorting AS T_BA_SK_LINK ON T_BA.itemid = T_BA_SK_LINK.sortitemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS T_SK ON T_BA_SK_LINK.itemid = T_SK.itemid
 INNER JOIN idq_production_eks.itemsorting AS T_EA_SORT ON T_SK.itemid = T_EA_SORT.sortitemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS T_EA ON T_EA_SORT.itemid = T_EA.itemid
 INNER JOIN idq_production_eks.itemdetail AS T_EA_DETAIL ON T_EA.itemid = T_EA_DETAIL.itemid
WHERE T_BA.zarticletype = 'BA'
 AND T_SK.zarticletype = 'SK'
 AND T_EA.zarticletype = 'EA'
GROUP BY sk_itemid;