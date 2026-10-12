CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010_1 AS
WITH cte AS (SELECT DISTINCT steks_listingoverviewmax.listingoverviewid,
   steks_listingoverviewmax.casesize,
   stmara_wawi_zrelevantmdm.itemid,
   steks_translation_int_unit.description AS basicpriceunit,
   steks_listingoverviewmax.receivingcountry,
   steks_listingoverviewmax.supplierno,
   basicprice.basicpriceid,
   stmara_wawi_zrelevantmdm.zarticletype,
   contractpricerel.contractpricerelid,
   contractpricerel.contractlinkid,
   contractlink.locationid,
   contractpricevalidity.contractpricevalidityid,
   SAFE_CAST(ROUND(CAST(basicprice.subcases AS NUMERIC), 2) * ROUND(CAST(basicprice.subcasesize AS NUMERIC), 2) AS
    NUMERIC) AS decimalcasesize,
   stmara_wawi_zrelevantmdm.zactive
  FROM idq_production_eks_calculation.steks_listingoverviewmax_1
   INNER JOIN idq_production_eks.listingitem_1 ON steks_listingoverviewmax.listingoverviewid = listingitem.listingoverviewid
      AND steks_listingoverviewmax.itemid = listingitem.itemid
   INNER JOIN idq_production_eks.basicprice_1 ON listingitem.listingitemid = basicprice.listingitemid AND
     steks_listingoverviewmax.casesize = basicprice.casesizecalc
   INNER JOIN idq_production_eks.contractlink_1 AS contractlink_1 ON steks_listingoverviewmax.listingoverviewid =
    contractlink.listingoverviewid
   INNER JOIN idq_production_eks.contractpricerel_1 ON contractlink.contractlinkid = contractpricerel.contractlinkid AND
     basicprice.basicpriceid = contractpricerel.basicpriceid
   INNER JOIN idq_production_eks.contractpricevalidity_1 ON contractpricerel.contractpricerelid = contractpricevalidity.contractpricerelid
    
   INNER JOIN idq_production_eks.unit_1 ON basicprice.unitid = unit.unitid
   INNER JOIN idq_production_eks_calculation.steks_translation_int_unit_1 ON unit.shortdescid = steks_translation_int_unit_1
    .translationid
   INNER JOIN idq_production_eks.location_1 ON contractlink.locationid = location.locationid AND steks_listingoverviewmax_1
     .receivingcountry = location.shortsign
   INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS stmara_wawi_zrelevantmdm ON stmara_wawi_zrelevantmdm.zrelevantmdm
       = 1 AND steks_listingoverviewmax.itemid = stmara_wawi_zrelevantmdm.itemid AND steks_listingoverviewmax.receivingcountry
      = stmara_wawi_zrelevantmdm.znegotiatingcountry
   INNER JOIN idq_production_eks_calculation.wawi_mdm_relevant_articles_1 ON steks_listingoverviewmax.casesize = CAST(RIGHT(wawi_mdm_relevant_articles.wawi_artikelnr, 4) AS FLOAT64)
       AND CAST(wawi_mdm_relevant_articles.eks_supplier_no AS FLOAT64) = steks_listingoverviewmax.supplierno AND
     stmara_wawi_zrelevantmdm.itemno = CAST(wawi_mdm_relevant_articles.eks_artikel_nr AS FLOAT64)) (SELECT *
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
     FROM cte AS t1_1
      INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 ON t1.itemid = stmara_eks_item.itemid
      INNER JOIN idq_production_eks.itemsorting_1 ON t1.itemid = itemsorting.sortitemid AND t1.zarticletype = 'SK'
      INNER JOIN idq_production_eks.item_1 ON itemsorting.itemid = item.itemid AND item.bitflag = 0
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
     FROM cte AS t5
      INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS stmara_eks_item0 ON t5.itemid = stmara_eks_item0.itemid
       
     WHERE t5.zarticletype = 'EA'));