CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_gtin_missingsel_1 (negotiatingcountry,
buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description,
supplierno, supplierdescription, listingoverviewid, receivingcountry, zusatz, itemvalidfrom, itemvaliduntil,
zrelevantmdm, suppliercountry, zsource, zactive) AS SELECT DISTINCT stmara_eks_item.znegotiatingcountry AS
 negotiatingcountry,
 stmara_eks_item.buyershortsign,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype AS articletype,
 stmara_eks_item.description_int AS description,
 V.intsupplierno AS supplierno,
 V.description AS supplierdescription,
 EKS.listingoverviewid,
 EKS.receivingcountry,
 TR_VAL.description AS zusatz,
 contractpricevalidity.datefrom AS itemvalidfrom,
 contractpricevalidity.dateuntil AS itemvaliduntil,
 EKS.ziswawirelevant AS zrelevantmdm,
  CASE
  WHEN LOC.shortsign = 'INTEGER'
  THEN 'NT'
  ELSE LOC.shortsign
  END AS suppliercountry,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM idq_production_eks_calculation.stmara_eks_item_1
 LEFT JOIN idq_production_eks.itemean_1 ON stmara_eks_item.itemid = itemean.itemid
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_1 AS EKS ON stmara_eks_item.itemid = EKS.itemid
 INNER JOIN idq_production_eks.contractpricevalidity_1 ON EKS.contractpricevalidityid = contractpricevalidity.contractpricevalidityid
  
 LEFT JOIN idq_production_eks.validity_1 AS VAL ON contractpricevalidity.validityid = VAL.validityid
 LEFT JOIN idq_production_eks.translation_int_1 AS TR_VAL ON VAL.descriptionid = TR_VAL.translationid
 LEFT JOIN idq_production_eks.supplier_1 AS V ON EKS.supplierno = V.supplierno
 LEFT JOIN idq_production_eks.supplier_loc_use_1 AS SU ON V.supplierno = SU.supplierno AND SU.cr_loc_flag = 1
 LEFT JOIN idq_production_eks.location_1 AS LOC ON SU.locationid = LOC.locationid
WHERE stmara_eks_item.zactive = 1
 AND (itemean.ean_1 IS NULL AND stmara_eks_item.zarticletype = 'EA' AND stmara_eks_item.constructed IS NULL AND
           stmara_eks_item.ziscurrentcontract = 1 AND stmara_eks_item.zmeins <> 'KG' AND stmara_eks_item.zmeins <> 'LB'
       AND CAST(stmara_eks_item.zmatkl AS FLOAT64) <> 74 AND stmara_eks_item.znegotiatingcountry <> 'NT' OR itemean.ean_1
            IS NULL AND stmara_eks_item.zarticletype = 'EA' AND stmara_eks_item.constructed IS NULL AND stmara_eks_item_1
           .zmeins <> 'KG' AND stmara_eks_item.zmeins <> 'LB' AND stmara_eks_item.zmatkl <> '74' AND stmara_eks_item.znegotiatingcountry
         <> 'NT' AND stmara_eks_item.ziscurrentcontractfromsk = 1 OR itemean.ean_1 IS NULL AND stmara_eks_item.zarticletype
            = 'EA' AND stmara_eks_item.constructed IS NULL AND stmara_eks_item.ziscurrentcontract = 1 AND
        stmara_eks_item.zmeins <> 'KG' AND stmara_eks_item.zmeins <> 'LB' AND stmara_eks_item.znegotiatingcountry = 'NT'
       OR itemean.ean_1 IS NULL AND stmara_eks_item.zarticletype = 'EA' AND stmara_eks_item.constructed IS NULL AND
        stmara_eks_item.zmeins <> 'KG' AND stmara_eks_item.zmeins <> 'LB' AND stmara_eks_item.znegotiatingcountry = 'NT'
       AND stmara_eks_item.ziscurrentcontractfromsk = 1)
 AND stmara_eks_item.itemno IN (SELECT itemno
   FROM idq_production_eks_calculation.xteks_basicinfo_reccountry_1
   WHERE receivingcountry <> 'KO')
 AND stmara_eks_item.znegotiatingcountry = LOC.shortsign
 AND stmara_eks_item.itemid NOT IN (SELECT itemid
   FROM idq_production_eks.itemplu_1);