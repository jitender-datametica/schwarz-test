CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_ea_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_1 SET
    zhasvalidadsflg = SR.zhasvalidadsflgnew,
    zhasvalidcontractdate = SR.zhasvalidcontractdatenew FROM eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_ea_updsel_1 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




