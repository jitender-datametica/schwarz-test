CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_meins_rollupfromea_updsel (zitem_ba, itemid,
zsource, zmeins, zmeinsnew, bitflag) AS SELECT srmara_eks_item_meins_rollupfromea_01.zitem_ba,
 stmara_eks_item.itemid,
 stmara_eks_item.zsource,
 stmara_eks_item.zmeins,
 srmara_eks_item_meins_rollupfromea_01.zmeins AS zmeinsnew,
 stmara_eks_item.bitflag
FROM idq_production_eks_calculation.srmara_eks_item_meins_rollupfromea_01
 INNER JOIN idq_production_eks_calculation.stmara_eks_item ON srmara_eks_item_meins_rollupfromea_01.zitem_ba =
  stmara_eks_item.zitem_ba
WHERE stmara_eks_item.bitflag <> 0;