DELETE FROM DBP_DATA.woche_2;

INSERT INTO DBP_DATA.woche_2
(
gjwo
, gjwo_vj
, kjwo
, kjwo_vj
, kjwo_vvj
, wo_dat_von
, wo_dat_bis
, akt_wo
, akt_wo_komplett
, akt_wo_kalendarisch
)

SELECT
gjwo
, gjwo_vj
, kjwo
, kjwo_vj
, kjwo_vvj
, wo_dat_von
, wo_dat_bis
, akt_wo
, akt_wo_komplett
--,(wo_dat_von-(DATE-((DATE-CAST('1990-01-01' AS DATE)) MOD 7)))/7 AS akt_wo_kalendarisch
--mfialkiewicz
,datediff(week,wo_dat_von,current_date)*-1 as akt_wo_kalendarisch
FROM DBP_DATA.tag_2
GROUP BY 1,2,3,4,5,6,7,8,9,10
;
COMMIT;
