CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_zusatzgewichtsartikel010_2 AS WITH cte AS (SELECT
  DISTINCT steks_listingoverviewmax.listingoverviewid,
   stmara_eks_item.itemid,
   stmara_eks_item.itemno,
   stmara_eks_item.description_int AS sk_description_int,
   translation_int_unit.description AS basicpriceunit,
   steks_listingoverviewmax.receivingcountry,
   steks_listingoverviewmax.supplierno,
   basicprice.basicpriceid,
   stmara_eks_item.zarticletype,
   xteks_basicinfo_reccountry.ziswawirelevant
  FROM idq_production_eks_calculation.stmara_eks_item_2
   INNER JOIN idq_production_eks_calculation.steks_listingoverviewmax_2 ON stmara_eks_item.itemid =
     steks_listingoverviewmax.itemid AND stmara_eks_item.ziscurrentcontract = 1
   INNER JOIN idq_production_eks.basicprice_2 ON steks_listingoverviewmax.casesize = basicprice.casesizecalc
   INNER JOIN idq_production_eks.unit_2 ON basicprice.unitid = unit.unitid
   INNER JOIN idq_production_eks.translation_int_unit_2 ON unit.shortdescid = translation_int_unit.translationid
   INNER JOIN idq_production_eks_calculation.xteks_basicinfo_union_2 ON steks_listingoverviewmax.listingoverviewid =
        xteks_basicinfo_union.listingoverviewid AND steks_listingoverviewmax.casesize = xteks_basicinfo_union.casesize
      AND steks_listingoverviewmax.itemid = xteks_basicinfo_union.itemid AND steks_listingoverviewmax.receivingcountry =
      xteks_basicinfo_union.recievingcountry AND basicprice.basicpriceid = xteks_basicinfo_union.basicpriceid
   INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_2 ON xteks_basicinfo_union.listingoverviewid =
         xteks_basicinfo_reccountry.listingoverviewid AND xteks_basicinfo_union.casesize = xteks_basicinfo_reccountry.casesize
          AND steks_listingoverviewmax.supplierno = xteks_basicinfo_reccountry.supplierno AND xteks_basicinfo_union.recievingcountry
        = xteks_basicinfo_reccountry.receivingcountry AND (xteks_basicinfo_union.itemid = xteks_basicinfo_reccountry.itemid
          AND xteks_basicinfo_union.zarticletype = 'EA' OR xteks_basicinfo_union.zarticletype = 'SK' AND
        xteks_basicinfo_reccountry.sk_itemid IS NOT NULL) AND xteks_basicinfo_union.basicpriceid =
     xteks_basicinfo_reccountry.basicpriceid
  WHERE steks_listingoverviewmax.zactive = 1) (SELECT *
  FROM (SELECT t2.listingoverviewid,
      item.itemid,
      item.itemno,
      t2.itemid AS sk_itemid,
      t2.itemno AS sk_itemno,
      t2.sk_description_int,
      t2.basicpriceunit,
      t2.receivingcountry,
      t2.supplierno,
      t2.basicpriceid,
      t2.ziswawirelevant AS zrelevantmdm
     FROM cte AS t2
      INNER JOIN idq_production_eks.itemsorting_2 ON t2.itemid = itemsorting.sortitemid AND t2.zarticletype = 'SK'
      INNER JOIN idq_production_eks.item_2 ON itemsorting.itemid = item.itemid AND item.bitflag = 0
     UNION DISTINCT
     SELECT listingoverviewid,
      itemid,
      itemno,
      CAST(NULL AS BIGNUMERIC) AS sk_itemid,
      CAST(NULL AS BIGNUMERIC) AS sk_itemno,
      CAST(NULL AS STRING) AS sk_description_int,
      basicpriceunit,
      receivingcountry,
      supplierno,
      basicpriceid,
      ziswawirelevant AS zrelevantmdm
     FROM cte
     WHERE zarticletype = 'EA'));