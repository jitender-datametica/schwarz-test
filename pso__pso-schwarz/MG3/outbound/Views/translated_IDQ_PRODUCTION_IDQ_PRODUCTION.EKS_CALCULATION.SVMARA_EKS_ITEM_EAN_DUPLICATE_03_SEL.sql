CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_ean_duplicate_03_sel (ean, item_count, max_zmatkl
, min_zmatkl, count_zmatkl, count_negcountry, brandtypeid, ziswawirelevant) AS SELECT t1.ean,
 t1.item_count,
 t1.max_zmatkl,
 t1.min_zmatkl,
 t1.count_zmatkl,
 t1.count_negcountry,
 t1.brandtypeid0 AS brandtypeid,
 t1.ziswawirelevant
FROM (SELECT itemean.ean,
   xteks_basicinfo_reccountry.ziswawirelevant,
   item.brandtypeid AS brandtypeid0,
   COUNT(DISTINCT stmara_eks_item.itemno) AS item_count,
   MAX(stmara_eks_item.zmatkl) AS max_zmatkl,
   MIN(stmara_eks_item.zmatkl) AS min_zmatkl,
   COUNT(DISTINCT stmara_eks_item.zmatkl) AS count_zmatkl,
   COUNT(DISTINCT stmara_eks_item.znegotiatingcountry) AS count_negcountry
  FROM idq_production_eks_calculation.stmara_eks_item
   INNER JOIN idq_production_eks.itemean ON stmara_eks_item.itemid = itemean.itemid
   INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry ON stmara_eks_item.itemid =
    xteks_basicinfo_reccountry.itemid
   LEFT JOIN idq_production_eks.itemdetail ON stmara_eks_item.itemid = itemdetail.itemid
   INNER JOIN idq_production_eks.item ON stmara_eks_item.itemid = item.itemid
  WHERE stmara_eks_item.zarticletype = 'EA' AND item.brandtypeid IN (1, 4) AND stmara_eks_item.ziscurrentcontract = 1
      AND itemdetail.text_int IS NULL AND itemdetail.text_nat IS NULL AND stmara_eks_item.znegotiatingcountry NOT IN ('CH'
      , 'DE', 'AT')
   OR stmara_eks_item.zarticletype = 'EA' AND item.brandtypeid IN (1, 4) AND itemdetail.text_int IS NULL AND itemdetail
      .text_nat IS NULL AND stmara_eks_item.ziscurrentcontractfromsk = 1 AND stmara_eks_item.znegotiatingcountry NOT IN
      ('CH', 'DE', 'AT')
   OR stmara_eks_item.zarticletype = 'EA' AND item.brandtypeid IN (1, 4) AND stmara_eks_item.ziscurrentcontract = 1 AND
     itemdetail.text_int IS NULL AND stmara_eks_item.znegotiatingcountry IN ('CH', 'DE', 'AT')
   OR stmara_eks_item.zarticletype = 'EA' AND item.brandtypeid IN (1, 4) AND itemdetail.text_int IS NULL AND
      stmara_eks_item.znegotiatingcountry IN ('CH', 'DE', 'AT') AND stmara_eks_item.ziscurrentcontractfromsk = 1
  GROUP BY itemean.ean,
   xteks_basicinfo_reccountry.ziswawirelevant,
   item.brandtypeid
  HAVING item_count > 1) AS t1;