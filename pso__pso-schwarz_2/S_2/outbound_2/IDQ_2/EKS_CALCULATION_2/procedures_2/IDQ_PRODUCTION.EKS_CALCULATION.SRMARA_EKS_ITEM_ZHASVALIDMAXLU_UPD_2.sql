CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zhasvalidmaxlu_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_2 SET
    zhasvalidmaxlu = SR.zhasvalidmaxlunew,
    zrelevantluid = SR.zrelevantluidnew FROM eks_calculation.srmara_eks_item_zhasvalidmaxlu_updsel_2 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;

