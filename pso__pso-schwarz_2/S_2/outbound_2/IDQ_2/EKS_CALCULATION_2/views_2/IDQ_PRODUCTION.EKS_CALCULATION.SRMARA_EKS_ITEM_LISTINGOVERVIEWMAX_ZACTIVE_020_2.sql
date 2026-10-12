CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zactive_020_2 (listingoverviewid
, supplierno, receivingcountry, zitem_ba) AS SELECT MAX(T1.listingoverviewid) AS listingoverviewid,
 T3.supplierno,
 STEKS_LOCATION_1.shortsign AS receivingcountry,
 T8.zitem_ba
FROM idq_production_eks.listingoverview_2 AS T1_2
 INNER JOIN idq_production_eks.contractlink_2 AS T2 ON T1.listingoverviewid = T2.listingoverviewid
 INNER JOIN idq_production_eks.supplier_2 AS T3 ON T1.supplierno = T3.supplierno
 INNER JOIN idq_production_eks.location_2 AS T4 ON T1.cr_locationid = T4.locationid
 INNER JOIN idq_production_eks.location_2 AS STEKS_LOCATION_1 ON T2.locationid = STEKS_LOCATION_1.locationid
 INNER JOIN idq_production_eks.contractpricerel_2 AS T5 ON T2.contractlinkid = T5.contractlinkid
 INNER JOIN idq_production_eks.basicprice_2 AS T6 ON T5.basicpriceid = T6.basicpriceid
 INNER JOIN idq_production_eks.listingitem_2 AS T7 ON T6.listingitemid = T7.listingitemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS T8 ON T7.itemid = T8.itemid
 LEFT JOIN idq_production_eks_calculation.eks_zsm_articleparameter_2 AS T9 ON T9.id = 'DRDATE'
WHERE T2.statusid IN (34, 86)
 AND T1.dateuntil >= T9.date
 AND T8.zarticletype = 'SK'
GROUP BY T3.supplierno,
 receivingcountry,
 T8.zitem_ba;