CREATE OR REPLACE PROCEDURE eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_ea_upd()
BEGIN
UPDATE eks_calculation.stwrf_matgrp_sku_eks_item SET
    zlegacynode = SR.zlegacynodenew FROM eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_ea_updsel AS SR
WHERE stwrf_matgrp_sku_eks_item.itemid = SR.itemid;
END;




