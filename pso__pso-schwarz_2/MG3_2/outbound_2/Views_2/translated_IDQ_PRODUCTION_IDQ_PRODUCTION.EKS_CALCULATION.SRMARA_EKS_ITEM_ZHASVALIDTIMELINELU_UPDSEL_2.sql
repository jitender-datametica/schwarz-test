CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zhasvalidtimelinelu_updsel_2 (itemid,
zhasvalidtimelinelu, zhasvalidtimelinelunew, listingoverviewid) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.zhasvalidtimelinelu,
 1 AS zhasvalidtimelinelunew,
 MAX(listingoverview.listingoverviewid) AS listingoverviewid
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks.listingitem_2 ON stmara_eks_item.itemid = listingitem.itemid
 INNER JOIN idq_production_eks.listingoverview_2 ON listingitem.listingoverviewid = listingoverview.listingoverviewid
 INNER JOIN idq_production_eks.contractlink_2 ON listingoverview.listingoverviewid = contractlink.listingoverviewid
 INNER JOIN idq_production_eks.supplier_2 ON listingoverview.supplierno = supplier.supplierno
 LEFT JOIN idq_production_eks_calculation.eks_zsm_articleparameter_2 ON eks_zsm_articleparameter.id = 'DRDATE'
WHERE contractlink.statusid IN (34, 86)
 AND listingoverview.dateuntil >= CAST(eks_zsm_articleparameter.date AS DATETIME)
GROUP BY stmara_eks_item.itemid,
 stmara_eks_item.zhasvalidtimelinelu;