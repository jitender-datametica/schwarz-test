CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_relevancychecksdetail_zhiderow_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_relevancychecksdetail_1 SET
    zhiderow = SR.zhiderownew FROM eks_calculation.srmara_eks_item_relevancychecksdetail_zhiderow_updsel_1 AS SR
WHERE stmara_eks_item_relevancychecksdetail.uid = SR.uid;
END;




