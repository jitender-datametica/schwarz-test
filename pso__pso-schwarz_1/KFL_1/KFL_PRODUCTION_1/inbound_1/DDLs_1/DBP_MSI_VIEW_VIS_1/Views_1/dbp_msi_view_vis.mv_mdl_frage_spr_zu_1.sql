CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_mdl_frage_spr_zu_1
-- 27.11.2020 AP0077403, SPEC0092798, Pawel Staniszewski, Creation of the View 
(
 frage_id
,frage_bez
,frage_bez_cz
,frage_bez_pl
,frage_bez_sk
,frage_bez_hr
,frage_bez_ro
,frage_bez_bg
)
AS
SELECT

frage_id,
MAX(CASE
WHEN spr_id =   22 THEN frage_bez
ELSE NULL END)  AS frage_bez   --standard=deutsch
,
MAX(CASE
WHEN spr_id = 124 THEN frage_bez
ELSE NULL END)  AS frage_bez_cz,
MAX(CASE
WHEN spr_id =   90 THEN frage_bez
ELSE NULL END)  AS frage_bez_pl,
MAX(CASE
WHEN spr_id = 108 THEN frage_bez
ELSE NULL END)  AS frage_bez_sk,
MAX(CASE
WHEN spr_id =   65 THEN frage_bez
ELSE NULL END)  AS frage_bez_hr,
MAX(CASE
WHEN spr_id =   95 THEN frage_bez
ELSE NULL END)  AS frage_bez_ro,
MAX(CASE
WHEN spr_id =   18 THEN frage_bez
ELSE NULL END)  AS frage_bez_bg
FROM dbp_view.v_mdl_frage_spr_zu_1 v01

GROUP BY frage_id;