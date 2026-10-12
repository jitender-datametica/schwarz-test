CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_ziseahasbaupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_2 SET
    ziseahasba = CAST(ROUND(CAST(srmara_eks_item_ziseahasbaupdsel.ziseahasbanew AS BIGNUMERIC),0) AS INT64) FROM eks_calculation.srmara_eks_item_ziseahasbaupdsel_2
WHERE stmara_eks_item.itemid = srmara_eks_item_ziseahasbaupdsel.itemid;
END;

