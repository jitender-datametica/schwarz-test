CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zitem_ba_updsel (listingoverviewid
, location, supplierno, cr_locationid, receivingcountry, itemid, casesize, zarticletypenew, zarticletype, zitem_banew,
zitem_ba) AS SELECT steks_listingoverviewmax.listingoverviewid,
 steks_listingoverviewmax.location,
 steks_listingoverviewmax.supplierno,
 steks_listingoverviewmax.cr_locationid,
 steks_listingoverviewmax.receivingcountry,
 steks_listingoverviewmax.itemid,
 steks_listingoverviewmax.casesize,
 stmara_eks_item.zarticletype AS zarticletypenew,
 steks_listingoverviewmax.zarticletype,
 stmara_eks_item.zitem_ba AS zitem_banew,
 steks_listingoverviewmax.zitem_ba
FROM idq_production_eks_calculation.steks_listingoverviewmax
 INNER JOIN idq_production_eks_calculation.stmara_eks_item ON steks_listingoverviewmax.itemid = stmara_eks_item.itemid
WHERE steks_listingoverviewmax.zarticletype IS NULL;