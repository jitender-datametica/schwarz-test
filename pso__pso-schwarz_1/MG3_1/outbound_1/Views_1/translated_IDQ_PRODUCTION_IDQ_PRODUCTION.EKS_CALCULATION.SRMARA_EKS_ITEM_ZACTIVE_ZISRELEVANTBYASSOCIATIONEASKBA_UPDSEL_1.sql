CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zactive_zisrelevantbyassociationeaskba_updsel_1 (itemid
, zactive, zactivenew, zisrelevantbyassociation, zisrelevantbyassociationnew, zitem_ba) AS SELECT DISTINCT ba.itemid,
 ba.zactive,
 ea.zactive AS zactivenew,
 ba.zisrelevantbyassociation,
 1 AS zisrelevantbyassociationnew,
 ba.zitem_ba
FROM idq_production_eks_calculation.stmara_eks_item_1 AS ea
 INNER JOIN idq_production_eks.itemsorting_1 ON ea.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS sk ON itemsorting.sortitemid = sk.itemid
 INNER JOIN idq_production_eks.itemsorting_1 AS steks_itemsorting_1 ON sk.itemid = steks_itemsorting_1.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS ba ON steks_itemsorting_1.sortitemid = ba.itemid
WHERE ea.bitflag = 0 AND ba.bitflag = 2 AND ea.zactive = 1 AND sk.bitflag = 4 AND sk.zactive = 1 AND ba.zactive IS NULL
  AND IFNULL(ba.zforcenotrelevant, 0) = 0
 OR ea.bitflag = 0 AND ba.bitflag = 2 AND ea.zactive = 1 AND sk.bitflag = 4 AND ba.zactive IS NULL AND IFNULL(ba.zforcenotrelevant
    , 0) = 0;