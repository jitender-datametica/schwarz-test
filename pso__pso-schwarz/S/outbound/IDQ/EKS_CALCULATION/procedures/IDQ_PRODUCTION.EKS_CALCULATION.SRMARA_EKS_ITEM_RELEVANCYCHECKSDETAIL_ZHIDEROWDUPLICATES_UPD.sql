CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_relevancychecksdetail_zhiderowduplicates_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_relevancychecksdetail SET
    zhiderow = SR.zhiderownew FROM eks_calculation.srmara_eks_item_relevancychecksdetail_zhiderowduplicates_updsel AS SR
WHERE stmara_eks_item_relevancychecksdetail.uid = SR.uid;
END;




