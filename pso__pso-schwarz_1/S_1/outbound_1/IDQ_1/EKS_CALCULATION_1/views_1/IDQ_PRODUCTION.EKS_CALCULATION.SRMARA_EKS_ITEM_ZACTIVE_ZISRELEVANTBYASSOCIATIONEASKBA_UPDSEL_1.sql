CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zactive_zisrelevantbyassociationeaskba_updsel_1 (itemid
, zactive, zactivenew, zisrelevantbyassociation, zisrelevantbyassociationnew, zitem_ba) AS SELECT DISTINCT BA.itemid,
 BA.zactive,
 EA.zactive AS zactivenew,
 BA.zisrelevantbyassociation,
 1 AS zisrelevantbyassociationnew,
 BA.zitem_ba
FROM idq_production_eks_calculation.stmara_eks_item_1 AS EA
 INNER JOIN idq_production_eks.itemsorting_1 ON EA.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS SK ON itemsorting.sortitemid = SK.itemid
 INNER JOIN idq_production_eks.itemsorting_1 AS STEKS_ITEMSORTING_1 ON SK.itemid = STEKS_ITEMSORTING_1.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS BA ON STEKS_ITEMSORTING_1.sortitemid = BA.itemid
WHERE EA.bitflag = 0 AND BA.bitflag = 2 AND EA.zactive = 1 AND SK.bitflag = 4 AND SK.zactive = 1 AND BA.zactive IS NULL
  AND IFNULL(BA.zforcenotrelevant, 0) = 0
 OR EA.bitflag = 0 AND BA.bitflag = 2 AND EA.zactive = 1 AND SK.bitflag = 4 AND BA.zactive IS NULL AND IFNULL(BA.zforcenotrelevant
    , 0) = 0;