CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zactive_020 (listingoverviewid
, supplierno, receivingcountry, zitem_ba) AS SELECT MAX(t1.listingoverviewid) AS listingoverviewid,
 t3.supplierno,
 steks_location_1.shortsign AS receivingcountry,
 t8.zitem_ba
FROM idq_production_eks.listingoverview AS t1
 INNER JOIN idq_production_eks.contractlink AS t2 ON t1.listingoverviewid = t2.listingoverviewid
 INNER JOIN idq_production_eks.supplier AS t3 ON t1.supplierno = t3.supplierno
 INNER JOIN idq_production_eks.location AS t4 ON t1.cr_locationid = t4.locationid
 INNER JOIN idq_production_eks.location AS steks_location_1 ON t2.locationid = steks_location_1.locationid
 INNER JOIN idq_production_eks.contractpricerel AS t5 ON t2.contractlinkid = t5.contractlinkid
 INNER JOIN idq_production_eks.basicprice AS t6 ON t5.basicpriceid = t6.basicpriceid
 INNER JOIN idq_production_eks.listingitem AS t7 ON t6.listingitemid = t7.listingitemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS t8 ON t7.itemid = t8.itemid
 LEFT JOIN idq_production_eks_calculation.eks_zsm_articleparameter AS t9 ON t9.id = 'DRDATE'
WHERE t2.statusid IN (34, 86)
 AND t1.dateuntil >= t9.date
 AND t8.zarticletype = 'SK'
GROUP BY t3.supplierno,
 receivingcountry,
 t8.zitem_ba;