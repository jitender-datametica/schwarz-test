CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    ziscurrentcontract = CAST(sr.ziscurrentcontractnew AS INTEGER) FROM idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractupdsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
