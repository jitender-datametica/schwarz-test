CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_buyerid_firstname_lastname_barollupmk_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_1 SET
    buyerid = CAST(sr.buyeridnew AS INTEGER),
    buyerfirstname = sr.buyerfirstnamenew,
    buyerlastname = sr.buyerlastnamenew FROM idq_production_eks_calculation.srmara_eks_item_buyerid_firstname_lastname_barollupmk_updsel_1 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
