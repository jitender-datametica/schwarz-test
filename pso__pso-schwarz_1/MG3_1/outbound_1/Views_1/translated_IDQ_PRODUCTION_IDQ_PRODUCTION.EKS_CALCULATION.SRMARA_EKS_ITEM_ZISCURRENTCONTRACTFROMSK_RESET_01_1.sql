CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_reset_01_1 (itemid) AS
SELECT itemsorting.itemid
FROM idq_production_eks.itemsorting_1
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS sk ON itemsorting.sortitemid = sk.itemid
WHERE sk.zarticletype = 'SK'
GROUP BY itemsorting.itemid
HAVING MAX(IFNULL(sk.ziscurrentcontract, IFNULL(sk.zrelevantmdm, 0))) = 0;