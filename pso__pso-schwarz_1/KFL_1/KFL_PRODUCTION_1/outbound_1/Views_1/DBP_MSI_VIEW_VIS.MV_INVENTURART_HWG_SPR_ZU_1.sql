CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_inventurart_hwg_spr_zu_1 AS SELECT IAS.inventurart_int_id * 100
  + CAST(WGH.wg_hierarchie_id AS BIGNUMERIC) AS inventur_hwg_id,
 MAX(CAST(CASE
    WHEN IAS.spr_id = 22
    THEN CASE
     WHEN WGH.wg_hierarchie_id IN (1, 2, 3, 4) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'Ultra-Frische'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (1, 2, 3, 6, 7)
     THEN 'Food Frische'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (4, 5)
     THEN 'Food Frische' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Food' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (7)
     THEN 'Food' || ' ' || 'WG Inventur_1'
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Nonfood' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (7)
     THEN 'Nonfood' || ' ' || 'WG Inventur_1'
     WHEN WGH.wg_hierarchie_id IN (16) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'Nebengeschäft'
     WHEN IAS.inventurart_int_id IN (8)
     THEN 'Historie GJ'
     ELSE 'Interne Inventur_1'
     END
    ELSE NULL
    END AS STRING)) AS inventurart_hwg_bez,
 MAX(CAST(CASE
    WHEN IAS.spr_id = 124
    THEN CASE
     WHEN WGH.wg_hierarchie_id IN (1, 2, 3, 4) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'Ultra-Frische'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (1, 2, 3, 6, 7)
     THEN 'Food Frische'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (4, 5)
     THEN 'Food Frische' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Food' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (7)
     THEN 'Food' || ' ' || 'WG inventura'
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Nonfood' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (7)
     THEN 'Nonfood' || ' ' || 'WG inventura'
     WHEN WGH.wg_hierarchie_id IN (16) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'filiálka'
     WHEN IAS.inventurart_int_id IN (8)
     THEN 'Historie GJ'
     ELSE 'interně inventura'
     END
    ELSE NULL
    END AS STRING)) AS inventurart_hwg_bez_cz,
 MAX(CAST(CASE
    WHEN IAS.spr_id = 108
    THEN CASE
     WHEN WGH.wg_hierarchie_id IN (1, 2, 3, 4) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'Ultra-Frische'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (1, 2, 3, 6, 7)
     THEN 'Food Frische'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (4, 5)
     THEN 'Food Frische' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Food' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (7)
     THEN 'Food' || ' ' || 'WG inventúra_1'
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Nonfood' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (7)
     THEN 'Nonfood' || ' ' || 'WG inventúra_1'
     WHEN WGH.wg_hierarchie_id IN (16) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'Prídavny predaj'
     WHEN IAS.inventurart_int_id IN (8)
     THEN 'Historie GJ'
     ELSE 'Interne inventúra_1'
     END
    ELSE NULL
    END AS STRING)) AS inventurart_hwg_bez_sk,
 MAX(CAST(CASE
    WHEN IAS.spr_id = 65
    THEN CASE
     WHEN WGH.wg_hierarchie_id IN (1, 2, 3, 4) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'Ultra-Frische'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (1, 2, 3, 6, 7)
     THEN 'Food Frische'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (4, 5)
     THEN 'Food Frische' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Food' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (7)
     THEN 'Food' || ' ' || 'WG inventura'
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Nonfood' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (7)
     THEN 'Nonfood' || ' ' || 'WG inventura'
     WHEN WGH.wg_hierarchie_id IN (16) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'Nebengeschäft'
     WHEN IAS.inventurart_int_id IN (8)
     THEN 'Historie GJ'
     ELSE 'Interno inventura'
     END
    ELSE NULL
    END AS STRING)) AS inventurart_hwg_bez_hr,
 MAX(CAST(CASE
    WHEN IAS.spr_id = 90
    THEN CASE
     WHEN WGH.wg_hierarchie_id IN (1, 2, 3, 4) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'Ultra-Świeże'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (1, 2, 3, 6, 7)
     THEN 'Food Świeże'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (4, 5)
     THEN 'Food Świeże' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Food' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (7)
     THEN 'Food' || ' ' || 'inwentaryz. GT'
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Nonfood' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (7)
     THEN 'Nonfood' || ' ' || 'inwentaryz. GT'
     WHEN WGH.wg_hierarchie_id IN (16) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'Działalność dodatkowa'
     WHEN IAS.inventurart_int_id IN (8)
     THEN 'Historie GJ'
     ELSE 'inwentaryz. wewnętrznie'
     END
    ELSE NULL
    END AS STRING)) AS inventurart_hwg_bez_pl,
 MAX(CAST(CASE
    WHEN IAS.spr_id = 95
    THEN CASE
     WHEN WGH.wg_hierarchie_id IN (1, 2, 3, 4) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'Ultra-Proaspete'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (1, 2, 3, 6, 7)
     THEN 'Food proaspete'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (4, 5)
     THEN 'Food proaspete' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Food' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (7)
     THEN 'Food' || ' ' || 'inventar GM'
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Nonfood' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (7)
     THEN 'Nonfood' || ' ' || 'inventar GM'
     WHEN WGH.wg_hierarchie_id IN (16) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'Altele'
     WHEN IAS.inventurart_int_id IN (8)
     THEN 'Historie GJ'
     ELSE 'inventar intern'
     END
    ELSE NULL
    END AS STRING)) AS inventurart_hwg_bez_ro,
 MAX(CAST(CASE
    WHEN IAS.spr_id = 18
    THEN CASE
     WHEN WGH.wg_hierarchie_id IN (1, 2, 3, 4) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'Ултра свежи'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (1, 2, 3, 6, 7)
     THEN 'Свежи храни'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (4, 5)
     THEN 'Свежи храни' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Храни' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (7)
     THEN 'Храни' || ' ' || 'ПГ Инвент.'
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Нехрани' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (7)
     THEN 'Нехрани' || ' ' || 'ПГ Инвент.'
     WHEN WGH.wg_hierarchie_id IN (16) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'Допълнит. дейности'
     WHEN IAS.inventurart_int_id IN (8)
     THEN 'Historie GJ'
     ELSE 'Вътрешна инвент.'
     END
    ELSE NULL
    END AS STRING)) AS inventurart_hwg_bez_bg,
 MAX(CAST(CASE
    WHEN IAS.spr_id = 22
    THEN CASE
     WHEN WGH.wg_hierarchie_id IN (1, 2, 3, 4) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'Ultra-Frische'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (1, 2, 3, 6, 7)
     THEN 'Food Frische'
     WHEN WGH.wg_hierarchie_id IN (5, 6, 17) AND IAS.inventurart_int_id IN (4, 5)
     THEN 'Food Frische' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Food' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (7, 8, 9, 10, 11) AND IAS.inventurart_int_id IN (7)
     THEN 'Food' || ' ' || 'WG Inventur_1'
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6)
     THEN 'Nonfood' || ' ' || IAS.inventurart_int_bez
     WHEN WGH.wg_hierarchie_id IN (12, 13, 14, 15) AND IAS.inventurart_int_id IN (7)
     THEN 'Nonfood' || ' ' || 'WG Inventur_1'
     WHEN WGH.wg_hierarchie_id IN (16) AND IAS.inventurart_int_id IN (1, 2, 3, 4, 5, 6, 7)
     THEN 'Nebengeschäft'
     WHEN IAS.inventurart_int_id IN (8)
     THEN 'Historie GJ'
     ELSE 'Interne Inventur_1'
     END
    ELSE NULL
    END AS STRING)) AS inventurart_hwg_bez_de
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per_1 AS WGH
 INNER JOIN kfl_production_dbp_view.v_inventurart_int_spr_zu_1 AS IAS ON TRUE
WHERE WGH.arthiertyp_id = 5
 AND WGH.wg_hierarchie_ebene_id = 3
 AND WGH.dat_bis = DATE '9999-12-31'
GROUP BY inventur_hwg_id;