create or replace view DBP_MSI_VIEW_EK_SORT.JAVA_PRODUKTBEZEICHNUNG(
	MANDANT_ID,
	A500,
	MATCHING_ID,
	A12,
	A12_DE,
	A12_CZ,
	A12_SK,
	A12_HR,
	A12_PL,
	A12_RO,
	A12_BG
) as
SELECT
t1.mandant_id,
t1.kjwo_update AS A500,
t1.matching_id,
CASE WHEN spr_id =  22  THEN Coalesce(t1.tupel_bez, t2.nielsen_art_bez) END AS A12,
CASE WHEN spr_id =  22  THEN Coalesce(t1.tupel_bez, t2.nielsen_art_bez) END AS A12_de,
CASE WHEN spr_id =  124  THEN Coalesce(t1.tupel_bez, t2.nielsen_art_bez) END AS A12_cz,
CASE WHEN spr_id =  108  THEN Coalesce(t1.tupel_bez, t2.nielsen_art_bez) END AS A12_sk,
CASE WHEN spr_id =  65  THEN Coalesce(t1.tupel_bez, t2.nielsen_art_bez) END AS A12_hr,
CASE WHEN spr_id =  90  THEN Coalesce(t1.tupel_bez, t2.nielsen_art_bez) END AS A12_pl,
CASE WHEN spr_id =  95  THEN Coalesce(t1.tupel_bez, t2.nielsen_art_bez) END AS A12_ro,
CASE WHEN spr_id =  18  THEN Coalesce(t1.tupel_bez, t2.nielsen_art_bez) END AS A12_bg
FROM dbp_view.v_tupel_spr_zu t1
JOIN dbp_view.v_tupel_mat t2
ON t1.mandant_id = t2.mandant_id
AND t1.matching_id = t2.matching_id
AND t1.kjwo_update = t2.a500_kjwo_update;