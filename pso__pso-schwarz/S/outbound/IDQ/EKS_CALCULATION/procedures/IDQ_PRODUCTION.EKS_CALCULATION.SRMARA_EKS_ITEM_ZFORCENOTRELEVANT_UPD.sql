CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zforcenotrelevant_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    zforcenotrelevant = SR.zforcenotrelevantnew FROM eks_calculation.srmara_eks_item_zforcenotrelevant_updsel AS SR
WHERE stmara_eks_item.itemno = SR.itemno;
END;




