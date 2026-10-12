CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_reset_01_2 (itemid) AS
SELECT itemsorting.itemid
FROM idq_production_eks.itemsorting_2
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS SK ON itemsorting.sortitemid = SK.itemid
WHERE SK.zarticletype = 'SK'
GROUP BY itemsorting.itemid
HAVING MAX(IFNULL(SK.ziscurrentcontract, IFNULL(SK.zrelevantmdm, 0))) = 0;