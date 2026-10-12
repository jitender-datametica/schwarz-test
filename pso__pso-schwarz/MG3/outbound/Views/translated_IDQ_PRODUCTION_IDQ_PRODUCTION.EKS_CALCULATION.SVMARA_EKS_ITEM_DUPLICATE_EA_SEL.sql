CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_duplicate_ea_sel AS WITH cte_eks AS (SELECT ea.itemid
     AS ea_itemid,
    st_sk.itemid AS sk_itemid,
    st_ba.itemid AS ba_itemid
   FROM idq_production_eks_calculation.stmara_eks_item AS ea
    INNER JOIN idq_production_eks.itemsorting ON ea.itemid = itemsorting.itemid
    INNER JOIN idq_production_eks_calculation.stmara_eks_item AS st_sk ON itemsorting.sortitemid = st_sk.itemid AND
       st_sk.zarticletype = 'SK' AND ea.zarticletype = 'EA'
    INNER JOIN idq_production_eks.itemsorting AS its_sk ON st_sk.itemid = its_sk.itemid
    INNER JOIN idq_production_eks_calculation.stmara_eks_item AS st_ba ON its_sk.sortitemid = st_ba.itemid AND st_ba.zarticletype
       = 'BA'
   UNION DISTINCT
   SELECT ea.itemid AS ea_itemid,
    CAST(NULL AS BIGNUMERIC) AS expr1,
    st_ba.itemid AS ba_itemid
   FROM idq_production_eks_calculation.stmara_eks_item AS ea
    INNER JOIN idq_production_eks.itemsorting AS steks_itemsorting_1 ON ea.itemid = steks_itemsorting_1.itemid AND ea.zarticletype
       = 'EA'
    INNER JOIN idq_production_eks_calculation.stmara_eks_item AS st_ba ON steks_itemsorting_1.sortitemid = st_ba.itemid
     AND st_ba.zarticletype = 'BA') (SELECT DISTINCT t6.znegotiatingcountry AS negotiatingcountry,
   t6.buyershortsign,
   t6.buyerfirstname,
   t6.buyerlastname,
   t6.zmatkl,
   t6.articlefamily,
   t6.itemid,
   t6.itemno,
   t6.zarticletype AS articletype,
   t6.description_int AS description,
   st_sk.itemno AS sk_itemno,
   st_sk.shortdesc_int AS sk_short_description,
   st_ba0.itemno AS ba_itemno,
   st_ba0.shortdesc_int AS ba_short_description,
    CASE
    WHEN st_sk.itemno IS NOT NULL
    THEN st_sk.zrelevantmdm
    ELSE t6.zrelevantmdm
    END AS zrelevantmdm,
   t6.zsource,
   t6.zactive
  FROM (SELECT *
    FROM idq_production_eks_calculation.stmara_eks_item
    WHERE itemid IN (SELECT ea_itemid
       FROM cte_eks
       GROUP BY ea_itemid
       HAVING COUNT(DISTINCT ba_itemid) > 1)) AS t6
   INNER JOIN cte_eks AS t10 ON t6.itemid = t10.ea_itemid AND t6.constructed IS NULL AND (t6.ziscurrentcontract = 1 OR
       t6.ziscurrentcontractfromsk = 1)
   INNER JOIN idq_production_eks_calculation.stmara_eks_item AS st_ba0 ON t10.ba_itemid = st_ba0.itemid
   LEFT JOIN idq_production_eks_calculation.stmara_eks_item AS st_sk ON t10.sk_itemid = st_sk.itemid
  WHERE t6.zactive = 1
  ORDER BY t6.itemno NULLS LAST);