CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_auftragsart_spr_zu (auftragsart_id, auftragsart_bez,
auftragsart_bez_de, auftragsart_bez_cz, auftragsart_bez_sk, auftragsart_bez_hr, auftragsart_bez_pl, auftragsart_bez_ro,
auftragsart_bez_b) AS SELECT auftragsart_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN auftragsart_bez
   ELSE NULL
   END) AS auftragsart_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN auftragsart_bez
   ELSE NULL
   END) AS auftragsart_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN auftragsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN auftragsart_bez
    ELSE NULL
    END)) AS auftragsart_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN auftragsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN auftragsart_bez
    ELSE NULL
    END)) AS auftragsart_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN auftragsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN auftragsart_bez
    ELSE NULL
    END)) AS auftragsart_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN auftragsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN auftragsart_bez
    ELSE NULL
    END)) AS auftragsart_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN auftragsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN auftragsart_bez
    ELSE NULL
    END)) AS auftragsart_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN auftragsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN auftragsart_bez
    ELSE NULL
    END)) AS auftragsart_bez_b
FROM kfl_production_dbp_view.v_in_auftragsart_spr_zu AS V01
GROUP BY auftragsart_id
UNION DISTINCT
SELECT '-1',
 CAST(NULL AS STRING),
 CAST(NULL AS STRING),
 CAST(NULL AS STRING),
 CAST(NULL AS STRING),
 CAST(NULL AS STRING),
 CAST(NULL AS STRING),
 CAST(NULL AS STRING),
 CAST(NULL AS STRING);