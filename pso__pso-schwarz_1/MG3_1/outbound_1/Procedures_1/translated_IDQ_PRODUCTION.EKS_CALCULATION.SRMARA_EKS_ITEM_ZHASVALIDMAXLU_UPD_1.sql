CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zhasvalidmaxlu_upd()
BEGIN
--AND EKS_CALCULATION.STMARA_EKS_ITEM.listingoverviewid = sr.listingoverviewid
UPDATE idq_production_eks_calculation.stmara_eks_item_1 SET
    zhasvalidmaxlu = sr.zhasvalidmaxlunew,
    zrelevantluid = CAST(sr.zrelevantluidnew AS INTEGER) FROM idq_production_eks_calculation.srmara_eks_item_zhasvalidmaxlu_updsel_1 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
