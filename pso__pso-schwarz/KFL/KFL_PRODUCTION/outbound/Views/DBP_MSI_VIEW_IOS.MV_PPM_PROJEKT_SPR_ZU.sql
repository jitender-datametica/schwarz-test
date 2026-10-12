CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_ppm_projekt_spr_zu AS SELECT V02.mandant_id,
 V01.in_budget_typ_id,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.in_budget_typ_bez
   ELSE NULL
   END) AS in_budget_typ_bez,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.in_budget_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.in_budget_typ_bez
    ELSE NULL
    END)) AS in_budget_typ_bez_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.in_budget_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.in_budget_typ_bez
    ELSE NULL
    END)) AS in_budget_typ_bez_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.in_budget_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.in_budget_typ_bez
    ELSE NULL
    END)) AS in_budget_typ_bez_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.in_budget_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.in_budget_typ_bez
    ELSE NULL
    END)) AS in_budget_typ_bez_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.in_budget_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.in_budget_typ_bez
    ELSE NULL
    END)) AS in_budget_typ_bez_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 24
    THEN V01.in_budget_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.in_budget_typ_bez
    ELSE NULL
    END)) AS in_budget_typ_bez_en,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.in_budget_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.in_budget_typ_bez
    ELSE NULL
    END)) AS in_budget_typ_bez_bg
FROM kfl_production_dbp_view.v_in_budget_typ_spr_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant AS V02 ON TRUE
GROUP BY V02.mandant_id,
 V01.in_budget_typ_id;