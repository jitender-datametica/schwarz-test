CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_gtin_missing_changecountry_sel_1 (negotiatingcountry
, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description,
supplierno, supplierdescription, listingoverviewid, receivingcountry, zusatz, itemvalidfrom, itemvaliduntil,
zrelevantmdm, zsource, zactive) AS SELECT DISTINCT svmara_eks_item_gtin_missingsel_all.negotiatingcountry,
 svmara_eks_item_gtin_missingsel_all.buyershortsign,
 svmara_eks_item_gtin_missingsel_all.buyerfirstname,
 svmara_eks_item_gtin_missingsel_all.buyerlastname,
 svmara_eks_item_gtin_missingsel_all.zmatkl,
 svmara_eks_item_gtin_missingsel_all.articlefamily,
 svmara_eks_item_gtin_missingsel_all.itemid,
 svmara_eks_item_gtin_missingsel_all.itemno,
 svmara_eks_item_gtin_missingsel_all.articletype,
 svmara_eks_item_gtin_missingsel_all.description,
 svmara_eks_item_gtin_missingsel_all.supplierno,
 svmara_eks_item_gtin_missingsel_all.supplierdescription,
 svmara_eks_item_gtin_missingsel_all.listingoverviewid,
 svmara_eks_item_gtin_missingsel_all.receivingcountry,
 svmara_eks_item_gtin_missingsel_all.zusatz,
 FORMAT_DATE('%d.%m.%Y', DATE(svmara_eks_item_gtin_missingsel_all.itemvalidfrom)) AS itemvalidfrom,
 FORMAT_DATE('%d.%m.%Y', DATE(svmara_eks_item_gtin_missingsel_all.itemvaliduntil)) AS itemvaliduntil,
 svmara_eks_item_gtin_missingsel_all.zrelevantmdm,
 svmara_eks_item_gtin_missingsel_all.zsource,
 svmara_eks_item_gtin_missingsel_all.zactive
FROM idq_production_eks_calculation.svmara_eks_item_gtin_missingsel_all_1
 LEFT JOIN idq_production_eks_calculation.eks_zsm_excludelist_1 ON svmara_eks_item_gtin_missingsel_all.itemno =
    eks_zsm_excludelist.itemno AND (svmara_eks_item_gtin_missingsel_all.supplierno = eks_zsm_excludelist.supplierno AND
        eks_zsm_excludelist.listingoverviewid IS NULL OR svmara_eks_item_gtin_missingsel_all.listingoverviewid =
         eks_zsm_excludelist.listingoverviewid AND eks_zsm_excludelist.supplierno IS NULL OR
        svmara_eks_item_gtin_missingsel_all.supplierno = eks_zsm_excludelist.supplierno AND
        svmara_eks_item_gtin_missingsel_all.listingoverviewid = eks_zsm_excludelist.listingoverviewid OR
      eks_zsm_excludelist.supplierno IS NULL AND eks_zsm_excludelist.listingoverviewid IS NULL) AND eks_zsm_excludelist_1
   .reportno = '010.1'
WHERE eks_zsm_excludelist.itemno IS NULL
 AND svmara_eks_item_gtin_missingsel_all.negotiatingcountry <> svmara_eks_item_gtin_missingsel_all.suppliercountry;