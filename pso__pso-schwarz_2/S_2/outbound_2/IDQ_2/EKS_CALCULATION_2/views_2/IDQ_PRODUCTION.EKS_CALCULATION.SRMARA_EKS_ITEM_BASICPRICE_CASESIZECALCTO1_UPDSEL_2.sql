CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_basicprice_casesizecalcto1_updsel_2 (basicpriceid,
casesizecalc, casesizecalcnew) AS SELECT basicpriceid,
 casesizecalc,
 1 AS casesizecalcnew
FROM idq_production_eks.basicprice_2
WHERE casesizecalc = 0;