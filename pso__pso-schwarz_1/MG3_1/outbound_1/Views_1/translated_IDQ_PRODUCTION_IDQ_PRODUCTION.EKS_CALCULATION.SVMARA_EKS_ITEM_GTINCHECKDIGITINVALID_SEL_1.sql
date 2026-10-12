CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_gtincheckdigitinvalid_sel_1 (negotiatingcountry,
buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description, ean_1,
supplierno, supplierdescription, zrelevantmdm, zsource, zactive) AS SELECT DISTINCT stmara_eks_item.znegotiatingcountry
 AS negotiatingcountry,
 stmara_eks_item.buyershortsign,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype AS articletype,
 stmara_eks_item.description_int AS description,
 itemean.ean_1,
 supplier.intsupplierno AS supplierno,
 supplier.description AS supplierdescription,
 stmara_eks_item.zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM idq_production_eks_calculation.stmara_eks_item_1
 INNER JOIN idq_production_eks.itemean_1 ON stmara_eks_item.itemid = itemean.itemid AND CURRENT_DATE BETWEEN CAST(itemean.datefrom AS DATE)
   AND (CAST(itemean.dateuntil AS DATE))
 INNER JOIN idq_production_eks.itemean_supplier_1 ON itemean.itemeanid = itemean_supplier.itemeanid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS ba ON stmara_eks_item.zitem_ba = ba.itemid
 INNER JOIN idq_production_eks.itemdetail_1 ON stmara_eks_item.itemid = itemdetail.itemid
 LEFT JOIN idq_production_eks.supplier_1 ON itemean_supplier.supplierno = supplier.supplierno
WHERE stmara_eks_item.zactive = 1
 AND itemdetail.text_int IS NULL
 AND itemdetail.text_nat IS NULL
 AND RIGHT(IFNULL(itemean.zean_converted, 'X'), 1) <> IFNULL(idq_production_eks_calculation.standardcheckdigit1(LPAD(itemean.zean_converted
     , 18, '0')), 'XX');