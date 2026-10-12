CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ruecksendung_typ_lu_1 (mandant_id, ruecksendung_typ_kz,
ruecksendung_typ_bez_de, ruecksendung_typ_bez, ruecksendung_typ_bez_cz, ruecksendung_typ_bez_sk, ruecksendung_typ_bez_hr
, ruecksendung_typ_bez_pl, ruecksendung_typ_bez_ro, ruecksendung_typ_bez_bg) AS SELECT RT.mandant_id,
 RT.ruecksendung_typ_kz,
 MAX(CASE
   WHEN RTS.spr_id = 22
   THEN RTS.ruecksendung_typ_bez
   ELSE TRIM(RTS.ruecksendung_typ_kz)
   END) AS ruecksendung_typ_bez_de,
 MAX(CASE
   WHEN RTS.spr_id = 22
   THEN RTS.ruecksendung_typ_bez
   ELSE TRIM(RTS.ruecksendung_typ_kz)
   END) AS ruecksendung_typ_bez,
 COALESCE(MAX(CASE
    WHEN RTS.spr_id = 124
    THEN RTS.ruecksendung_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RTS.spr_id = 22
    THEN RTS.ruecksendung_typ_bez
    ELSE TRIM(RTS.ruecksendung_typ_kz)
    END)) AS ruecksendung_typ_bez_cz,
 COALESCE(MAX(CASE
    WHEN RTS.spr_id = 108
    THEN RTS.ruecksendung_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RTS.spr_id = 22
    THEN RTS.ruecksendung_typ_bez
    ELSE TRIM(RTS.ruecksendung_typ_kz)
    END)) AS ruecksendung_typ_bez_sk,
 COALESCE(MAX(CASE
    WHEN RTS.spr_id = 65
    THEN RTS.ruecksendung_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RTS.spr_id = 22
    THEN RTS.ruecksendung_typ_bez
    ELSE TRIM(RTS.ruecksendung_typ_kz)
    END)) AS ruecksendung_typ_bez_hr,
 COALESCE(MAX(CASE
    WHEN RTS.spr_id = 90
    THEN RTS.ruecksendung_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RTS.spr_id = 22
    THEN RTS.ruecksendung_typ_bez
    ELSE TRIM(RTS.ruecksendung_typ_kz)
    END)) AS ruecksendung_typ_bez_pl,
 COALESCE(MAX(CASE
    WHEN RTS.spr_id = 95
    THEN RTS.ruecksendung_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RTS.spr_id = 22
    THEN RTS.ruecksendung_typ_bez
    ELSE TRIM(RTS.ruecksendung_typ_kz)
    END)) AS ruecksendung_typ_bez_ro,
 COALESCE(MAX(CASE
    WHEN RTS.spr_id = 18
    THEN RTS.ruecksendung_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RTS.spr_id = 22
    THEN RTS.ruecksendung_typ_bez
    ELSE TRIM(RTS.ruecksendung_typ_kz)
    END)) AS ruecksendung_typ_bez_bg
FROM kfl_production_dbp_view.v_l_ruecksendung_typ_1 AS RT
 INNER JOIN kfl_production_dbp_view.v_ruecksendung_typ_spr_zu_1 AS RTS ON RT.mandant_id = RTS.mandant_id AND RT.ruecksendung_typ_kz
    = RTS.ruecksendung_typ_kz
GROUP BY RT.mandant_id,
 RT.ruecksendung_typ_kz;