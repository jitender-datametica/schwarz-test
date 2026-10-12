CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_sk_updsel (itemid
, zhasvalidadsflg, zhasvalidadsflgnew, adsflg, value, zhasvalidcontractdate, zhasvalidcontractdatenew, item_dateuntil,
date, zarticletype) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.zhasvalidadsflg,
 1 AS zhasvalidadsflgnew,
 skvalidity.adsflg,
 eks_zsm_articleparameter.value,
 stmara_eks_item.zhasvalidcontractdate,
 1 AS zhasvalidcontractdatenew,
 MAX(skvalidity.dateuntil) AS item_dateuntil,
 p2.date,
 stmara_eks_item.zarticletype
FROM idq_production_eks_calculation.stmara_eks_item
 LEFT JOIN ((SELECT DISTINCT listingoverviewid,
    casesize,
    sk_itemid,
    receivingcountry,
    supplierno,
    contractpricevalidityid
   FROM idq_production_eks_calculation.xteks_basicinfo_reccountry) AS SKLink LEFT JOIN idq_production_eks.contractpricevalidity
   AS skvalidity ON SKLink.contractpricevalidityid = skvalidity.contractpricevalidityid RIGHT JOIN
  idq_production_eks_calculation.steks_listingoverviewmax ON SKLink.listingoverviewid = steks_listingoverviewmax.listingoverviewid
        AND SKLink.casesize = steks_listingoverviewmax.casesize AND SKLink.sk_itemid = steks_listingoverviewmax.itemid
    AND SKLink.receivingcountry = steks_listingoverviewmax.receivingcountry AND SKLink.supplierno =
    steks_listingoverviewmax.supplierno) ON stmara_eks_item.itemid = steks_listingoverviewmax.itemid
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter ON eks_zsm_articleparameter.id = 'ADSFLGCHK'
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter AS eks_zsm_articleparameter_1 ON
  eks_zsm_articleparameter_1.id = 'ADSFLGON'
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter AS p2 ON p2.id = 'VALIDITYDATE'
WHERE (stmara_eks_item.constructed IS NULL AND stmara_eks_item.zarticletype = 'SK' AND skvalidity.adsflg =
     eks_zsm_articleparameter.value OR stmara_eks_item.constructed IS NULL AND stmara_eks_item.zarticletype = 'SK' AND
     eks_zsm_articleparameter_1.value = 0)
 AND skvalidity.dateuntil >= p2.date
GROUP BY stmara_eks_item.itemid,
 stmara_eks_item.zhasvalidadsflg,
 zhasvalidadsflgnew,
 skvalidity.adsflg,
 eks_zsm_articleparameter.value,
 stmara_eks_item.zhasvalidcontractdate,
 zhasvalidcontractdatenew,
 p2.date,
 stmara_eks_item.zarticletype;