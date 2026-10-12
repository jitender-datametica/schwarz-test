CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zisskhasbaupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_2 SET
    zisskhasba = CAST(ROUND(CAST(SR.zisskhasbanew AS BIGNUMERIC),0) AS INT64) FROM eks_calculation.srmara_eks_item_zisskhasbaupdsel_2 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;

