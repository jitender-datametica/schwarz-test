CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hwg_spr_zu_1 AS SELECT V01.mandant_id,
 V01.wg_hierarchie_id AS hwg_id,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN V02.wg_hierarchie_bez
   ELSE NULL
   END) AS hwg_bez,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN V02.wg_hierarchie_bez
   ELSE NULL
   END) AS hwg_bez_de,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END)) AS hwg_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END)) AS hwg_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END)) AS hwg_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END)) AS hwg_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END)) AS hwg_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END)) AS hwg_bez_bg
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wg_hierarchie_spr_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wg_hierarchie_ebene_id
      = V02.wg_hierarchie_ebene_id AND V01.wg_hierarchie_id = V02.wg_hierarchie_id AND V01.arthiertyp_id = V02.arthiertyp_id
   
WHERE V01.arthiertyp_id = 5
 AND V01.wg_hierarchie_ebene_id = 3
 AND V01.dat_bis = DATE '9999-12-31'
GROUP BY V01.mandant_id,
 hwg_id;