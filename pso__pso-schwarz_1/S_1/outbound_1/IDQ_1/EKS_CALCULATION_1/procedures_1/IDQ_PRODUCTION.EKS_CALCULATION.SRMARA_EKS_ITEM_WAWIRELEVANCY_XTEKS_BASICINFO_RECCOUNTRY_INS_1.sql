CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_ins()
BEGIN
INSERT INTO eks_calculation.xteks_basicinfo_reccountry_1 (listingoverviewid, casesize, itemid, itemno, sk_itemid, sk_itemno, sk_description_int, basicpriceunit, receivingcountry, supplierno, basicpriceid, contractpricerelid, contractlinkid, locationid, contractpricevalidityid, decimalcasesize, zisvalidcontract, ziswawirelevant)
(SELECT listingoverviewid, CAST(casesize AS INTEGER) AS casesize, itemid, itemno, sk_itemid, sk_itemno, sk_description_int, basicpriceunit, receivingcountry, supplierno, basicpriceid, contractpricerelid, contractlinkid, locationid, contractpricevalidityid, decimalcasesize, zisvalidcontract, ziswawirelevant
    FROM eks_calculation.srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_inssel_1);
END;

