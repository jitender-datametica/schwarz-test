CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zforcenotrelevant_rolluptosk_updsel_2 (itemid,
zlegacymatnr, zforcenotrelevant, zforcenotrelevantnew) AS SELECT DISTINCT SK.itemid,
 SK.zlegacymatnr,
 SK.zforcenotrelevant,
 1 AS zforcenotrelevantnew
FROM idq_production_eks_calculation.stmara_eks_item_2 AS SK
 INNER JOIN idq_production_eks.itemsorting_2 ON SK.itemid = itemsorting.sortitemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS EA ON itemsorting.itemid = EA.itemid
WHERE SK.zarticletype = 'SK'
 AND EA.zarticletype = 'EA'
 AND EA.zforcenotrelevant = 1;