CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_measurementsandcasegrossweightdifferences_010
(zrelevantmdm, zsource, zactive, znegotiatingcountry, itemid, itemno, zarticletype, description_int, zmatkl,
articlefamily, buyerid, buyerfirstname, buyerlastname, buyershortsign, casesize, decimalcasesize, listingoverviewid,
casedepth, casewidth, caseheight, lengthunit, casegrossweight, weightunit, supplierno, supplierdescription,
receivingcountry, conc, contractpricevalidityid) AS SELECT DISTINCT xteks_basicinfo_reccountry.ziswawirelevant AS
 zrelevantmdm,
 ST.zsource,
 ST.zactive,
 ST.znegotiatingcountry,
 ST.itemid,
 ST.itemno,
 ST.zarticletype,
 ST.description_int,
 ST.zmatkl,
 ST.articlefamily,
 ST.buyerid,
 ST.buyerfirstname,
 ST.buyerlastname,
 ST.buyershortsign,
 xteks_basicinfo_reccountry.casesize,
 xteks_basicinfo_reccountry.decimalcasesize,
 xteks_basicinfo_reccountry.listingoverviewid,
 ITD.casedepth,
 ITD.casewidth,
 ITD.caseheight,
 TR1.description AS lengthunit,
 iwg.casegrossweight,
 TR2.description AS weightunit,
 SUP.intsupplierno AS supplierno,
 SUP.description AS supplierdescription,
 xteks_basicinfo_reccountry.receivingcountry,
 CONCAT(ITD.casedepth, ITD.casewidth, ITD.caseheight, TR1.description, iwg.casegrossweight, TR2.description) AS conc,
 ITD.contractpricevalidityid
FROM idq_production_eks_calculation.stmara_eks_item AS ST
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry ON ST.itemno = xteks_basicinfo_reccountry.itemno
   AND xteks_basicinfo_reccountry.sk_itemno IS NULL AND ST.zarticletype = 'EA'
 LEFT JOIN idq_production_eks.itemdimension AS ITD ON xteks_basicinfo_reccountry.contractpricevalidityid = ITD.contractpricevalidityid
    AND xteks_basicinfo_reccountry.itemid = ITD.itemid
 LEFT JOIN idq_production_eks.unit AS UN1 ON ITD.caseunitid = UN1.unitid
 LEFT JOIN idq_production_eks.translation_int_unit AS TR1 ON UN1.shortdescid = TR1.translationid
 LEFT JOIN (SELECT contractpricevalidityid,
   itemid,
   casegrossweight,
   caseunitid
  FROM idq_production_eks.itemweight
  WHERE contractpricevalidityid IS NOT NULL
   AND itemid IS NOT NULL
   AND caseunitid IS NOT NULL) AS iwg ON xteks_basicinfo_reccountry.contractpricevalidityid = iwg.contractpricevalidityid
    AND ITD.itemid = iwg.itemid
 LEFT JOIN idq_production_eks.unit AS UN2 ON iwg.caseunitid = UN2.unitid
 LEFT JOIN idq_production_eks.translation_int_unit AS TR2 ON UN2.shortdescid = TR2.translationid
 LEFT JOIN idq_production_eks.supplier AS SUP ON xteks_basicinfo_reccountry.supplierno = SUP.supplierno
UNION ALL
SELECT DISTINCT xteks_basicinfo_reccountry0.ziswawirelevant AS zrelevantmdm,
 ST.zsource,
 ST.zactive,
 ST.znegotiatingcountry,
 ST.itemid,
 ST.itemno,
 ST.zarticletype,
 ST.description_int,
 ST.zmatkl,
 ST.articlefamily,
 ST.buyerid,
 ST.buyerfirstname,
 ST.buyerlastname,
 ST.buyershortsign,
 xteks_basicinfo_reccountry0.casesize,
 xteks_basicinfo_reccountry0.decimalcasesize,
 xteks_basicinfo_reccountry0.listingoverviewid,
 ITD.casedepth,
 ITD.casewidth,
 ITD.caseheight,
 TR1.description AS lengthunit,
 iwg.casegrossweight,
 TR2.description AS weightunit,
 SUP.intsupplierno AS supplierno,
 SUP.description AS supplierdescription,
 xteks_basicinfo_reccountry0.receivingcountry,
 CONCAT(ITD.casedepth, ITD.casewidth, ITD.caseheight, TR1.description, iwg.casegrossweight, TR2.description) AS conc,
 ITD.contractpricevalidityid
FROM idq_production_eks_calculation.stmara_eks_item AS ST
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry AS xteks_basicinfo_reccountry0 ON ST.itemno =
  xteks_basicinfo_reccountry0.sk_itemno
 LEFT JOIN idq_production_eks.itemdimension AS ITD ON xteks_basicinfo_reccountry0.contractpricevalidityid = ITD.contractpricevalidityid
    AND xteks_basicinfo_reccountry0.sk_itemid = ITD.itemid
 LEFT JOIN idq_production_eks.unit AS UN1 ON ITD.caseunitid = UN1.unitid
 LEFT JOIN idq_production_eks.translation_int_unit AS TR1 ON UN1.shortdescid = TR1.translationid
 LEFT JOIN (SELECT contractpricevalidityid,
   itemid,
   casegrossweight,
   caseunitid
  FROM idq_production_eks.itemweight
  WHERE contractpricevalidityid IS NOT NULL
   AND itemid IS NOT NULL
   AND caseunitid IS NOT NULL) AS iwg ON xteks_basicinfo_reccountry0.contractpricevalidityid = iwg.contractpricevalidityid
    AND ITD.itemid = iwg.itemid
 LEFT JOIN idq_production_eks.unit AS UN2 ON iwg.caseunitid = UN2.unitid
 LEFT JOIN idq_production_eks.translation_int_unit AS TR2 ON UN2.shortdescid = TR2.translationid
 LEFT JOIN idq_production_eks.supplier AS SUP ON xteks_basicinfo_reccountry0.supplierno = SUP.supplierno;