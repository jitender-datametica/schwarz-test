CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_ea_updsel_1 (itemid
, zhasvalidadsflg, zhasvalidadsflgnew, adsflg, value, zhasvalidcontractdate, zhasvalidcontractdatenew, item_dateuntil,
date, zarticletype) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.zhasvalidadsflg,
 1 AS zhasvalidadsflgnew,
 EAVALIDITY.adsflg,
 P0.value,
 stmara_eks_item.zhasvalidcontractdate,
 1 AS zhasvalidcontractdatenew,
 MAX(EAVALIDITY.dateuntil) AS item_dateuntil,
 P2.date,
 stmara_eks_item.zarticletype
FROM idq_production_eks.contractpricevalidity_1 AS EAVALIDITY
 RIGHT JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_1 AS EALINK ON EAVALIDITY.contractpricevalidityid =
  EALINK.contractpricevalidityid
 RIGHT JOIN idq_production_eks_calculation.steks_listingoverviewmax_1 ON EALINK.listingoverviewid =
       steks_listingoverviewmax.listingoverviewid AND EALINK.casesize = steks_listingoverviewmax.casesize AND EALINK.itemid
       = steks_listingoverviewmax.itemid AND EALINK.receivingcountry = steks_listingoverviewmax.receivingcountry AND
    EALINK.supplierno = steks_listingoverviewmax.supplierno AND EALINK.sk_itemid IS NULL
 RIGHT JOIN idq_production_eks_calculation.stmara_eks_item_1 ON steks_listingoverviewmax.itemid = stmara_eks_item.itemid
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter_1 AS P0 ON P0.id = 'ADSFLGCHK'
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter_1 AS P1 ON P1.id = 'ADSFLGON'
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter_1 AS P2 ON P2.id = 'VALIDITYDATE' AND EAVALIDITY.dateuntil
    >= P2.date
WHERE stmara_eks_item.constructed IS NULL AND stmara_eks_item.zarticletype = 'EA' AND EAVALIDITY.adsflg = P0.value
 OR stmara_eks_item.constructed IS NULL AND stmara_eks_item.zarticletype = 'EA' AND P1.value = 0
GROUP BY stmara_eks_item.itemid,
 stmara_eks_item.zhasvalidadsflg,
 zhasvalidadsflgnew,
 EAVALIDITY.adsflg,
 P0.value,
 stmara_eks_item.zhasvalidcontractdate,
 zhasvalidcontractdatenew,
 P2.date,
 stmara_eks_item.zarticletype;