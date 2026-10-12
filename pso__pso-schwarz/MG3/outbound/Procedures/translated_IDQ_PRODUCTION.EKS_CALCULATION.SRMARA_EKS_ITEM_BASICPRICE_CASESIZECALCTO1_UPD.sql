CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_basicprice_casesizecalcto1_upd()
BEGIN
UPDATE idq_production_eks.basicprice SET
    casesizecalc = sr.casesizecalcnew FROM idq_production_eks_calculation.srmara_eks_item_basicprice_casesizecalcto1_updsel AS sr
WHERE basicprice.basicpriceid = sr.basicpriceid;
END;
