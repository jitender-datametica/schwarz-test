CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_nettgreatergross_sel_1 (negotiatingcountry,
buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description,
total_casenetweight, casegrossweight, decimalcasesize, listingoverviewid, supplierno, supplierdescription,
receivingcountry, zrelevantmdm, zsource, zactive, execution_time) AS SELECT svmara_eks_item_nettgreatergross_sel_all.negotiatingcountry
 ,
 svmara_eks_item_nettgreatergross_sel_all.buyershortsign,
 svmara_eks_item_nettgreatergross_sel_all.buyerfirstname,
 svmara_eks_item_nettgreatergross_sel_all.buyerlastname,
 svmara_eks_item_nettgreatergross_sel_all.zmatkl,
 svmara_eks_item_nettgreatergross_sel_all.articlefamily,
 svmara_eks_item_nettgreatergross_sel_all.itemid,
 svmara_eks_item_nettgreatergross_sel_all.itemno,
 svmara_eks_item_nettgreatergross_sel_all.articletype,
 svmara_eks_item_nettgreatergross_sel_all.description,
 REPLACE(REPLACE(SUBSTR(CAST(svmara_eks_item_nettgreatergross_sel_all.total_casenetweight AS STRING), 1, 16), CHR(10),
   ' '), CHR(13), ' ') AS total_casenetweight,
 REPLACE(REPLACE(SUBSTR(CAST(svmara_eks_item_nettgreatergross_sel_all.casegrossweight AS STRING), 1, 9), CHR(10), ' '),
  CHR(13), ' ') AS casegrossweight,
 REPLACE(REPLACE(SUBSTR(CAST(svmara_eks_item_nettgreatergross_sel_all.decimalcasesize AS STRING), 1, 7), CHR(10), ' '),
  CHR(13), ' ') AS decimalcasesize,
 svmara_eks_item_nettgreatergross_sel_all.listingoverviewid,
 svmara_eks_item_nettgreatergross_sel_all.supplierno,
 svmara_eks_item_nettgreatergross_sel_all.supplierdescription,
 svmara_eks_item_nettgreatergross_sel_all.receivingcountry,
 svmara_eks_item_nettgreatergross_sel_all.zrelevantmdm,
 svmara_eks_item_nettgreatergross_sel_all.zsource,
 svmara_eks_item_nettgreatergross_sel_all.zactive,
 idq_production_eks_calculation.getlastexecutiontime() AS execution_time
FROM idq_production_eks_calculation.svmara_eks_item_nettgreatergross_sel_all_1
 LEFT JOIN idq_production_eks_calculation.eks_zsm_excludelist_1 ON svmara_eks_item_nettgreatergross_sel_all.itemno =
    eks_zsm_excludelist.itemno AND (svmara_eks_item_nettgreatergross_sel_all.supplierno = eks_zsm_excludelist.supplierno
          AND eks_zsm_excludelist.listingoverviewid IS NULL OR svmara_eks_item_nettgreatergross_sel_all.listingoverviewid
          = eks_zsm_excludelist.listingoverviewid AND eks_zsm_excludelist.supplierno IS NULL OR
        svmara_eks_item_nettgreatergross_sel_all.supplierno = eks_zsm_excludelist.supplierno AND
        svmara_eks_item_nettgreatergross_sel_all.listingoverviewid = eks_zsm_excludelist.listingoverviewid OR
      eks_zsm_excludelist.supplierno IS NULL AND eks_zsm_excludelist.listingoverviewid IS NULL) AND eks_zsm_excludelist_1
   .reportno = '005'
WHERE eks_zsm_excludelist.itemno IS NULL
 AND svmara_eks_item_nettgreatergross_sel_all.zactive = 1;
