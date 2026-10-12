CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_sk_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_1 SET
    zhasvalidadsflg = sr.zhasvalidadsflgnew,
    zhasvalidcontractdate = sr.zhasvalidcontractdatenew FROM idq_production_eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_sk_updsel_1 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
