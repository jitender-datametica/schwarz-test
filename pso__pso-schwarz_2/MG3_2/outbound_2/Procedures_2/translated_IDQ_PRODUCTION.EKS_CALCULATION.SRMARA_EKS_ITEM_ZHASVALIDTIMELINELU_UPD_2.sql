CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zhasvalidtimelinelu_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_2 SET
    zhasvalidtimelinelu = sr.zhasvalidtimelinelunew FROM idq_production_eks_calculation.srmara_eks_item_zhasvalidtimelinelu_updsel_2 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
