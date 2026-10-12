CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_reset_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    ziscurrentcontractfromsk = CAST(sr.ziscurrentcontractfromsknew AS INTEGER) FROM idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_reset_updsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
