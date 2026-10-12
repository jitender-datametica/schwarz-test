CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_znegotiatingcountryupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_2 SET
    znegotiatingcountry = SR.znegotiatingcountrynew FROM eks_calculation.srmara_eks_item_znegotiatingcountryupdsel_2 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




