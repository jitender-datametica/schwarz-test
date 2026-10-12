CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_relevancychecksdetail_zhidecontract_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_relevancychecksdetail_2 AS RCD SET
    zhidecontract = SR.zhidecontractnew FROM eks_calculation.srmara_eks_item_relevancychecksdetail_zhidecontract_updsel_2 AS SR
WHERE RCD.uid = SR.uid AND RCD.itemid = SR.itemid AND RCD.itemno = SR.itemno;
END;




