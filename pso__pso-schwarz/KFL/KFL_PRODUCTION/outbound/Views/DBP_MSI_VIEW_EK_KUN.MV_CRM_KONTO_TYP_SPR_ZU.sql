CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_konto_typ_spr_zu AS SELECT crm_konto_typ_id,
 MAX(CASE
   WHEN spr_id = 24
   THEN crm_konto_typ_bez
   ELSE NULL
   END) AS crm_konto_typ_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN crm_konto_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN crm_konto_typ_bez
    ELSE NULL
    END)) AS crm_konto_typ_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN crm_konto_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN crm_konto_typ_bez
    ELSE NULL
    END)) AS crm_konto_typ_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN crm_konto_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN crm_konto_typ_bez
    ELSE NULL
    END)) AS crm_konto_typ_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN crm_konto_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN crm_konto_typ_bez
    ELSE NULL
    END)) AS crm_konto_typ_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN crm_konto_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN crm_konto_typ_bez
    ELSE NULL
    END)) AS crm_konto_typ_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN crm_konto_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN crm_konto_typ_bez
    ELSE NULL
    END)) AS crm_konto_typ_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN crm_konto_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN crm_konto_typ_bez
    ELSE NULL
    END)) AS crm_konto_typ_bez_bg
FROM kfl_production_dbp_view.v_crm_l_konto_typ_spr_zu AS V01
GROUP BY crm_konto_typ_id;