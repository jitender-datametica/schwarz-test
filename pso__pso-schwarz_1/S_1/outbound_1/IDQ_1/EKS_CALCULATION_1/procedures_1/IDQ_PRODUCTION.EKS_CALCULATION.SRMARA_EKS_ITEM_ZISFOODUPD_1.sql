CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zisfoodupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_1 SET
    zisfood = CAST(ROUND(CAST(SR.zisfoodnew AS BIGNUMERIC),0) AS INT64) FROM eks_calculation.srmara_eks_item_zisfoodupdsel_1 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;

