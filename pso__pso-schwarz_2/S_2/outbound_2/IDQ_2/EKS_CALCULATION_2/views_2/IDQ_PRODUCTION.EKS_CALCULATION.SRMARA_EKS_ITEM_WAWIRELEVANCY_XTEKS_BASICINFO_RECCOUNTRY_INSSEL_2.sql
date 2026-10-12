CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_inssel_2 (listingoverviewid
, casesize, itemid, itemno, sk_itemid, sk_itemno, sk_description_int, basicpriceunit, receivingcountry, supplierno,
basicpriceid, contractpricerelid, contractlinkid, locationid, contractpricevalidityid, decimalcasesize, zisvalidcontract
, ziswawirelevant) AS SELECT srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.listingoverviewid,
 srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.casesize,
 srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.itemid,
 MAX(srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.itemno) AS itemno,
 MAX(srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.sk_itemid) AS sk_itemid,
 MAX(srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.sk_itemno) AS sk_itemno,
 MAX(srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.sk_description_int) AS sk_description_int,
 MAX(srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.basicpriceunit) AS basicpriceunit,
 srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.receivingcountry,
 MAX(srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.supplierno) AS supplierno,
 MAX(srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.basicpriceid) AS basicpriceid,
 MAX(srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.contractpricerelid) AS contractpricerelid,
 MAX(srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.contractlinkid) AS contractlinkid,
 MAX(srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.locationid) AS locationid,
 MAX(srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.contractpricevalidityid) AS contractpricevalidityid,
 MAX(srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.decimalcasesize) AS decimalcasesize,
 1 AS zisvalidcontract,
 1 AS ziswawirelevant
FROM idq_production_eks_calculation.srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010_2
 LEFT JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_2 ON
             srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.listingoverviewid = xteks_basicinfo_reccountry_2
             .listingoverviewid AND srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.casesize =
             xteks_basicinfo_reccountry.casesize AND srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.itemid
             = xteks_basicinfo_reccountry.itemid AND srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.sk_itemid
            = xteks_basicinfo_reccountry.sk_itemid AND srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.contractpricevalidityid
           = xteks_basicinfo_reccountry.itemid AND srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.receivingcountry
          = xteks_basicinfo_reccountry.receivingcountry AND srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010_2
        .supplierno = xteks_basicinfo_reccountry.supplierno AND
       srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.basicpriceid = xteks_basicinfo_reccountry.basicpriceid
        AND srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.contractpricerelid = xteks_basicinfo_reccountry_2
      .contractpricerelid AND srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.contractlinkid =
     xteks_basicinfo_reccountry.contractlinkid AND srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.locationid
     = xteks_basicinfo_reccountry.locationid AND srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.contractpricevalidityid
    = xteks_basicinfo_reccountry.contractpricevalidityid
WHERE xteks_basicinfo_reccountry.itemid IS NULL
GROUP BY srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.listingoverviewid,
 srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.casesize,
 srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.itemid,
 srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_010.receivingcountry;