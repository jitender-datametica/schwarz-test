CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountryall_inssel AS WITH cte
 AS (SELECT DISTINCT steks_listingoverviewmax.listingoverviewid,
   steks_listingoverviewmax.casesize,
   stmara_eks_item.itemid,
   stmara_eks_item.itemno,
   stmara_eks_item.description_int AS sk_description_int,
   steks_translation_int_unit.description AS basicpriceunit,
   steks_listingoverviewmax.receivingcountry,
   steks_listingoverviewmax.supplierno,
   basicprice.basicpriceid,
   stmara_eks_item.zarticletype,
   contractpricerel.contractpricerelid,
   contractpricerel.contractlinkid,
   contractlink.locationid,
   contractpricevalidity.contractpricevalidityid,
   CAST(ROUND(CAST(basicprice.subcases AS NUMERIC), 2) * ROUND(CAST(basicprice.subcasesize AS NUMERIC), 2) AS NUMERIC)
   AS decimalcasesize
  FROM idq_production_eks_calculation.stmara_eks_item
   INNER JOIN idq_production_eks_calculation.steks_listingoverviewmax ON stmara_eks_item.itemid =
    steks_listingoverviewmax.itemid
   INNER JOIN idq_production_eks.listingitem ON steks_listingoverviewmax.listingoverviewid = listingitem.listingoverviewid
      AND steks_listingoverviewmax.itemid = listingitem.itemid
   INNER JOIN idq_production_eks.basicprice ON listingitem.listingitemid = basicprice.listingitemid AND
     steks_listingoverviewmax.casesize = basicprice.casesizecalc
   INNER JOIN idq_production_eks.contractlink ON steks_listingoverviewmax.listingoverviewid = contractlink.listingoverviewid
    
   INNER JOIN idq_production_eks.contractpricerel ON contractlink.contractlinkid = contractpricerel.contractlinkid AND
     basicprice.basicpriceid = contractpricerel.basicpriceid
   INNER JOIN idq_production_eks.contractpricevalidity ON contractpricerel.contractpricerelid = contractpricevalidity.contractpricerelid
    
   INNER JOIN idq_production_eks.unit ON basicprice.unitid = unit.unitid
   INNER JOIN idq_production_eks_calculation.steks_translation_int_unit ON unit.shortdescid = steks_translation_int_unit
    .translationid
   INNER JOIN idq_production_eks.location ON contractlink.locationid = location.locationid AND steks_listingoverviewmax
     .receivingcountry = location.shortsign) (SELECT *
  FROM (SELECT t1.listingoverviewid,
      t1.casesize,
      item.itemid,
      item.itemno,
      t1.itemid AS sk_itemid,
      t1.itemno AS sk_itemno,
      t1.sk_description_int,
      t1.basicpriceunit,
      t1.receivingcountry,
      t1.supplierno,
      t1.basicpriceid,
      t1.contractpricerelid,
      t1.contractlinkid,
      t1.locationid,
      t1.contractpricevalidityid,
      t1.decimalcasesize
     FROM cte AS t1
      INNER JOIN idq_production_eks.itemsorting ON t1.itemid = itemsorting.sortitemid AND t1.zarticletype = 'SK'
      INNER JOIN idq_production_eks.item ON itemsorting.itemid = item.itemid AND item.bitflag = 0
     UNION ALL
     SELECT listingoverviewid,
      casesize,
      itemid,
      itemno,
      CAST(NULL AS BIGNUMERIC) AS sk_itemid,
      CAST(NULL AS BIGNUMERIC) AS sk_itemno,
      CAST(NULL AS STRING) AS sk_description_int,
      basicpriceunit,
      receivingcountry,
      supplierno,
      basicpriceid,
      contractpricerelid,
      contractlinkid,
      locationid,
      contractpricevalidityid,
      decimalcasesize
     FROM cte
     WHERE zarticletype = 'EA'));