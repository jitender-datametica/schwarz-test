CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zforcenotrelevant_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_1 SET
    zforcenotrelevant = SR.zforcenotrelevantnew FROM eks_calculation.srmara_eks_item_zforcenotrelevant_updsel_1 AS SR
WHERE stmara_eks_item.itemno = SR.itemno;
END;




