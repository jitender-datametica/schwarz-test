CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_rlz_mhd_notmantained_010_1 (negotiatingcountry
, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, sk_itemno, sk_description_int, itemid, itemno,
articletype, description, listingoverviewid, supplierno, supplierdescription, receivingcountry, zrelevantmdm, zsource,
zactive) AS SELECT DISTINCT t2.negotiatingcountry,
 t2.buyershortsign,
 t2.buyerfirstname,
 t2.buyerlastname,
 t2.zmatkl,
 t2.articlefamily,
 t2.sk_itemno,
 t2.sk_description_int,
 t2.itemid,
 t2.itemno,
 t2.articletype,
 t2.description,
 t2.listingoverviewid,
 t2.supplierno,
 t2.supplierdescription,
 t2.receivingcountry,
 t2.zrelevantmdm0 AS zrelevantmdm,
 t2.zsource,
 t2.zactive
FROM (SELECT stmara_eks_item.znegotiatingcountry AS negotiatingcountry,
   stmara_eks_item.buyershortsign,
   stmara_eks_item.buyerfirstname,
   stmara_eks_item.buyerlastname,
   stmara_eks_item.zmatkl,
   stmara_eks_item.articlefamily,
   stmara_eks_item.itemid,
   stmara_eks_item.itemno,
   stmara_eks_item.zarticletype AS articletype,
   stmara_eks_item.description_int AS description,
   xteks_basicinfo_reccountry.sk_itemno,
   xteks_basicinfo_reccountry.sk_description_int,
   SH.whfactor,
   TR.description AS description0,
   SH1.whfactor AS whfactor0,
   TR1.description AS description00,
   SIGN_EA.signspecid,
   xteks_basicinfo_reccountry.listingoverviewid,
   SUP.intsupplierno AS supplierno,
   SUP.description AS supplierdescription,
   xteks_basicinfo_reccountry.receivingcountry,
   stmara_eks_item.zrelevantmdm,
   xteks_basicinfo_reccountry.ziswawirelevant AS zrelevantmdm0,
   stmara_eks_item.zsource,
   stmara_eks_item.zactive,
   MIN(ITS.bestbeforedate),
   MIN(ITS1.bestbeforedate)
  FROM idq_production_eks_calculation.stmara_eks_item_1
   INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_1 ON stmara_eks_item.itemid =
    xteks_basicinfo_reccountry.itemid
   LEFT JOIN idq_production_eks.itemshelftime_1 AS ITS ON xteks_basicinfo_reccountry.contractpricevalidityid = ITS.contractpricevalidityid
      AND xteks_basicinfo_reccountry.itemid = ITS.itemid
   LEFT JOIN idq_production_eks.shelftime_1 AS SH ON ITS.shelftimeid = SH.shelftimeid
   LEFT JOIN idq_production_eks.unit_1 AS UN ON SH.whtimeunitid = UN.unitid
   LEFT JOIN idq_production_eks.translation_int_1 AS TR ON UN.shortdescid = TR.translationid
   LEFT JOIN idq_production_eks.itemshelftime_1 AS ITS1 ON xteks_basicinfo_reccountry.contractpricevalidityid = ITS1.contractpricevalidityid
      AND xteks_basicinfo_reccountry.sk_itemid = ITS1.itemid
   LEFT JOIN idq_production_eks.shelftime_1 AS SH1 ON ITS1.shelftimeid = SH1.shelftimeid
   LEFT JOIN idq_production_eks.unit_1 AS UN1 ON SH1.whtimeunitid = UN1.unitid
   LEFT JOIN idq_production_eks.translation_int_1 AS TR1 ON UN1.shortdescid = TR1.translationid
   LEFT JOIN idq_production_eks.supplier_1 AS SUP ON xteks_basicinfo_reccountry.supplierno = SUP.supplierno
   LEFT JOIN idq_production_eks.itemsign_1 AS SIGN_EA ON xteks_basicinfo_reccountry.itemid = SIGN_EA.itemid
  WHERE CASE
     WHEN stmara_eks_item.zmatkl IN ('60', '61', '63', '80', '82', '83', '84', '85', '86')
     THEN 1
     WHEN stmara_eks_item.articlefamily = '44.30' AND LOWER(stmara_eks_item.description_int) LIKE '%essig%'
     THEN 1
     WHEN stmara_eks_item.articlefamily = '81.50' AND LOWER(stmara_eks_item.description_int) LIKE '%streu%'
     THEN 1
     ELSE 0
     END = 0
  GROUP BY negotiatingcountry,
   stmara_eks_item.buyershortsign,
   stmara_eks_item.buyerfirstname,
   stmara_eks_item.buyerlastname,
   stmara_eks_item.zmatkl,
   stmara_eks_item.articlefamily,
   stmara_eks_item.itemid,
   stmara_eks_item.itemno,
   articletype,
   description,
   xteks_basicinfo_reccountry.sk_itemno,
   xteks_basicinfo_reccountry.sk_description_int,
   SH.whfactor,
   description0,
   whfactor0,
   description00,
   SIGN_EA.signspecid,
   xteks_basicinfo_reccountry.listingoverviewid,
   supplierno,
   supplierdescription,
   xteks_basicinfo_reccountry.receivingcountry,
   stmara_eks_item.zrelevantmdm,
   zrelevantmdm0,
   stmara_eks_item.zsource,
   stmara_eks_item.zactive
  HAVING whfactor0 IS NULL AND SH.whfactor IS NULL AND MIN(ITS.bestbeforedate) IS NULL AND MIN(ITS1.bestbeforedate)
    IS NULL AND IFNULL(SIGN_EA.signspecid, 0) <> 14) AS t2;