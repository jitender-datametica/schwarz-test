CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_ziseahasskupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    ziseahassk = CAST(sr.ziseahassknew AS INTEGER) FROM idq_production_eks_calculation.srmara_eks_item_ziseahasskupdsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
