CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zisfoodupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_1 SET
    zisfood = CAST(sr.zisfoodnew AS INTEGER) FROM idq_production_eks_calculation.srmara_eks_item_zisfoodupdsel_1 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
