CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010_2 AS
WITH CTE AS (SELECT DISTINCT steks_listingoverviewmax.listingoverviewid,
   steks_listingoverviewmax.casesize,
   STMARA_WAWI_ZRELEVANTMDM.itemid,
   steks_translation_int_unit.description AS basicpriceunit,
   steks_listingoverviewmax.receivingcountry,
   steks_listingoverviewmax.supplierno,
   basicprice.basicpriceid,
   STMARA_WAWI_ZRELEVANTMDM.zarticletype,
   contractpricerel.contractpricerelid,
   contractpricerel.contractlinkid,
   CONTRACTLINK.locationid,
   contractpricevalidity.contractpricevalidityid,
    ROUND(CAST(basicprice.subcases AS NUMERIC), 2) * ROUND(CAST(basicprice.subcasesize AS NUMERIC), 2) AS
   decimalcasesize,
   STMARA_WAWI_ZRELEVANTMDM.zactive
  FROM idq_production_eks_calculation.steks_listingoverviewmax_2
   INNER JOIN idq_production_eks.listingitem_2 ON steks_listingoverviewmax.listingoverviewid = listingitem.listingoverviewid
      AND steks_listingoverviewmax.itemid = listingitem.itemid
   INNER JOIN idq_production_eks.basicprice_2 ON listingitem.listingitemid = basicprice.listingitemid AND
     steks_listingoverviewmax.casesize = basicprice.casesizecalc
   INNER JOIN idq_production_eks.contractlink_2 AS CONTRACTLINK_2 ON steks_listingoverviewmax.listingoverviewid =
    CONTRACTLINK.listingoverviewid
   INNER JOIN idq_production_eks.contractpricerel_2 ON CONTRACTLINK.contractlinkid = contractpricerel.contractlinkid AND
     basicprice.basicpriceid = contractpricerel.basicpriceid
   INNER JOIN idq_production_eks.contractpricevalidity_2 ON contractpricerel.contractpricerelid = contractpricevalidity.contractpricerelid
    
   INNER JOIN idq_production_eks.unit_2 ON basicprice.unitid = unit.unitid
   INNER JOIN idq_production_eks_calculation.steks_translation_int_unit_2 ON unit.shortdescid = steks_translation_int_unit_2
    .translationid
   INNER JOIN idq_production_eks.location_2 ON CONTRACTLINK.locationid = location.locationid AND steks_listingoverviewmax_2
     .receivingcountry = location.shortsign
   INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS STMARA_WAWI_ZRELEVANTMDM ON STMARA_WAWI_ZRELEVANTMDM.zrelevantmdm
       = 1 AND steks_listingoverviewmax.itemid = STMARA_WAWI_ZRELEVANTMDM.itemid AND steks_listingoverviewmax.receivingcountry
      = STMARA_WAWI_ZRELEVANTMDM.znegotiatingcountry
   INNER JOIN idq_production_eks_calculation.wawi_mdm_relevant_articles_2 ON steks_listingoverviewmax.casesize = CAST(RIGHT(wawi_mdm_relevant_articles.wawi_artikelnr, 4) AS FLOAT64)
       AND CAST(wawi_mdm_relevant_articles.eks_supplier_no AS FLOAT64) = steks_listingoverviewmax.supplierno AND
     STMARA_WAWI_ZRELEVANTMDM.itemno = CAST(wawi_mdm_relevant_articles.eks_artikel_nr AS FLOAT64)) (SELECT *
  FROM (SELECT t1.listingoverviewid,
      t1.casesize,
      item.itemid,
      item.itemno,
      t1.itemid AS sk_itemid,
      stmara_eks_item.itemno AS sk_itemno,
      stmara_eks_item.description_int AS sk_description_int,
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
      INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 ON t1.itemid = stmara_eks_item.itemid
      INNER JOIN idq_production_eks.itemsorting_2 ON t1.itemid = itemsorting.sortitemid AND t1.zarticletype = 'SK'
      INNER JOIN idq_production_eks.item_2 ON itemsorting.itemid = item.itemid AND item.bitflag = 0
     UNION ALL
     SELECT t5.listingoverviewid,
      t5.casesize,
      t5.itemid,
      stmara_eks_item0.itemno,
      CAST(NULL AS BIGNUMERIC) AS sk_itemid,
      CAST(NULL AS BIGNUMERIC) AS sk_itemno,
      CAST(NULL AS STRING) AS sk_description_int,
      t5.basicpriceunit,
      t5.receivingcountry,
      t5.supplierno,
      t5.basicpriceid,
      t5.contractpricerelid,
      t5.contractlinkid,
      t5.locationid,
      t5.contractpricevalidityid,
      t5.decimalcasesize
     FROM CTE AS t5
      INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS stmara_eks_item0 ON t5.itemid = stmara_eks_item0.itemid
       
     WHERE t5.zarticletype = 'EA'));