CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_TAG_SPR_ZU_1
AS
SELECT
tag.dat,
tag.wtag_id,
MAX(CASE WHEN spr_id =  22 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez      --standard=deutsch
,
MAX(CASE WHEN spr_id =  22 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_de   --deutsch
,
MAX(CASE WHEN spr_id = 124 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_cz   --tschechisch
,
MAX(CASE WHEN spr_id =  90 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_pl   --polnisch
,
MAX(CASE WHEN spr_id = 108 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_sk   --slowakisch
,
MAX(CASE WHEN spr_id =  65 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_hr   --kroatisch
,
MAX(CASE WHEN spr_id =  95 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_ro   --rumänisch
,
MAX(CASE WHEN spr_id =  18 THEN spr.wtag_bez ELSE NULL END) AS wtag_bez_bg   --bulgarisch 
,
MAX(CASE WHEN spr_id =  22 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez      --standard=deutsch
,
MAX(CASE WHEN spr_id =  22 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_de   --deutsch
,
MAX(CASE WHEN spr_id = 124 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_cz   --tschechisch
,
MAX(CASE WHEN spr_id =  90 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_pl   --polnisch
,
MAX(CASE WHEN spr_id = 108 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_sk   --slowakisch
,
MAX(CASE WHEN spr_id =  65 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_hr   --kroatisch
,
MAX(CASE WHEN spr_id =  95 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_ro   --rumänisch
,
MAX(CASE WHEN spr_id =  18 THEN TRIM(SUBSTRING(spr.wtag_bez, 1, 2)) ELSE NULL END)::VARCHAR(20) AS wtag_kbez_bg   --bulgarisch 

FROM dbp_view.v_tag_1  tag_1
JOIN dbp_view.v_wtag_spr_zu_1 spr_1
ON tag.wtag_id = spr.wtag_id
WHERE
akt_gj BETWEEN -10 AND 1
GROUP BY
tag.dat
,tag.wtag_id;


