CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_relevancychecksdetail_zhiderowduplicates_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_relevancychecksdetail_2 SET
    zhiderow = SR.zhiderownew FROM eks_calculation.srmara_eks_item_relevancychecksdetail_zhiderowduplicates_updsel_2 AS SR
WHERE stmara_eks_item_relevancychecksdetail.uid = SR.uid;
END;




