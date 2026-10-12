CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zarticletypeupdsel_1 (listingoverviewid
, itemid, receivingcountry, casesize, zarticletype, zarticletypenew) AS SELECT DISTINCT T1.listingoverviewid,
 T1.itemid,
 T1.receivingcountry,
 T1.casesize,
 T1.zarticletype,
 T2.zarticletype AS zarticletypenew
FROM idq_production_eks_calculation.steks_listingoverviewmax_1 AS T1_1
 LEFT JOIN idq_production_eks_calculation.stmara_eks_item_1 AS T2 ON T1.itemid = T2.itemid;