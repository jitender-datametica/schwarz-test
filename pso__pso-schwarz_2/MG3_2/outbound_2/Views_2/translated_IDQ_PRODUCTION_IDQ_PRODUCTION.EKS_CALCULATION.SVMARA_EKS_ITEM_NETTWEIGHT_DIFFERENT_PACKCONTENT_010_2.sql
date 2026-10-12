CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_nettweight_different_packcontent_010_2 (znegotiatingcountry
, itemid, itemno, zarticletype, zitem_ba, bitflag, description_int, netweight, zzz_pack_cont_uom, zzz_quant_pack_cont,
zzz_pack_content, zzz_pack_content_conv, packagepackaging) AS SELECT stmara_eks_item.znegotiatingcountry,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype,
 stmara_eks_item.zitem_ba,
 stmara_eks_item.bitflag,
 stmara_eks_item.description_int,
 itemdetail.netweight,
 stmara_eks_item.zzz_pack_cont_uom,
 stmara_eks_item.zzz_quant_pack_cont,
 stmara_eks_item.zzz_pack_content,
 ROUND(CAST(CASE
    WHEN stmara_eks_item.zzz_pack_cont_uom = 'KG'
    THEN stmara_eks_item.zzz_quant_pack_cont * stmara_eks_item.zzz_pack_content * 1000
    ELSE stmara_eks_item.zzz_quant_pack_cont * stmara_eks_item.zzz_pack_content
    END AS BIGNUMERIC), 0) AS zzz_pack_content_conv,
 tr1.description AS packagepackaging
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks.itemdetail_2 ON stmara_eks_item.itemid = itemdetail.itemid
 LEFT JOIN idq_production_eks.package_2 AS pkg ON itemdetail.packageid = pkg.packageid
 LEFT JOIN idq_production_eks.translation_int_2 AS tr1 ON pkg.shortdescid = tr1.translationid
WHERE stmara_eks_item.constructed IS NULL
GROUP BY stmara_eks_item.znegotiatingcountry,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype,
 stmara_eks_item.description_int,
 itemdetail.netweight,
 stmara_eks_item.bitflag,
 stmara_eks_item.zzz_pack_cont_uom,
 stmara_eks_item.zitem_ba,
 stmara_eks_item.itemid,
 stmara_eks_item.zzz_pack_content,
 stmara_eks_item.zzz_quant_pack_cont,
 packagepackaging
HAVING stmara_eks_item.zarticletype = 'EA' AND stmara_eks_item.zzz_pack_cont_uom = 'G' OR stmara_eks_item.zarticletype =
    'EA' AND stmara_eks_item.zzz_pack_cont_uom = 'KG' OR stmara_eks_item.zarticletype = 'EA' AND stmara_eks_item.zzz_pack_cont_uom
    = 'LB';