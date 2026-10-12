CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_ea_updsel
(listingoverviewid, itemid, casesize, sk_itemid, supplierno, contractpricevalidityid, zisvalidcontract,
zisvalidcontractnew, dateuntil, adsflg, value, date) AS SELECT xteks_basicinfo_reccountry.listingoverviewid,
 xteks_basicinfo_reccountry.itemid,
 xteks_basicinfo_reccountry.casesize,
 xteks_basicinfo_reccountry.sk_itemid,
 xteks_basicinfo_reccountry.supplierno,
 xteks_basicinfo_reccountry.contractpricevalidityid,
 xteks_basicinfo_reccountry.zisvalidcontract,
 1 AS zisvalidcontractnew,
 contractpricevalidity.dateuntil,
 contractpricevalidity.adsflg,
 P0.value,
 P2.date
FROM idq_production_eks.contractpricevalidity
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry ON contractpricevalidity.contractpricevalidityid =
  xteks_basicinfo_reccountry.contractpricevalidityid
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter AS P0 ON P0.id = 'ADSFLGCHK'
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter AS P1 ON P1.id = 'ADSFLGON'
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter AS P2 ON P2.id = 'VALIDITYDATE' AND
   contractpricevalidity.dateuntil >= P2.date
 INNER JOIN idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_maxdateuntil_ea
 ON xteks_basicinfo_reccountry.listingoverviewid =
      srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_maxdateuntil_ea.listingoverviewid AND
      xteks_basicinfo_reccountry.itemid = srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_maxdateuntil_ea.itemid
       AND xteks_basicinfo_reccountry.receivingcountry =
     srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_maxdateuntil_ea.receivingcountry AND
    xteks_basicinfo_reccountry.supplierno = srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_maxdateuntil_ea
    .supplierno AND contractpricevalidity.dateuntil =
   srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_maxdateuntil_ea.maxdateuntil
WHERE contractpricevalidity.adsflg = P0.value
 OR P1.value = 0;