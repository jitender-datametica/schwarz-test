CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_znegotiatingcountryupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_1 SET
    znegotiatingcountry = sr.znegotiatingcountrynew FROM idq_production_eks_calculation.srmara_eks_item_znegotiatingcountryupdsel_1 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
