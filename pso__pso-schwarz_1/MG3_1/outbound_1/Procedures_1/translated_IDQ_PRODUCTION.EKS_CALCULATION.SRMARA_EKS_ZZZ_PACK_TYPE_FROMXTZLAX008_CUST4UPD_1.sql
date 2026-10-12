CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_zzz_pack_type_fromxtzlax008_cust4upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_1 SET
    zzz_pack_type = sr.zzz_pack_typenew FROM idq_production_eks_calculation.srmara_eks_zzz_pack_type_fromxtzlax008_cust4updsel_1 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
