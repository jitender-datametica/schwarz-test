CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_znegotiatingcountryupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    znegotiatingcountry = sr.znegotiatingcountrynew FROM idq_production_eks_calculation.srmara_eks_item_znegotiatingcountryupdsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
