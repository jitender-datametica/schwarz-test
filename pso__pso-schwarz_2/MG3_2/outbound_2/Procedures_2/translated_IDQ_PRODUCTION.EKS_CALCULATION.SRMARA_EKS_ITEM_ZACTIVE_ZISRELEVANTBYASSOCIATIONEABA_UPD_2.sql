CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zactive_zisrelevantbyassociationeaba_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_2 SET
    zactive = CAST(sr.zactivenew AS INTEGER),
    zisrelevantbyassociation = sr.zisrelevantbyassociationnew FROM idq_production_eks_calculation.srmara_eks_item_zactive_zisrelevantbyassociationeaba_updsel_2 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
