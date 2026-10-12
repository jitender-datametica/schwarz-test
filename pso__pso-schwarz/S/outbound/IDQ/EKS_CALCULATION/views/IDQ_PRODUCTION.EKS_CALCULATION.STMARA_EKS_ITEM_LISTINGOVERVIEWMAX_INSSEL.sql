CREATE OR REPLACE VIEW idq_production_eks_calculation.stmara_eks_item_listingoverviewmax_inssel (listingoverviewid,
location, supplierno, cr_locationid, receivingcountry, itemid, casesize) AS SELECT MAX(T1.listingoverviewid) AS
 listingoverviewid,
 '' AS location,
 T3.supplierno,
 '' AS cr_locationid,
 STEKS_LOCATION_1.shortsign AS receivingcountry,
 T7.itemid,
 T6.casesizecalc AS casesize
FROM idq_production_eks.listingoverview AS T1
 INNER JOIN idq_production_eks.contractlink AS T2 ON T1.listingoverviewid = T2.listingoverviewid
 INNER JOIN idq_production_eks.supplier AS T3 ON T1.supplierno = T3.supplierno
 INNER JOIN idq_production_eks.location AS T4 ON T1.cr_locationid = T4.locationid
 INNER JOIN idq_production_eks.location AS STEKS_LOCATION_1 ON T2.locationid = STEKS_LOCATION_1.locationid
 INNER JOIN idq_production_eks.contractpricerel AS T5 ON T2.contractlinkid = T5.contractlinkid
 INNER JOIN idq_production_eks.basicprice AS T6 ON T5.basicpriceid = T6.basicpriceid
 INNER JOIN idq_production_eks.listingitem AS T7 ON T6.listingitemid = T7.listingitemid
 LEFT JOIN idq_production_eks_calculation.eks_zsm_articleparameter AS T8 ON T8.id = 'DRDATE'
WHERE T2.statusid IN (34, 86)
 AND T1.dateuntil >= T8.date
GROUP BY T3.supplierno,
 receivingcountry,
 T7.itemid,
 casesize
HAVING T3.supplierno <> 10236;