CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_missingkolligtin_010 (listingoverviewid) AS
SELECT xteks_basicinfo_union.listingoverviewid
FROM idq_production_eks_calculation.xteks_basicinfo_union
 LEFT JOIN (SELECT xteks_basicinfo_reccountry.sk_itemid,
   MAX(item.brandtypeid) AS max_brandtype
  FROM idq_production_eks_calculation.xteks_basicinfo_reccountry
   INNER JOIN idq_production_eks.item ON item.brandtypeid = 1 AND xteks_basicinfo_reccountry.itemid = item.itemid AND
    xteks_basicinfo_reccountry.sk_itemid IS NOT NULL
  GROUP BY xteks_basicinfo_reccountry.sk_itemid) AS brandtype ON xteks_basicinfo_union.itemid = brandtype.sk_itemid
 LEFT JOIN idq_production_eks.item AS item0 ON item0.brandtypeid IN (1) AND xteks_basicinfo_union.itemid = item0.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item ON xteks_basicinfo_union.itemid = stmara_eks_item.itemid
 LEFT JOIN idq_production_eks.itemgtin AS ITG ON xteks_basicinfo_union.itemid = ITG.itemid AND (ITG.casesize IS NULL OR
      xteks_basicinfo_union.casesize = CASE
       WHEN TRUNC(CAST(ITG.casesize AS BIGNUMERIC), 0) = 0
       THEN 1
       ELSE TRUNC(CAST(ITG.casesize AS BIGNUMERIC), 0)
       END OR xteks_basicinfo_union.zarticletype = 'SK')
WHERE item0.brandtypeid = 1
 OR brandtype.max_brandtype = 1
GROUP BY xteks_basicinfo_union.listingoverviewid
HAVING COUNT(stmara_eks_item.itemno) <> COUNT(ITG.gtin) AND SUM(CASE
    WHEN ITG.no_gtin IS NULL
    THEN 1
    ELSE ITG.no_gtin
    END) <> COUNT(stmara_eks_item.itemno);