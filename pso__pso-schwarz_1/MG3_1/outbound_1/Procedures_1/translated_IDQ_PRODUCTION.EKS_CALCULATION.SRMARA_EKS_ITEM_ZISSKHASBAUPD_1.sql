CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zisskhasbaupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_1 SET
    zisskhasba = CAST(sr.zisskhasbanew AS INTEGER) FROM idq_production_eks_calculation.srmara_eks_item_zisskhasbaupdsel_1 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
