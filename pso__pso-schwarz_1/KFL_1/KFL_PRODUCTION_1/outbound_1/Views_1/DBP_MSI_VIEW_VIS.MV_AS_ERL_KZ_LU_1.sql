CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_as_erl_kz_lu_1 (as_erl_kz, as_erl_kz_bez, as_erl_kz_bez_cz,
as_erl_kz_bez_sk, as_erl_kz_bez_hr, as_erl_kz_bez_pl, as_erl_kz_bez_ro, as_erl_kz_bez_bg, as_erl_kz_bez_de) AS SELECT
 erl_kz AS as_erl_kz,
 MAX(CASE
   WHEN spr_id = 22
   THEN erl_kz_bez
   ELSE NULL
   END) AS as_erl_kz_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN erl_kz_bez
   ELSE NULL
   END) AS as_erl_kz_bez_cz,
 MAX(CASE
   WHEN spr_id = 108
   THEN erl_kz_bez
   ELSE NULL
   END) AS as_erl_kz_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN erl_kz_bez
   ELSE NULL
   END) AS as_erl_kz_bez_hr,
 MAX(CASE
   WHEN spr_id = 90
   THEN erl_kz_bez
   ELSE NULL
   END) AS as_erl_kz_bez_pl,
 MAX(CASE
   WHEN spr_id = 95
   THEN erl_kz_bez
   ELSE NULL
   END) AS as_erl_kz_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN erl_kz_bez
   ELSE NULL
   END) AS as_erl_kz_bez_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN erl_kz_bez
   ELSE NULL
   END) AS as_erl_kz_bez_de
FROM kfl_production_dbp_view.v_erl_kz_spr_zu_1
GROUP BY erl_kz;