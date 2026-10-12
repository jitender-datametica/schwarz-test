CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zactive_sk_updsel (listingoverviewid
, location, supplierno, cr_locationid, receivingcountry, itemid, zactive, zactivenew) AS SELECT steks_listingoverviewmax
 .listingoverviewid,
 steks_listingoverviewmax.location,
 steks_listingoverviewmax.supplierno,
 steks_listingoverviewmax.cr_locationid,
 steks_listingoverviewmax.receivingcountry,
 steks_listingoverviewmax.itemid,
 steks_listingoverviewmax.zactive,
 1 AS zactivenew
FROM idq_production_eks_calculation.steks_listingoverviewmax
 INNER JOIN idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zactive_020 ON steks_listingoverviewmax.listingoverviewid
      = srmara_eks_item_listingoverviewmax_zactive_020.listingoverviewid AND steks_listingoverviewmax.supplierno =
     srmara_eks_item_listingoverviewmax_zactive_020.supplierno AND steks_listingoverviewmax.receivingcountry =
    srmara_eks_item_listingoverviewmax_zactive_020.receivingcountry AND steks_listingoverviewmax.zitem_ba =
   srmara_eks_item_listingoverviewmax_zactive_020.zitem_ba
WHERE steks_listingoverviewmax.zarticletype = 'SK'
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(steks_listingoverviewmax.listingoverviewid AS STRING),
      steks_listingoverviewmax.receivingcountry, CAST(steks_listingoverviewmax.itemid AS STRING) ORDER BY zactivenew
      IS NULL, zactivenew)) = 1;