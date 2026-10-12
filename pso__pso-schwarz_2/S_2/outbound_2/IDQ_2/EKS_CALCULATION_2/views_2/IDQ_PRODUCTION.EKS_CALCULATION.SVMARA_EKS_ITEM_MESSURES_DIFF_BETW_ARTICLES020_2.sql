CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_messures_diff_betw_articles020_2 (listingoverviewid
, casesize, ba_itemno, volume, avgvolume, percentagevolume) AS SELECT DISTINCT listingoverviewid,
 subcasesize AS casesize,
 ba_itemno,
 volume,
 ROUND((SUM(volume) OVER (PARTITION BY listingoverviewid, ba_itemno, subcasesize RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING)) / NULLIF(COUNT(1) OVER (PARTITION BY listingoverviewid, ba_itemno, subcasesize RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0), 6) AS avgvolume,
 CAST(ROUND(volume * 100 / NULLIF(ROUND(CASE
        WHEN (SUM(volume) OVER (PARTITION BY listingoverviewid, ba_itemno, subcasesize RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
        THEN 1
        ELSE SUM(volume) OVER (PARTITION BY listingoverviewid, ba_itemno, subcasesize RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        END / NULLIF(COUNT(1) OVER (PARTITION BY listingoverviewid, ba_itemno, subcasesize RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0), 6), 0), 6) AS NUMERIC)
 AS percentagevolume
FROM idq_production_eks_calculation.svmara_eks_item_messures_diff_betw_articles010_2
WHERE ba_itemno IS NOT NULL;