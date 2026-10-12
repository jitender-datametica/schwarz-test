CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_zzz_pack_type_fromxtzlax008_cust4upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_1 SET
    zzz_pack_type = SR.zzz_pack_typenew FROM eks_calculation.srmara_eks_zzz_pack_type_fromxtzlax008_cust4updsel_1 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




