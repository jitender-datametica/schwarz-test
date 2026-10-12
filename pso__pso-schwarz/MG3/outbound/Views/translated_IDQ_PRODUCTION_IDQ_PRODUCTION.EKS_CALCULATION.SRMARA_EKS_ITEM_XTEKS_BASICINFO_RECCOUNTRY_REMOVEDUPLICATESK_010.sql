CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_removeduplicatesk_010 (listingoverviewid
, sk_itemid, receivingcountry, casesize, maxdate) AS SELECT xteks_basicinfo_reccountry.listingoverviewid,
 xteks_basicinfo_reccountry.sk_itemid,
 xteks_basicinfo_reccountry.receivingcountry,
 xteks_basicinfo_reccountry.casesize,
 MAX(contractpricevalidity.dateuntil) AS maxdate
FROM idq_production_eks_calculation.xteks_basicinfo_reccountry
 INNER JOIN idq_production_eks.contractpricevalidity ON xteks_basicinfo_reccountry.contractpricevalidityid =
  contractpricevalidity.contractpricevalidityid
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter AS p0 ON p0.id = 'ADSFLGCHK'
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter AS p1 ON p1.id = 'ADSFLGON'
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter AS p2 ON p2.id = 'VALIDITYDATE' AND
   contractpricevalidity.dateuntil >= p2.date
WHERE contractpricevalidity.adsflg = p0.value AND xteks_basicinfo_reccountry.sk_itemid IS NOT NULL
 OR p1.value = 0 AND xteks_basicinfo_reccountry.sk_itemid IS NOT NULL
GROUP BY xteks_basicinfo_reccountry.listingoverviewid,
 xteks_basicinfo_reccountry.casesize,
 xteks_basicinfo_reccountry.sk_itemid,
 xteks_basicinfo_reccountry.receivingcountry
HAVING MIN(contractpricevalidity.dateuntil) <> maxdate;