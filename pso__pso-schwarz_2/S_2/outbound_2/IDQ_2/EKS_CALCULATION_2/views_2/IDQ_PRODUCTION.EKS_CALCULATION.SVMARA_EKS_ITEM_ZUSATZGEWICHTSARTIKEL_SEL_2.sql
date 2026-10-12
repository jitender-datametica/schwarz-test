CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_zusatzgewichtsartikel_sel_2 (negotiatingcountry,
buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, sk_itemno, sk_description_int, itemid, itemno,
articletype, description, bundlefact, volume, unitdescription, packagepackaging, text_int, text_nat, basicpriceunit,
listingoverviewid, supplierno, supplierdescription, receivingcountry, zrelevantmdm, zsource, zactive) AS SELECT DISTINCT
 stmara_eks_item.znegotiatingcountry AS negotiatingcountry,
 stmara_eks_item.buyershortsign,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 svmara_eks_item_zusatzgewichtsartikel010.sk_itemno,
 svmara_eks_item_zusatzgewichtsartikel010.sk_description_int,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype AS articletype,
 stmara_eks_item.description_int AS description,
 itemdetail.bundlefact,
 itemdetail.volume,
 ITDTR.description AS unitdescription,
 TR1.description AS packagepackaging,
 itemdetail.text_int,
 itemdetail.text_nat,
 svmara_eks_item_zusatzgewichtsartikel010.basicpriceunit,
 svmara_eks_item_zusatzgewichtsartikel010.listingoverviewid,
 supplier.intsupplierno AS supplierno,
 supplier.description AS supplierdescription,
 svmara_eks_item_zusatzgewichtsartikel010.receivingcountry,
 svmara_eks_item_zusatzgewichtsartikel010.zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM idq_production_eks_calculation.svmara_eks_item_zusatzgewichtsartikel010_2
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 ON svmara_eks_item_zusatzgewichtsartikel010.itemid =
  stmara_eks_item.itemid
 LEFT JOIN idq_production_eks.itemdetail_2 ON svmara_eks_item_zusatzgewichtsartikel010.itemid = itemdetail.itemid
 LEFT JOIN idq_production_eks.unit_2 AS ITDUNIT ON itemdetail.unitid = ITDUNIT.unitid
 LEFT JOIN idq_production_eks.translation_int_2 AS ITDTR ON ITDUNIT.shortdescid = ITDTR.translationid
 LEFT JOIN idq_production_eks.supplier_2 ON svmara_eks_item_zusatzgewichtsartikel010.supplierno = supplier.supplierno
 LEFT JOIN idq_production_eks.package_2 ON itemdetail.packageid = package.packageid
 LEFT JOIN idq_production_eks.translation_int_2 AS TR1 ON package.shortdescid = TR1.translationid
WHERE (stmara_eks_item.zactive = 1 OR stmara_eks_item.ziscurrentcontract = 1 OR stmara_eks_item.ziscurrentcontractfromsk
     = 1)
 AND ((UPPER(svmara_eks_item_zusatzgewichtsartikel010.basicpriceunit) = 'KG' OR UPPER(svmara_eks_item_zusatzgewichtsartikel010_2
          .basicpriceunit) = 'LB') AND (itemdetail.text_int IS NULL AND itemdetail.text_nat IS NULL OR itemdetail.text_int
         IS NULL AND stmara_eks_item.znegotiatingcountry IN ('CH', 'DE', 'AT')) OR UPPER(svmara_eks_item_zusatzgewichtsartikel010_2
        .basicpriceunit) = 'STK.' AND (itemdetail.text_int IS NOT NULL OR itemdetail.text_nat IS NOT NULL AND
          stmara_eks_item.znegotiatingcountry NOT IN ('CH', 'DE', 'AT')) OR UPPER(svmara_eks_item_zusatzgewichtsartikel010_2
        .basicpriceunit) = 'STK.' AND itemdetail.text_int IS NOT NULL AND stmara_eks_item.znegotiatingcountry IN ('CH',
       'DE', 'AT') OR UPPER(svmara_eks_item_zusatzgewichtsartikel010.basicpriceunit) NOT IN ('STK.', 'LB', 'KG'));