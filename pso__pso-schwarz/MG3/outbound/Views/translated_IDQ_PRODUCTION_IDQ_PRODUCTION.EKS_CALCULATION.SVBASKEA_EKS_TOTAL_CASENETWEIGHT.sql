CREATE OR REPLACE VIEW idq_production_eks_calculation.svbaskea_eks_total_casenetweight (total_casenetweight, sk_itemid)
AS SELECT SUM(ROUND(SAFE_CAST(steks_itemsorting_1.quantity * CAST(steks_itemdetail.netweight AS FLOAT64) AS NUMERIC), 5
   )) AS total_casenetweight,
 itemsorting.itemid AS sk_itemid
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks.itemsorting ON stmara_eks_item.itemid = itemsorting.sortitemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS stmara_eks_item_1 ON itemsorting.itemid =
  stmara_eks_item_1.itemid
 INNER JOIN idq_production_eks.itemsorting AS steks_itemsorting_1 ON itemsorting.itemid = steks_itemsorting_1.sortitemid
  
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS stmara_eks_item_2 ON steks_itemsorting_1.itemid =
  stmara_eks_item_2.itemid
 INNER JOIN idq_production_eks.itemdetail AS steks_itemdetail ON stmara_eks_item_2.itemid = steks_itemdetail.itemid
WHERE stmara_eks_item.zarticletype = 'BA'
 AND stmara_eks_item_1.zarticletype = 'SK'
 AND stmara_eks_item_2.zarticletype = 'EA'
GROUP BY sk_itemid;