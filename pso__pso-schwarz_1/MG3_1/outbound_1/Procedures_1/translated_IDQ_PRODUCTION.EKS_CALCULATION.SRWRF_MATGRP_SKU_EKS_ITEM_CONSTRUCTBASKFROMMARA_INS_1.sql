CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_constructbaskfrommara_ins()
BEGIN
INSERT INTO idq_production_eks_calculation.stwrf_matgrp_sku_eks_item_1 (itemid, bitflag)
(SELECT itemid, bitflag
    FROM idq_production_eks.item_1);
INSERT INTO idq_production_eks_calculation.stwrf_matgrp_sku_eks_item_1 (itemid, bitflag, constructed, constructedfrom)
(SELECT itemid, bitflag, CAST(constructed AS NUMERIC) AS constructed, constructedfrom
    FROM idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_constructbaskfrommara_inssel_1);
END;
