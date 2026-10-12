CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_ea_updsel (itemid
, zhasvalidadsflg, zhasvalidadsflgnew, adsflg, value, zhasvalidcontractdate, zhasvalidcontractdatenew, item_dateuntil,
date, zarticletype) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.zhasvalidadsflg,
 1 AS zhasvalidadsflgnew,
 eavalidity.adsflg,
 p0.value,
 stmara_eks_item.zhasvalidcontractdate,
 1 AS zhasvalidcontractdatenew,
 MAX(eavalidity.dateuntil) AS item_dateuntil,
 p2.date,
 stmara_eks_item.zarticletype
FROM idq_production_eks.contractpricevalidity AS eavalidity
 RIGHT JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry AS ealink ON eavalidity.contractpricevalidityid =
  ealink.contractpricevalidityid
 RIGHT JOIN idq_production_eks_calculation.steks_listingoverviewmax ON ealink.listingoverviewid =
       steks_listingoverviewmax.listingoverviewid AND ealink.casesize = steks_listingoverviewmax.casesize AND ealink.itemid
       = steks_listingoverviewmax.itemid AND ealink.receivingcountry = steks_listingoverviewmax.receivingcountry AND
    ealink.supplierno = steks_listingoverviewmax.supplierno AND ealink.sk_itemid IS NULL
 RIGHT JOIN idq_production_eks_calculation.stmara_eks_item ON steks_listingoverviewmax.itemid = stmara_eks_item.itemid
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter AS p0 ON p0.id = 'ADSFLGCHK'
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter AS p1 ON p1.id = 'ADSFLGON'
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter AS p2 ON p2.id = 'VALIDITYDATE' AND eavalidity.dateuntil
    >= p2.date
WHERE stmara_eks_item.constructed IS NULL AND stmara_eks_item.zarticletype = 'EA' AND eavalidity.adsflg = p0.value
 OR stmara_eks_item.constructed IS NULL AND stmara_eks_item.zarticletype = 'EA' AND p1.value = 0
GROUP BY stmara_eks_item.itemid,
 stmara_eks_item.zhasvalidadsflg,
 zhasvalidadsflgnew,
 eavalidity.adsflg,
 p0.value,
 stmara_eks_item.zhasvalidcontractdate,
 zhasvalidcontractdatenew,
 p2.date,
 stmara_eks_item.zarticletype;