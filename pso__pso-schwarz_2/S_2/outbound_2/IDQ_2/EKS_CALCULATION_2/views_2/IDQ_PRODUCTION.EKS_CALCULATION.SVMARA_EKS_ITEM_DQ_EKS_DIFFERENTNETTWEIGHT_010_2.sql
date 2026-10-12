CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_differentnettweight_010_2 (zrelevantmdm,
zsource, zactive, znegotiatingcountry, itemid, itemno, zarticletype, description_int, zmatkl, articlefamily, buyerid,
buyerfirstname, buyerlastname, buyershortsign, supplierno, supplierdescription, receivingcountry, gebinde_anzahl,
gebinde_inhalt, gebinde_einheit, gebinde_verpakung, netweight, zusatz_gew_art_int, zusatz_gew_art_nat) AS SELECT
DISTINCT CASE
  WHEN stmara_eks_item.itemid IS NULL
  THEN STMARA_EKS_ITEM_1.zrelevantmdm
  ELSE stmara_eks_item.zrelevantmdm
  END AS zrelevantmdm,
 STMARA_EKS_ITEM_1.zsource,
 STMARA_EKS_ITEM_1.zactive,
 STMARA_EKS_ITEM_1.znegotiatingcountry,
 STMARA_EKS_ITEM_1.itemid,
 STMARA_EKS_ITEM_1.itemno,
 STMARA_EKS_ITEM_1.zarticletype,
 STMARA_EKS_ITEM_1.description_int,
 STMARA_EKS_ITEM_1.zmatkl,
 STMARA_EKS_ITEM_1.articlefamily,
 STMARA_EKS_ITEM_1.buyerid,
 STMARA_EKS_ITEM_1.buyerfirstname,
 STMARA_EKS_ITEM_1.buyerlastname,
 STMARA_EKS_ITEM_1.buyershortsign,
 IFNULL(supplier.supplierno, STEKS_SUPPLIER_1.supplierno) AS supplierno,
 IFNULL(supplier.description, STEKS_SUPPLIER_1.description) AS supplierdescription,
 IFNULL(steks_listingoverviewmax.receivingcountry, STEKS_LISTINGOVERVIEWMAX_1.receivingcountry) AS receivingcountry,
 itemdetail.bundlefact AS gebinde_anzahl,
 itemdetail.volume AS gebinde_inhalt,
 ITEM_UNIT.description AS gebinde_einheit,
 PACKAGE_TYPE.description AS gebinde_verpakung,
 itemdetail.netweight,
 itemdetail.text_int AS zusatz_gew_art_int,
 itemdetail.text_nat AS zusatz_gew_art_nat
FROM idq_production_eks_calculation.stmara_eks_item_2 AS STMARA_EKS_ITEM_1
 INNER JOIN idq_production_eks.itemdetail_2 ON STMARA_EKS_ITEM_1.itemid = itemdetail.itemid
 LEFT JOIN (idq_production_eks.itemsorting_2 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 ON itemsorting.sortitemid
      = stmara_eks_item.itemid AND stmara_eks_item.zarticletype = 'SK' AND stmara_eks_item.ziscurrentcontract = 1) ON
  STMARA_EKS_ITEM_1.itemid = itemsorting.itemid
 LEFT JOIN (idq_production_eks.supplier_2 AS STEKS_SUPPLIER_1 INNER JOIN idq_production_eks_calculation.steks_listingoverviewmax_2
   AS STEKS_LISTINGOVERVIEWMAX_1 ON STEKS_SUPPLIER_1.supplierno = STEKS_LISTINGOVERVIEWMAX_1.supplierno) ON itemsorting_2
  .sortitemid = STEKS_LISTINGOVERVIEWMAX_1.itemid
 LEFT JOIN (idq_production_eks.translation_int_unit_2 AS ITEM_UNIT INNER JOIN idq_production_eks.unit_2 ON ITEM_UNIT.translationid
    = unit.shortdescid) ON itemdetail.unitid = unit.unitid
 LEFT JOIN (idq_production_eks.package_2 INNER JOIN idq_production_eks.translation_int_2 AS PACKAGE_TYPE ON package.shortdescid
    = PACKAGE_TYPE.translationid) ON itemdetail.packageid = package.packageid
 LEFT JOIN idq_production_eks_calculation.steks_listingoverviewmax_2 ON STMARA_EKS_ITEM_1.itemid =
  steks_listingoverviewmax.itemid
 LEFT JOIN idq_production_eks.supplier_2 ON steks_listingoverviewmax.supplierno = supplier.supplierno
WHERE STMARA_EKS_ITEM_1.zarticletype = 'EA' AND STMARA_EKS_ITEM_1.ziscurrentcontract = 1 AND STMARA_EKS_ITEM_1.zactive =
   1
 OR STMARA_EKS_ITEM_1.zarticletype = 'EA' AND STMARA_EKS_ITEM_1.zactive = 1 AND STMARA_EKS_ITEM_1.ziscurrentcontractfromsk
    = 1;