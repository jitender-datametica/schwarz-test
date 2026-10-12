CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_zhidecontract_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_relevancychecksdetail AS rcd SET
    zhidecontract = sr.zhidecontractnew FROM idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_zhidecontract_updsel AS sr
WHERE rcd.uid = sr.uid AND rcd.itemid = sr.itemid AND rcd.itemno = sr.itemno;
END;
