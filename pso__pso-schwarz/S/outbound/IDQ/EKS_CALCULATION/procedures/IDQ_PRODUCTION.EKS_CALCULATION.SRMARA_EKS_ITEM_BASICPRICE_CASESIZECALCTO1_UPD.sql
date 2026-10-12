CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_basicprice_casesizecalcto1_upd()
BEGIN
UPDATE eks.basicprice SET
    casesizecalc = SR.casesizecalcnew FROM eks_calculation.srmara_eks_item_basicprice_casesizecalcto1_updsel AS SR
WHERE basicprice.basicpriceid = SR.basicpriceid;
END;




