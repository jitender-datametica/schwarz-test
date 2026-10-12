CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zisfoodupdsel_1 (itemid, zisfood, zisfoodnew) AS
SELECT itemid,
 zisfood,
 '1' AS zisfoodnew
FROM idq_production_eks_calculation.stmara_eks_item_1
WHERE zlegacymatkl BETWEEN '20' AND '98'
 AND zlegacymatkl <> '86';