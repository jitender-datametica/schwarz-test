CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_sk_updsel_2 (itemid
, zhasvalidadsflg, zhasvalidadsflgnew, adsflg, value, zhasvalidcontractdate, zhasvalidcontractdatenew, item_dateuntil,
date, zarticletype) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.zhasvalidadsflg,
 1 AS zhasvalidadsflgnew,
 SKVALIDITY.adsflg,
 eks_zsm_articleparameter.value,
 stmara_eks_item.zhasvalidcontractdate,
 1 AS zhasvalidcontractdatenew,
 MAX(SKVALIDITY.dateuntil) AS item_dateuntil,
 P2.date,
 stmara_eks_item.zarticletype
FROM idq_production_eks_calculation.stmara_eks_item_2
 LEFT JOIN ((SELECT DISTINCT listingoverviewid,
    casesize,
    sk_itemid,
    receivingcountry,
    supplierno,
    contractpricevalidityid
   FROM idq_production_eks_calculation.xteks_basicinfo_reccountry_2) AS SKLink LEFT JOIN idq_production_eks.contractpricevalidity_2
   AS SKVALIDITY ON SKLink.contractpricevalidityid = SKVALIDITY.contractpricevalidityid RIGHT JOIN
  idq_production_eks_calculation.steks_listingoverviewmax_2 ON SKLink.listingoverviewid = steks_listingoverviewmax.listingoverviewid
        AND SKLink.casesize = steks_listingoverviewmax.casesize AND SKLink.sk_itemid = steks_listingoverviewmax.itemid
    AND SKLink.receivingcountry = steks_listingoverviewmax.receivingcountry AND SKLink.supplierno =
    steks_listingoverviewmax.supplierno) ON stmara_eks_item.itemid = steks_listingoverviewmax.itemid
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter_2 ON eks_zsm_articleparameter.id = 'ADSFLGCHK'
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter_2 AS EKS_ZSM_ARTICLEPARAMETER_1 ON
  EKS_ZSM_ARTICLEPARAMETER_1.id = 'ADSFLGON'
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter_2 AS P2 ON P2.id = 'VALIDITYDATE'
WHERE (stmara_eks_item.constructed IS NULL AND stmara_eks_item.zarticletype = 'SK' AND SKVALIDITY.adsflg =
     eks_zsm_articleparameter.value OR stmara_eks_item.constructed IS NULL AND stmara_eks_item.zarticletype = 'SK' AND
     EKS_ZSM_ARTICLEPARAMETER_1.value = 0)
 AND SKVALIDITY.dateuntil >= P2.date
GROUP BY stmara_eks_item.itemid,
 stmara_eks_item.zhasvalidadsflg,
 zhasvalidadsflgnew,
 SKVALIDITY.adsflg,
 eks_zsm_articleparameter.value,
 stmara_eks_item.zhasvalidcontractdate,
 zhasvalidcontractdatenew,
 P2.date,
 stmara_eks_item.zarticletype;