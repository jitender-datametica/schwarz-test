CREATE OR REPLACE PROCEDURE eks_calculation.srwrf_matgrp_sku_eks_item_constructbaskfrommara_ins()
BEGIN
INSERT INTO eks_calculation.stwrf_matgrp_sku_eks_item_2 (itemid, bitflag)
(SELECT itemid, bitflag
    FROM eks.item_2);
INSERT INTO eks_calculation.stwrf_matgrp_sku_eks_item_2 (itemid, bitflag, constructed, constructedfrom)
(SELECT itemid, bitflag, CAST(constructed AS INTEGER) AS constructed, constructedfrom
    FROM eks_calculation.srwrf_matgrp_sku_eks_item_constructbaskfrommara_inssel_2);
END;




