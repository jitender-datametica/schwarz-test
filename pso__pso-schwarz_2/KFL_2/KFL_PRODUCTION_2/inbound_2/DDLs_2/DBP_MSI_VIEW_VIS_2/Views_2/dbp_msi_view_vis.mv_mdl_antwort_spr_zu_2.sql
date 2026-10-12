CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_mdl_antwort_spr_zu_2
-- 26.11.2020 AP0077403, SPEC0092798, Pawel Staniszewski, Creation of the View 

(
 frage_id
,antwort_id
,antwort_bez
,antwort_bez_cz
,antwort_bez_pl
,antwort_bez_sk
,antwort_bez_hr
,antwort_bez_ro
,antwort_bez_bg
)
AS
SELECT
frage_id,
antwort_id,
MAX(CASE
WHEN spr_id =   22 THEN antwort_bez
ELSE NULL END)  AS antwort_bez   --standard=deutsch
,
MAX(CASE
WHEN spr_id = 124 THEN antwort_bez
ELSE NULL END)  AS antwort_bez_cz,
MAX(CASE
WHEN spr_id =   90 THEN antwort_bez
ELSE NULL END)  AS antwort_bez_pl,
MAX(CASE
WHEN spr_id = 108 THEN antwort_bez
ELSE NULL END)  AS antwort_bez_sk,
MAX(CASE
WHEN spr_id =   65 THEN antwort_bez
ELSE NULL END)  AS antwort_bez_hr,
MAX(CASE
WHEN spr_id =   95 THEN antwort_bez
ELSE NULL END)  AS antwort_bez_ro,
MAX(CASE
WHEN spr_id =   18 THEN antwort_bez
ELSE NULL END)  AS antwort_bez_bg
FROM dbp_view.v_mdl_antwort_spr_zu_2

GROUP BY antwort_id, frage_id;