CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_gtin_missingsel (negotiatingcountry,
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
 v.intsupplierno AS supplierno,
 v.description AS supplierdescription,
 eks.listingoverviewid,
 eks.receivingcountry,
 tr_val.description AS zusatz,
 contractpricevalidity.datefrom AS itemvalidfrom,
 contractpricevalidity.dateuntil AS itemvaliduntil,
 eks.ziswawirelevant AS zrelevantmdm,
  CASE
  WHEN loc.shortsign = 'INTEGER'
  THEN 'NT'
  ELSE loc.shortsign
  END AS suppliercountry,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM idq_production_eks_calculation.stmara_eks_item
 LEFT JOIN idq_production_eks.itemean ON stmara_eks_item.itemid = itemean.itemid
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry AS eks ON stmara_eks_item.itemid = eks.itemid
 INNER JOIN idq_production_eks.contractpricevalidity ON eks.contractpricevalidityid = contractpricevalidity.contractpricevalidityid
  
 LEFT JOIN idq_production_eks.validity AS val ON contractpricevalidity.validityid = val.validityid
 LEFT JOIN idq_production_eks.translation_int AS tr_val ON val.descriptionid = tr_val.translationid
 LEFT JOIN idq_production_eks.supplier AS v ON eks.supplierno = v.supplierno
 LEFT JOIN idq_production_eks.supplier_loc_use AS su ON v.supplierno = su.supplierno AND su.cr_loc_flag = 1
 LEFT JOIN idq_production_eks.location AS loc ON su.locationid = loc.locationid
WHERE stmara_eks_item.zactive = 1
 AND (itemean.ean IS NULL AND stmara_eks_item.zarticletype = 'EA' AND stmara_eks_item.constructed IS NULL AND
           stmara_eks_item.ziscurrentcontract = 1 AND stmara_eks_item.zmeins <> 'KG' AND stmara_eks_item.zmeins <> 'LB'
       AND CAST(stmara_eks_item.zmatkl AS FLOAT64) <> 74 AND stmara_eks_item.znegotiatingcountry <> 'NT' OR itemean.ean
            IS NULL AND stmara_eks_item.zarticletype = 'EA' AND stmara_eks_item.constructed IS NULL AND stmara_eks_item
           .zmeins <> 'KG' AND stmara_eks_item.zmeins <> 'LB' AND stmara_eks_item.zmatkl <> '74' AND stmara_eks_item.znegotiatingcountry
         <> 'NT' AND stmara_eks_item.ziscurrentcontractfromsk = 1 OR itemean.ean IS NULL AND stmara_eks_item.zarticletype
            = 'EA' AND stmara_eks_item.constructed IS NULL AND stmara_eks_item.ziscurrentcontract = 1 AND
        stmara_eks_item.zmeins <> 'KG' AND stmara_eks_item.zmeins <> 'LB' AND stmara_eks_item.znegotiatingcountry = 'NT'
       OR itemean.ean IS NULL AND stmara_eks_item.zarticletype = 'EA' AND stmara_eks_item.constructed IS NULL AND
        stmara_eks_item.zmeins <> 'KG' AND stmara_eks_item.zmeins <> 'LB' AND stmara_eks_item.znegotiatingcountry = 'NT'
       AND stmara_eks_item.ziscurrentcontractfromsk = 1)
 AND stmara_eks_item.itemno IN (SELECT itemno
   FROM idq_production_eks_calculation.xteks_basicinfo_reccountry
   WHERE receivingcountry <> 'KO')
 AND stmara_eks_item.znegotiatingcountry = loc.shortsign
 AND stmara_eks_item.itemid NOT IN (SELECT itemid
   FROM idq_production_eks.itemplu);