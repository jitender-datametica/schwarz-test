CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_ea_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    zhasvalidadsflg = sr.zhasvalidadsflgnew,
    zhasvalidcontractdate = sr.zhasvalidcontractdatenew FROM idq_production_eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_ea_updsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
