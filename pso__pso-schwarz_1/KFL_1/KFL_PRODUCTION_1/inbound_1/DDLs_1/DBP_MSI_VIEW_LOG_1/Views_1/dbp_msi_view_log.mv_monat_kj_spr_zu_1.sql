CREATE OR REPLACE VIEW dbp_msi_view_log.mv_monat_kj_spr_zu_1
-- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1

AS
SELECT
v01.kjmo,
v01.kj,
v01.mo_kj,
Max(CASE
WHEN v02.spr_id =  22 THEN Trim(v02.mo_bez) || ' ' || Trim(v01.kj)
ELSE NULL END) AS kjmo_bez      --standard=deutsch
,
Max(CASE
WHEN v02.spr_id =  22 THEN Trim(v02.mo_bez) || ' ' || Trim(v01.kj)
ELSE NULL END) AS kjmo_bez_de   --deutsch
,
Max(CASE
WHEN v02.spr_id = 124 THEN Trim(v02.mo_bez) || ' ' || Trim(v01.kj)
ELSE NULL END) AS kjmo_bez_cz   --tschechisch
,
Max(CASE
WHEN v02.spr_id =  90 THEN Trim(v02.mo_bez) || ' ' || Trim(v01.kj)
ELSE NULL END) AS kjmo_bez_pl   --polnisch
,
Max(CASE
WHEN v02.spr_id = 108 THEN Trim(v02.mo_bez) || ' ' || Trim(v01.kj)
ELSE NULL END) AS kjmo_bez_sk   --slowakisch
,
Max(CASE
WHEN v02.spr_id =  65 THEN Trim(v02.mo_bez) || ' ' || Trim(v01.kj)
ELSE NULL END) AS kjmo_bez_hr   --kroatisch
,
Max(CASE
WHEN v02.spr_id =  95 THEN Trim(v02.mo_bez) || ' ' || Trim(v01.kj)
ELSE NULL END) AS kjmo_bez_ro   --rumänisch
,
Max(CASE
WHEN v02.spr_id =  18 THEN Trim(v02.mo_bez) || ' ' || Trim(v01.kj)
ELSE NULL END) AS kjmo_bez_bg   --bulgarisch 

FROM dbp_view.v_monat_1 v01

INNER JOIN dbp_view.v_monat_spr_zu_1 v02
ON v01.mo_kj = v02.mo_id

GROUP BY
v01.kjmo
, v01.kj
, v01.mo_kj;