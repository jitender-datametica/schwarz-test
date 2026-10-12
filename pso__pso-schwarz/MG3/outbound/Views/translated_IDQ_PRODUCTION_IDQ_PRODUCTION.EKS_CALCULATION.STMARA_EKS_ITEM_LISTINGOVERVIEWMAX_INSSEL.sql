CREATE OR REPLACE VIEW idq_production_eks_calculation.stmara_eks_item_listingoverviewmax_inssel (listingoverviewid,
location, supplierno, cr_locationid, receivingcountry) AS SELECT MAX(t1.listingoverviewid) AS listingoverviewid,
 ' AS LOCATION,\nt3.SUPPLIERNO,\n' AS cr_locationid0,
 steks_location_1.shortsign AS receivingcountry,
 t7.itemid AS cr_locationid,
 t6.casesizecalc AS casesize
FROM idq_production_eks.listingoverview AS t1
 INNER JOIN idq_production_eks.contractlink AS t2 ON t1.listingoverviewid = t2.listingoverviewid
 INNER JOIN idq_production_eks.supplier AS t3 ON t1.supplierno = t3.supplierno
 INNER JOIN idq_production_eks.location AS t4 ON t1.cr_locationid = t4.locationid
 INNER JOIN idq_production_eks.location AS steks_location_1 ON t2.locationid = steks_location_1.locationid
 INNER JOIN idq_production_eks.contractpricerel AS t5 ON t2.contractlinkid = t5.contractlinkid
 INNER JOIN idq_production_eks.basicprice AS t6 ON t5.basicpriceid = t6.basicpriceid
 INNER JOIN idq_production_eks.listingitem AS t7 ON t6.listingitemid = t7.listingitemid
 LEFT JOIN idq_production_eks_calculation.eks_zsm_articleparameter AS t8 ON t8.id = 'DRDATE'
WHERE t2.statusid IN (34, 86)
 AND t1.dateuntil >= t8.date
GROUP BY t3.supplierno,
 receivingcountry,
 t7.itemid,
 casesize
HAVING t3.supplierno <> 10236;