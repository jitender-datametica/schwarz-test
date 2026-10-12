CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_basicprice_casesizecalcto1_upd()
BEGIN
UPDATE eks.basicprice_2 SET
    casesizecalc = SR.casesizecalcnew FROM eks_calculation.srmara_eks_item_basicprice_casesizecalcto1_updsel_2 AS SR
WHERE basicprice.basicpriceid = SR.basicpriceid;
END;




