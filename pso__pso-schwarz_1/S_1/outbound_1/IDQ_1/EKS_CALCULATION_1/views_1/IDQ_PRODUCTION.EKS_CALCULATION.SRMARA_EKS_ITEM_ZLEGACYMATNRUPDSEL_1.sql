CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zlegacymatnrupdsel_1 (itemid, zlegacymatnr,
zlegacymatnrnew) AS SELECT itemid,
 zlegacymatnr,
 itemno AS zlegacymatnrnew
FROM idq_production_eks_calculation.stmara_eks_item_1
WHERE zlegacymatnr IS NULL;