CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_ziseahasbaupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_1 SET
    ziseahasba = CAST(srmara_eks_item_ziseahasbaupdsel.ziseahasbanew AS INTEGER) FROM idq_production_eks_calculation.srmara_eks_item_ziseahasbaupdsel_1
WHERE stmara_eks_item.itemid = srmara_eks_item_ziseahasbaupdsel.itemid;
END;
