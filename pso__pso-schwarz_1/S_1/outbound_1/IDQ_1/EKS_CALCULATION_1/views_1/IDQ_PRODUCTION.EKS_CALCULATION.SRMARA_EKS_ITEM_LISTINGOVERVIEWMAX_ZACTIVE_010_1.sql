CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zactive_010_1 (listingoverviewid
, supplierno, receivingcountry, itemid) AS SELECT MAX(T1.listingoverviewid) AS listingoverviewid,
 T3.supplierno,
 STEKS_LOCATION_1.shortsign AS receivingcountry,
 T7.itemid
FROM idq_production_eks.listingoverview_1 AS T1_1
 INNER JOIN idq_production_eks.contractlink_1 AS T2 ON T1.listingoverviewid = T2.listingoverviewid
 INNER JOIN idq_production_eks.supplier_1 AS T3 ON T1.supplierno = T3.supplierno
 INNER JOIN idq_production_eks.location_1 AS T4 ON T1.cr_locationid = T4.locationid
 INNER JOIN idq_production_eks.location_1 AS STEKS_LOCATION_1 ON T2.locationid = STEKS_LOCATION_1.locationid
 INNER JOIN idq_production_eks.contractpricerel_1 AS T5 ON T2.contractlinkid = T5.contractlinkid
 INNER JOIN idq_production_eks.basicprice_1 AS T6 ON T5.basicpriceid = T6.basicpriceid
 INNER JOIN idq_production_eks.listingitem_1 AS T7 ON T6.listingitemid = T7.listingitemid
 LEFT JOIN idq_production_eks_calculation.eks_zsm_articleparameter_1 AS T8 ON T8.id = 'DRDATE'
WHERE T2.statusid IN (34, 86)
 AND T1.dateuntil >= T8.date
GROUP BY T3.supplierno,
 receivingcountry,
 T7.itemid;