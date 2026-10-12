CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_novalidcontract_del()
BEGIN
DELETE FROM eks_calculation.xteks_basicinfo_reccountry_1
WHERE zisvalidcontract = 0;
END;




