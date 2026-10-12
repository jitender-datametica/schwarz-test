CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_bereich_spr_zu (ber_id, ber_bez, ber_bez_de, ber_bez_cz,
ber_bez_sk, ber_bez_hr, ber_bez_pl, ber_bez_ro, ber_bez_bg, mandant_id, arthiertyp_id) AS SELECT V01.wg_hierarchie_id AS
 ber_id,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END), 'N/A') AS ber_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END), 'N/A') AS ber_bez_de,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.wg_hierarchie_bez
     ELSE NULL
     END), 'N/A')) AS ber_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.wg_hierarchie_bez
     ELSE NULL
     END), 'N/A')) AS ber_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.wg_hierarchie_bez
     ELSE NULL
     END), 'N/A')) AS ber_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.wg_hierarchie_bez
     ELSE NULL
     END), 'N/A')) AS ber_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.wg_hierarchie_bez
     ELSE NULL
     END), 'N/A')) AS ber_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.wg_hierarchie_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.wg_hierarchie_bez
     ELSE NULL
     END), 'N/A')) AS ber_bez_bg,
 V01.mandant_id,
 V01.arthiertyp_id
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per AS V01
 INNER JOIN kfl_production_dbp_view.v_wg_hierarchie_spr_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wg_hierarchie_ebene_id
      = V02.wg_hierarchie_ebene_id AND V01.wg_hierarchie_id = V02.wg_hierarchie_id AND V01.arthiertyp_id = V02.arthiertyp_id
   
WHERE V01.arthiertyp_id = 10
 AND V01.wg_hierarchie_ebene_id = 1
 AND CURRENT_DATE BETWEEN V01.dat_von AND V01.dat_bis
GROUP BY ber_id,
 V01.mandant_id,
 V01.arthiertyp_id;