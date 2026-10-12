CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_constructbaskfrommara_ins()
BEGIN
INSERT INTO idq_production_eks_calculation.stwrf_matgrp_sku_eks_item_2 (itemid, bitflag)
(SELECT itemid, bitflag
    FROM idq_production_eks.item_2);
INSERT INTO idq_production_eks_calculation.stwrf_matgrp_sku_eks_item_2 (itemid, bitflag, constructed, constructedfrom)
(SELECT itemid, bitflag, CAST(constructed AS NUMERIC) AS constructed, constructedfrom
    FROM idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_constructbaskfrommara_inssel_2);
END;
