CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_measurementsandcasegrossweightdifferences_010_1
(zrelevantmdm, zsource, zactive, znegotiatingcountry, itemid, itemno, zarticletype, description_int, zmatkl,
articlefamily, buyerid, buyerfirstname, buyerlastname, buyershortsign, casesize, decimalcasesize, listingoverviewid,
casedepth, casewidth, caseheight, lengthunit, casegrossweight, weightunit, supplierno, supplierdescription,
receivingcountry, conc, contractpricevalidityid) AS SELECT DISTINCT xteks_basicinfo_reccountry.ziswawirelevant AS
 zrelevantmdm,
 st.zsource,
 st.zactive,
 st.znegotiatingcountry,
 st.itemid,
 st.itemno,
 st.zarticletype,
 st.description_int,
 st.zmatkl,
 st.articlefamily,
 st.buyerid,
 st.buyerfirstname,
 st.buyerlastname,
 st.buyershortsign,
 xteks_basicinfo_reccountry.casesize,
 xteks_basicinfo_reccountry.decimalcasesize,
 xteks_basicinfo_reccountry.listingoverviewid,
 itd.casedepth,
 itd.casewidth,
 itd.caseheight,
 tr1.description AS lengthunit,
 iwg.casegrossweight,
 tr2.description AS weightunit,
 sup.intsupplierno AS supplierno,
 sup.description AS supplierdescription,
 xteks_basicinfo_reccountry.receivingcountry,
 CONCAT(itd.casedepth, itd.casewidth, itd.caseheight, tr1.description, iwg.casegrossweight, tr2.description) AS conc,
 itd.contractpricevalidityid
FROM idq_production_eks_calculation.stmara_eks_item_1 AS st
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_1 ON st.itemno = xteks_basicinfo_reccountry.itemno
   AND xteks_basicinfo_reccountry.sk_itemno IS NULL AND st.zarticletype = 'EA'
 LEFT JOIN idq_production_eks.itemdimension_1 AS itd ON xteks_basicinfo_reccountry.contractpricevalidityid = itd.contractpricevalidityid
    AND xteks_basicinfo_reccountry.itemid = itd.itemid
 LEFT JOIN idq_production_eks.unit_1 AS un1 ON itd.caseunitid = un1.unitid
 LEFT JOIN idq_production_eks.translation_int_unit_1 AS tr1 ON un1.shortdescid = tr1.translationid
 LEFT JOIN (SELECT contractpricevalidityid,
   itemid,
   casegrossweight,
   caseunitid
  FROM idq_production_eks.itemweight_1
  WHERE contractpricevalidityid IS NOT NULL
   AND itemid IS NOT NULL
   AND caseunitid IS NOT NULL) AS iwg ON xteks_basicinfo_reccountry.contractpricevalidityid = iwg.contractpricevalidityid
    AND itd.itemid = iwg.itemid
 LEFT JOIN idq_production_eks.unit_1 AS un2 ON iwg.caseunitid = un2.unitid
 LEFT JOIN idq_production_eks.translation_int_unit_1 AS tr2 ON un2.shortdescid = tr2.translationid
 LEFT JOIN idq_production_eks.supplier_1 AS sup ON xteks_basicinfo_reccountry.supplierno = sup.supplierno
UNION ALL
SELECT DISTINCT xteks_basicinfo_reccountry0.ziswawirelevant AS zrelevantmdm,
 st.zsource,
 st.zactive,
 st.znegotiatingcountry,
 st.itemid,
 st.itemno,
 st.zarticletype,
 st.description_int,
 st.zmatkl,
 st.articlefamily,
 st.buyerid,
 st.buyerfirstname,
 st.buyerlastname,
 st.buyershortsign,
 xteks_basicinfo_reccountry0.casesize,
 xteks_basicinfo_reccountry0.decimalcasesize,
 xteks_basicinfo_reccountry0.listingoverviewid,
 itd.casedepth,
 itd.casewidth,
 itd.caseheight,
 tr1.description AS lengthunit,
 iwg.casegrossweight,
 tr2.description AS weightunit,
 sup.intsupplierno AS supplierno,
 sup.description AS supplierdescription,
 xteks_basicinfo_reccountry0.receivingcountry,
 CONCAT(itd.casedepth, itd.casewidth, itd.caseheight, tr1.description, iwg.casegrossweight, tr2.description) AS conc,
 itd.contractpricevalidityid
FROM idq_production_eks_calculation.stmara_eks_item_1 AS st
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_1 AS xteks_basicinfo_reccountry0 ON st.itemno =
  xteks_basicinfo_reccountry0.sk_itemno
 LEFT JOIN idq_production_eks.itemdimension_1 AS itd ON xteks_basicinfo_reccountry0.contractpricevalidityid = itd.contractpricevalidityid
    AND xteks_basicinfo_reccountry0.sk_itemid = itd.itemid
 LEFT JOIN idq_production_eks.unit_1 AS un1 ON itd.caseunitid = un1.unitid
 LEFT JOIN idq_production_eks.translation_int_unit_1 AS tr1 ON un1.shortdescid = tr1.translationid
 LEFT JOIN (SELECT contractpricevalidityid,
   itemid,
   casegrossweight,
   caseunitid
  FROM idq_production_eks.itemweight_1
  WHERE contractpricevalidityid IS NOT NULL
   AND itemid IS NOT NULL
   AND caseunitid IS NOT NULL) AS iwg ON xteks_basicinfo_reccountry0.contractpricevalidityid = iwg.contractpricevalidityid
    AND itd.itemid = iwg.itemid
 LEFT JOIN idq_production_eks.unit_1 AS un2 ON iwg.caseunitid = un2.unitid
 LEFT JOIN idq_production_eks.translation_int_unit_1 AS tr2 ON un2.shortdescid = tr2.translationid
 LEFT JOIN idq_production_eks.supplier_1 AS sup ON xteks_basicinfo_reccountry0.supplierno = sup.supplierno;