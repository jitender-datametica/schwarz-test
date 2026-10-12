CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zactive_ea_updsel_2 (listingoverviewid
, location_2, supplierno, cr_locationid, receivingcountry, itemid, casesize, zactive, zactivenew) AS SELECT
 steks_listingoverviewmax.listingoverviewid,
 steks_listingoverviewmax.location_2,
 steks_listingoverviewmax.supplierno,
 steks_listingoverviewmax.cr_locationid,
 steks_listingoverviewmax.receivingcountry,
 steks_listingoverviewmax.itemid,
 steks_listingoverviewmax.casesize,
 steks_listingoverviewmax.zactive,
 1 AS zactivenew
FROM idq_production_eks_calculation.steks_listingoverviewmax_2
 INNER JOIN idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zactive_010_2 ON steks_listingoverviewmax.listingoverviewid
      = srmara_eks_item_listingoverviewmax_zactive_010.listingoverviewid AND steks_listingoverviewmax.supplierno =
     srmara_eks_item_listingoverviewmax_zactive_010.supplierno AND steks_listingoverviewmax.receivingcountry =
    srmara_eks_item_listingoverviewmax_zactive_010.receivingcountry AND steks_listingoverviewmax.itemid =
   srmara_eks_item_listingoverviewmax_zactive_010.itemid
WHERE steks_listingoverviewmax.zarticletype = 'EA';