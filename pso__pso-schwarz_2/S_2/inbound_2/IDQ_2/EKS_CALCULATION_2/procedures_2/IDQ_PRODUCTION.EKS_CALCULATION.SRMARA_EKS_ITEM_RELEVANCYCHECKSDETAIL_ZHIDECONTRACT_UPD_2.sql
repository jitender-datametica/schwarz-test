CREATE OR REPLACE PROCEDURE "SRMARA_EKS_ITEM_RELEVANCYCHECKSDETAIL_ZHIDECONTRACT_UPD"()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS CALLER
AS '
BEGIN
Update EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail_2 as rcd
SET  zHideContract = sr.zHideContractNew
FROM EKS_CALCULATION.srMARA_EKS_ITEM_RelevancyChecksDetail_zHideContract_UpdSel_2 AS sr
WHERE rcd.uid = sr.uid
and rcd.itemid = sr.itemid
and rcd.itemno = sr.itemno;
END;
';