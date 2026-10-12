CREATE OR REPLACE PROCEDURE eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_bask_upd()
BEGIN
UPDATE eks_calculation.stwrf_matgrp_sku_eks_item SET
    zlegacynode = SR.zlegacynodenew FROM eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_bask_updsel AS SR
WHERE stwrf_matgrp_sku_eks_item.itemid = SR.itemid;
END;




