CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zforcenotrelevant_rolluptosk_updsel_1 (itemid,
zlegacymatnr, zforcenotrelevant, zforcenotrelevantnew) AS SELECT DISTINCT sk.itemid,
 sk.zlegacymatnr,
 sk.zforcenotrelevant,
 1 AS zforcenotrelevantnew
FROM idq_production_eks_calculation.stmara_eks_item_1 AS sk
 INNER JOIN idq_production_eks.itemsorting_1 ON sk.itemid = itemsorting.sortitemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS ea ON itemsorting.itemid = ea.itemid
WHERE sk.zarticletype = 'SK'
 AND ea.zarticletype = 'EA'
 AND ea.zforcenotrelevant = 1;