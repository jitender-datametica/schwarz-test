CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_xteks_basicinfo_union_ins()
BEGIN
INSERT INTO eks_calculation.xteks_basicinfo_union (listingoverviewid, casesize, itemid, basicpriceid, contractpricevalidityid, zarticletype, recievingcountry)
(SELECT *
    FROM eks_calculation.srmara_eks_item_xteks_basicinfo_union_inssel);
END;




