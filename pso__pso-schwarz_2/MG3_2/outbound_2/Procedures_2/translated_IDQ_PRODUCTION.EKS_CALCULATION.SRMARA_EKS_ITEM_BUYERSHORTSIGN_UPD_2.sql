CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_buyershortsign_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_2 SET
    buyershortsign = sr.buyershortsignnew FROM idq_production_eks_calculation.srmara_eks_item_buyershortsign_updsel_2 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
