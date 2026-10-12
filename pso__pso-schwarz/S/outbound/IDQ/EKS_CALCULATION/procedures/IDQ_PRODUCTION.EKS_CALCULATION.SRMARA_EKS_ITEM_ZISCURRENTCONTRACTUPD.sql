CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_ziscurrentcontractupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    ziscurrentcontract = CAST(ROUND(CAST(SR.ziscurrentcontractnew AS BIGNUMERIC),0) AS INT64) FROM eks_calculation.srmara_eks_item_ziscurrentcontractupdsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;

