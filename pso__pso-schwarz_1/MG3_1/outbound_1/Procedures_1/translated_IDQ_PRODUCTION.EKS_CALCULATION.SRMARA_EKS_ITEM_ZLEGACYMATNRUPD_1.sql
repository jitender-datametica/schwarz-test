CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zlegacymatnrupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_1 SET
    zlegacymatnr = SUBSTR(CAST(sr.zlegacymatnrnew AS STRING), 1, 50) FROM idq_production_eks_calculation.srmara_eks_item_zlegacymatnrupdsel_1 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
