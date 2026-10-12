CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_union_ins()
BEGIN
INSERT INTO idq_production_eks_calculation.xteks_basicinfo_union (listingoverviewid, casesize, itemid, basicpriceid, contractpricevalidityid, zarticletype, recievingcountry)
(SELECT CAST(listingoverviewid AS INTEGER) AS listingoverviewid, CAST(casesize AS INTEGER) AS casesize, CAST(itemid AS INTEGER) AS itemid, CAST(basicpriceid AS INTEGER) AS basicpriceid, CAST(contractpricevalidityid AS INTEGER) AS contractpricevalidityid, zarticletype, receivingcountry
    FROM idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_union_inssel);
END;
