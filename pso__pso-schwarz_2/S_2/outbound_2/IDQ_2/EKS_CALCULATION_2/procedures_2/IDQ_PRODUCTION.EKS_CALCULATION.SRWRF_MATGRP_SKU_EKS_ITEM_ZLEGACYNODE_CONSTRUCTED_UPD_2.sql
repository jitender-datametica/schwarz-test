CREATE OR REPLACE PROCEDURE eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_constructed_upd()
BEGIN
UPDATE eks_calculation.stwrf_matgrp_sku_eks_item_2 SET
    zlegacynode = SR.zlegacynodenew FROM eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_constructed_updsel_2 AS SR
WHERE stwrf_matgrp_sku_eks_item.itemid = SR.itemid;
END;




