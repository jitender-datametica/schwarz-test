CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_KJMO_SPR_ZU
AS
SELECT
v01.kjmo,
v01.kj,
v01.mo_kj,
MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS kjmo_bez      --standard=deutsch
,
MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS kjmo_bez_de   --deutsch
,
MAX(CASE WHEN v02.spr_id = 124 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS kjmo_bez_cz   --tschechisch
,
MAX(CASE WHEN v02.spr_id =  90 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS kjmo_bez_pl   --polnisch
,
MAX(CASE WHEN v02.spr_id = 108 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS kjmo_bez_sk   --slowakisch
,
MAX(CASE WHEN v02.spr_id =  65 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS kjmo_bez_hr   --kroatisch
,
MAX(CASE WHEN v02.spr_id =  95 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS kjmo_bez_ro   --rumänisch
,
MAX(CASE WHEN v02.spr_id =  18 THEN TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj) ELSE NULL END)::VARCHAR(20) AS kjmo_bez_bg   --bulgarisch 

FROM dbp_view.v_monat v01

INNER JOIN dbp_view.v_monat_spr_zu v02
ON v01.mo_kj = v02.mo_id

GROUP BY
v01.kjmo
, v01.kj
, v01.mo_kj;


