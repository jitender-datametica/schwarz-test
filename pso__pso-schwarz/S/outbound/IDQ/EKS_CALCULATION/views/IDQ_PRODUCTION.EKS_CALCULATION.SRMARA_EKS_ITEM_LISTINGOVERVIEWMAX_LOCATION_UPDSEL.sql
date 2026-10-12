CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_location_updsel (listingoverviewid
, location, supplierno, cr_locationid, receivingcountry, itemid, casesize, cr_locationidnew, locationnew) AS SELECT
 steks_listingoverviewmax.listingoverviewid,
 steks_listingoverviewmax.location,
 steks_listingoverviewmax.supplierno,
 steks_listingoverviewmax.cr_locationid,
 steks_listingoverviewmax.receivingcountry,
 steks_listingoverviewmax.itemid,
 steks_listingoverviewmax.casesize,
 listingoverview.cr_locationid AS cr_locationidnew,
 location.shortsign AS locationnew
FROM idq_production_eks_calculation.steks_listingoverviewmax
 INNER JOIN idq_production_eks.listingoverview ON steks_listingoverviewmax.listingoverviewid = listingoverview.listingoverviewid
  
 INNER JOIN idq_production_eks.location ON listingoverview.cr_locationid = location.locationid;