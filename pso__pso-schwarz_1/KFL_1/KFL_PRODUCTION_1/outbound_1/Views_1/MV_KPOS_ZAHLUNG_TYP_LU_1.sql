CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kpos_zahlung_typ_lu_1 (kpos_zahlung_typ_id,
kpos_zahlung_typ_bez_de, kpos_zahlung_typ_bez, kpos_zahlung_typ_bez_cz, kpos_zahlung_typ_bez_sk, kpos_zahlung_typ_bez_hr
, kpos_zahlung_typ_bez_pl, kpos_zahlung_typ_bez_ro, kpos_zahlung_typ_bez_bg) AS SELECT kpos_zahlung_typ_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN kpos_zahlung_typ_bez
   ELSE TRIM(kpos_zahlung_typ_id)
   END) AS kpos_zahlung_typ_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN kpos_zahlung_typ_bez
   ELSE TRIM(kpos_zahlung_typ_id)
   END) AS kpos_zahlung_typ_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN kpos_zahlung_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kpos_zahlung_typ_bez
    ELSE TRIM(kpos_zahlung_typ_id)
    END)) AS kpos_zahlung_typ_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN kpos_zahlung_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kpos_zahlung_typ_bez
    ELSE TRIM(kpos_zahlung_typ_id)
    END)) AS kpos_zahlung_typ_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN kpos_zahlung_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kpos_zahlung_typ_bez
    ELSE TRIM(kpos_zahlung_typ_id)
    END)) AS kpos_zahlung_typ_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN kpos_zahlung_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kpos_zahlung_typ_bez
    ELSE TRIM(kpos_zahlung_typ_id)
    END)) AS kpos_zahlung_typ_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN kpos_zahlung_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kpos_zahlung_typ_bez
    ELSE TRIM(kpos_zahlung_typ_id)
    END)) AS kpos_zahlung_typ_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN kpos_zahlung_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kpos_zahlung_typ_bez
    ELSE TRIM(kpos_zahlung_typ_id)
    END)) AS kpos_zahlung_typ_bez_bg
FROM kfl_production_dbp_v_ods.v_l_kpos_zahlung_typ_spr_zu_1
GROUP BY kpos_zahlung_typ_id;