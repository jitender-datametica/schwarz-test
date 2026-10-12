CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_ziseahasskupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_1 SET
    ziseahassk = CAST(sr.ziseahassknew AS INTEGER) FROM idq_production_eks_calculation.srmara_eks_item_ziseahasskupdsel_1 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
