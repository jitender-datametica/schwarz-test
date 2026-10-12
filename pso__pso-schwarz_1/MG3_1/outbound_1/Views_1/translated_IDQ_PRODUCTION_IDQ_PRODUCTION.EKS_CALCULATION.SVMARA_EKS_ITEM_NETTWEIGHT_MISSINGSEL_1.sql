CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_nettweight_missingsel_1 AS WITH its AS (SELECT ea.itemid
    ,
    lom.receivingcountry,
    MIN(sk0.zrelevantmdm) AS sk
   FROM idq_production_eks_calculation.stmara_eks_item_1 AS ea
    INNER JOIN idq_production_eks.itemsorting_1 AS its ON ea.itemid = its.itemid AND ea.zarticletype = 'EA'
    INNER JOIN idq_production_eks_calculation.steks_listingoverviewmax_1 AS lom ON its.sortitemid = lom.itemid
    INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS sk0 ON its.sortitemid = sk0.itemid AND sk0.zarticletype
       = 'SK'
   GROUP BY ea.itemid,
    lom.receivingcountry
   UNION DISTINCT
   SELECT DISTINCT ea.itemid,
    lom.receivingcountry,
    0 AS sk
   FROM idq_production_eks_calculation.stmara_eks_item_1 AS ea
    INNER JOIN idq_production_eks_calculation.steks_listingoverviewmax_1 AS lom ON ea.itemid = lom.itemid AND ea.zarticletype
       = 'EA') (SELECT DISTINCT stmara_eks_item.znegotiatingcountry AS negotiatingcountry,
   stmara_eks_item.buyershortsign,
   stmara_eks_item.buyerfirstname,
   stmara_eks_item.buyerlastname,
   stmara_eks_item.zmatkl,
   stmara_eks_item.articlefamily,
   stmara_eks_item.itemid,
   stmara_eks_item.itemno,
   stmara_eks_item.zarticletype AS articletype,
   stmara_eks_item.description_int AS description,
   itemdetail.bundlefact,
   itemdetail.volume,
   tr.description AS unitdescription,
    CASE
    WHEN stmara_eks_item.ziscurrentcontract = 1
    THEN stmara_eks_item.zrelevantmdm
    ELSE t3.sk
    END AS zrelevantmdm,
   stmara_eks_item.zsource,
   stmara_eks_item.zactive
  FROM idq_production_eks_calculation.stmara_eks_item_1
   LEFT JOIN idq_production_eks.itemdetail_1 ON stmara_eks_item.itemid = itemdetail.itemid
   LEFT JOIN idq_production_eks.unit_1 AS un ON itemdetail.unitid = un.unitid
   LEFT JOIN idq_production_eks.translation_int_1 AS tr ON un.shortdescid = tr.translationid
   LEFT JOIN its AS t3 ON stmara_eks_item.itemid = t3.itemid
   LEFT JOIN idq_production_eks_calculation.eks_zsm_excludelist_1 ON stmara_eks_item.itemno = eks_zsm_excludelist.itemno
    AND eks_zsm_excludelist.reportno = '020'
  WHERE (itemdetail.netweight IS NULL OR itemdetail.netweight = '')
   AND stmara_eks_item.constructed IS NULL
   AND stmara_eks_item.zarticletype = 'EA'
   AND stmara_eks_item.itemid IN (SELECT DISTINCT itemid
     FROM its
     WHERE receivingcountry NOT IN ('US', 'LX', 'EW', 'CH'))
   AND stmara_eks_item.zactive = 1
   AND eks_zsm_excludelist.itemno IS NULL
  ORDER BY stmara_eks_item.itemno NULLS LAST);