CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_meins_rollupfromea_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_2 SET
    zmeins = sr.zmeinsnew FROM idq_production_eks_calculation.srmara_eks_item_meins_rollupfromea_updsel_2 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
