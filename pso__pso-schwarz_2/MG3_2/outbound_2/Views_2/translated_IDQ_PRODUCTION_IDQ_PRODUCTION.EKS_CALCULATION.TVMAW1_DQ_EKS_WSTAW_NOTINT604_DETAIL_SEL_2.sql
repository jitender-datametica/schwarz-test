CREATE OR REPLACE VIEW idq_production_eks_calculation.tvmaw1_dq_eks_wstaw_notint604_detail_sel_2 (negotiatingcountry,
buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description, wstaw,
supplierno, supplierdescription, zrelevantmdm, zsource, zactive) AS SELECT DISTINCT stmara_eks_item.znegotiatingcountry
 AS negotiatingcountry,
 stmara_eks_item.buyershortsign,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype AS articletype,
 stmara_eks_item.description_int AS description,
 instrastat.commoditycode AS wstaw,
 supplier.intsupplierno AS supplierno,
 supplier.description AS supplierdescription,
 xteks_basicinfo_reccountry.ziswawirelevant AS zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM (SELECT itemid,
    CASE
    WHEN LENGTH(intrastat) = 10 AND RIGHT(intrastat, 2) = '00'
    THEN LEFT(intrastat, 8)
    ELSE intrastat
    END AS commoditycode,
   moddate
  FROM idq_production_eks.itemintrastat_2
  WHERE intrastat IS NOT NULL) AS instrastat
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 ON instrastat.itemid = stmara_eks_item.itemid
 LEFT JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_2 ON stmara_eks_item.itemno =
  xteks_basicinfo_reccountry.itemno
 LEFT JOIN idq_production_eks.supplier_2 ON xteks_basicinfo_reccountry.supplierno = supplier.supplierno
 LEFT JOIN idq_production_zsm.t604_2 ON instrastat.commoditycode = t604.stawn
 LEFT JOIN idq_production_eks_calculation.eks_zsm_excludelist_2 ON stmara_eks_item.itemno = eks_zsm_excludelist.itemno AND
    (eks_zsm_excludelist.supplierno IS NULL OR supplier.intsupplierno = eks_zsm_excludelist.supplierno) AND
   eks_zsm_excludelist.reportno = '036'
WHERE t604.stawn IS NULL
 AND instrastat.commoditycode <> ''
 AND stmara_eks_item.zactive = 1
 AND eks_zsm_excludelist.itemno IS NULL;