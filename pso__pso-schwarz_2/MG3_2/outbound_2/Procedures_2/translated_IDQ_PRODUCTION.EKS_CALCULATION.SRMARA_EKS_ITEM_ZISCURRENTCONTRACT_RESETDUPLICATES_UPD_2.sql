CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_ziscurrentcontract_resetduplicates_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_2 SET
    ziscurrentcontract = CAST(sr.ziscurrentcontractnew AS INTEGER) FROM idq_production_eks_calculation.srmara_eks_item_ziscurrentcontract_resetduplicates_updsel_2 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
