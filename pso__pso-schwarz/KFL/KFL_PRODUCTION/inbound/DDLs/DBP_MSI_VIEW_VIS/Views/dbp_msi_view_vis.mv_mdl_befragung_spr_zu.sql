CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_mdl_befragung_spr_zu
-- 26.11.2020 AP0077403, SPEC0092798, Pawel Staniszewski, Creation of the View 
(
 befragung_id
,befragung_bez
,befragung_bez_cz
,befragung_bez_pl
,befragung_bez_sk
,befragung_bez_hr
,befragung_bez_ro
,befragung_bez_bg
)
AS
SELECT

befragung_id,
MAX(CASE
WHEN spr_id =   22 THEN befragung_bez
ELSE NULL END)  AS befragung_bez   --standard=deutsch
,
MAX(CASE
WHEN spr_id = 124 THEN befragung_bez
ELSE NULL END)  AS befragung_bez_cz,
MAX(CASE
WHEN spr_id =   90 THEN befragung_bez
ELSE NULL END)  AS befragung_bez_pl,
MAX(CASE
WHEN spr_id = 108 THEN befragung_bez
ELSE NULL END)  AS befragung_bez_sk,
MAX(CASE
WHEN spr_id =   65 THEN befragung_bez
ELSE NULL END)  AS befragung_bez_hr,
MAX(CASE
WHEN spr_id =   95 THEN befragung_bez
ELSE NULL END)  AS befragung_bez_ro,
MAX(CASE
WHEN spr_id =   18 THEN befragung_bez
ELSE NULL END)  AS befragung_bez_bg
FROM dbp_view.v_mdl_befragung_spr_zu v01

GROUP BY befragung_id;