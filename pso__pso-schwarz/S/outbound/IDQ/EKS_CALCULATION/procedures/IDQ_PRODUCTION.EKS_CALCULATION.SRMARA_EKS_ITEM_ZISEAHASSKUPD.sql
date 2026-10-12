CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_ziseahasskupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    ziseahassk = CAST(ROUND(CAST(SR.ziseahassknew AS BIGNUMERIC),0) AS INT64) FROM eks_calculation.srmara_eks_item_ziseahasskupdsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;

