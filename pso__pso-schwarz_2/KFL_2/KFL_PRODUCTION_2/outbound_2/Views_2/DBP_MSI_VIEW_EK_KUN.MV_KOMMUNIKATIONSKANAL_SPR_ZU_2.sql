CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_kommunikationskanal_spr_zu_2 (mandant_id,
kommunikationskanal_id, kommunikationskanal_bez_en, kommunikationskanal_bez, kommunikationskanal_bez_cz,
kommunikationskanal_bez_sk, kommunikationskanal_bez_hr, kommunikationskanal_bez_pl, kommunikationskanal_bez_ro,
kommunikationskanal_bez_bg) AS SELECT mandant_id,
 kommunikationskanal_id,
 MAX(CASE
   WHEN spr_id = 24
   THEN kommunikationskanal_bez
   ELSE NULL
   END) AS kommunikationskanal_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN kommunikationskanal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN kommunikationskanal_bez
    ELSE NULL
    END)) AS kommunikationskanal_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN kommunikationskanal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN kommunikationskanal_bez
    ELSE NULL
    END)) AS kommunikationskanal_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN kommunikationskanal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN kommunikationskanal_bez
    ELSE NULL
    END)) AS kommunikationskanal_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN kommunikationskanal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN kommunikationskanal_bez
    ELSE NULL
    END)) AS kommunikationskanal_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN kommunikationskanal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN kommunikationskanal_bez
    ELSE NULL
    END)) AS kommunikationskanal_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN kommunikationskanal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN kommunikationskanal_bez
    ELSE NULL
    END)) AS kommunikationskanal_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN kommunikationskanal_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN kommunikationskanal_bez
    ELSE NULL
    END)) AS kommunikationskanal_bez_bg
FROM kfl_production_dbp_view.v_kommunikationskanal_spr_zu_2
GROUP BY mandant_id,
 kommunikationskanal_id;