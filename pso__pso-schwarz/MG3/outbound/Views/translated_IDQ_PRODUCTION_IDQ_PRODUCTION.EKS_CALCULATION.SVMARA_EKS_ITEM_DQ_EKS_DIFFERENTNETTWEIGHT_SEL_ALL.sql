CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_differentnettweight_sel_all (negotiatingcountry
, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, description,
gebinde_anzahl, gebinde_inhalt, gebinde_einheit, gebinde_verpakung, netweight, zusatz_gew_art_int, zusatz_gew_art_nat,
zrelevantmdm, zsource, zactive) AS SELECT DISTINCT znegotiatingcountry AS negotiatingcountry,
 buyershortsign,
 buyerfirstname,
 buyerlastname,
 zmatkl,
 articlefamily,
 itemid,
 itemno,
 zarticletype AS articletype,
 description_int AS description,
 gebinde_anzahl,
 gebinde_inhalt,
 gebinde_einheit,
 gebinde_verpakung,
 netweight,
 zusatz_gew_art_int,
 zusatz_gew_art_nat,
 zrelevantmdm,
 zsource,
 zactive
FROM idq_production_eks_calculation.svmara_eks_item_dq_eks_differentnettweight_010
WHERE (zusatz_gew_art_int IS NOT NULL OR znegotiatingcountry NOT IN ('DE', 'AT', 'CH') AND zusatz_gew_art_nat
    IS NOT NULL)
 AND (gebinde_anzahl <> 1 OR CAST(gebinde_inhalt AS FLOAT64) <> 1 OR LOWER(gebinde_einheit) <> 'kg' OR CAST(IFNULL(netweight, '0') AS FLOAT64)
     <> 1 AND (itemid NOT IN (SELECT itemid
        FROM idq_production_eks_calculation.svmara_eks_item_itemsonlyinexcludelist) OR netweight IS NOT NULL))
 AND (gebinde_anzahl <> 1 OR CAST(gebinde_inhalt AS FLOAT64) <> 1000 OR LOWER(gebinde_einheit) <> 'g' OR CAST(IFNULL(netweight, '0') AS FLOAT64)
     <> 1 AND (itemid NOT IN (SELECT itemid
        FROM idq_production_eks_calculation.svmara_eks_item_itemsonlyinexcludelist AS
         svmara_eks_item_itemsonlyinexcludelist_2) OR netweight IS NOT NULL))
 AND (gebinde_anzahl <> 1 OR CAST(gebinde_inhalt AS FLOAT64) <> 1 OR LOWER(gebinde_einheit) <> 'lb' OR CAST(IFNULL(netweight, '0') AS FLOAT64)
     <> 1 AND (itemid NOT IN (SELECT itemid
        FROM idq_production_eks_calculation.svmara_eks_item_itemsonlyinexcludelist AS
         svmara_eks_item_itemsonlyinexcludelist_1) OR netweight IS NOT NULL));