CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zhasvalidtimelinelu_updsel (itemid,
zhasvalidtimelinelu, zhasvalidtimelinelunew, listingoverviewid) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.zhasvalidtimelinelu,
 1 AS zhasvalidtimelinelunew,
 MAX(listingoverview.listingoverviewid) AS listingoverviewid
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks.listingitem ON stmara_eks_item.itemid = listingitem.itemid
 INNER JOIN idq_production_eks.listingoverview ON listingitem.listingoverviewid = listingoverview.listingoverviewid
 INNER JOIN idq_production_eks.contractlink ON listingoverview.listingoverviewid = contractlink.listingoverviewid
 INNER JOIN idq_production_eks.supplier ON listingoverview.supplierno = supplier.supplierno
 LEFT JOIN idq_production_eks_calculation.eks_zsm_articleparameter ON eks_zsm_articleparameter.id = 'DRDATE'
WHERE contractlink.statusid IN (34, 86)
 AND listingoverview.dateuntil >= CAST(eks_zsm_articleparameter.date AS DATETIME)
GROUP BY stmara_eks_item.itemid,
 stmara_eks_item.zhasvalidtimelinelu;