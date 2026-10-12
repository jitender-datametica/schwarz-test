CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountryall_inssel_2 AS WITH CTE
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
  FROM idq_production_eks_calculation.stmara_eks_item_2
   INNER JOIN idq_production_eks_calculation.steks_listingoverviewmax_2 ON stmara_eks_item.itemid =
    steks_listingoverviewmax.itemid
   INNER JOIN idq_production_eks.listingitem_2 ON steks_listingoverviewmax.listingoverviewid = listingitem.listingoverviewid
      AND steks_listingoverviewmax.itemid = listingitem.itemid
   INNER JOIN idq_production_eks.basicprice_2 ON listingitem.listingitemid = basicprice.listingitemid AND
     steks_listingoverviewmax.casesize = basicprice.casesizecalc
   INNER JOIN idq_production_eks.contractlink_2 ON steks_listingoverviewmax.listingoverviewid = contractlink.listingoverviewid
    
   INNER JOIN idq_production_eks.contractpricerel_2 ON contractlink.contractlinkid = contractpricerel.contractlinkid AND
     basicprice.basicpriceid = contractpricerel.basicpriceid
   INNER JOIN idq_production_eks.contractpricevalidity_2 ON contractpricerel.contractpricerelid = contractpricevalidity.contractpricerelid
    
   INNER JOIN idq_production_eks.unit_2 ON basicprice.unitid = unit.unitid
   INNER JOIN idq_production_eks_calculation.steks_translation_int_unit_2 ON unit.shortdescid = steks_translation_int_unit_2
    .translationid
   INNER JOIN idq_production_eks.location_2 ON contractlink.locationid = location.locationid AND steks_listingoverviewmax_2
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
     FROM CTE AS t1_2
      INNER JOIN idq_production_eks.itemsorting_2 ON t1.itemid = itemsorting.sortitemid AND t1.zarticletype = 'SK'
      INNER JOIN idq_production_eks.item_2 ON itemsorting.itemid = item.itemid AND item.bitflag = 0
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
     FROM CTE
     WHERE zarticletype = 'EA'));