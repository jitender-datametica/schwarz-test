CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_relevancychecksdetail_zhideskflag_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_relevancychecksdetail_2 SET
    zhideskflag = SR.zhideskflagnew FROM eks_calculation.srmara_eks_item_relevancychecksdetail_zhideskflag_updsel_2 AS SR
WHERE stmara_eks_item_relevancychecksdetail.uid = SR.uid;
END;




