CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_abschriftenart_grp_spr_zu_1 (abschriftart_gruppe_id,
abschriftart_bez, abschriftart_bez_de, abschriftart_bez_cz, abschriftart_bez_sk, abschriftart_bez_hr,
abschriftart_bez_pl, abschriftart_bez_ro, abschriftart_bez_bg, bez, mandant_id) AS SELECT abschriftart_id AS
 abschriftart_gruppe_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_bez
    ELSE NULL
    END), 'N/A') AS abschriftart_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_bez
    ELSE NULL
    END), 'N/A') AS abschriftart_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN abschriftart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN abschriftart_bez
     ELSE NULL
     END), 'N/A')) AS abschriftart_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN abschriftart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN abschriftart_bez
     ELSE NULL
     END), 'N/A')) AS abschriftart_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN abschriftart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN abschriftart_bez
     ELSE NULL
     END), 'N/A')) AS abschriftart_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN abschriftart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN abschriftart_bez
     ELSE NULL
     END), 'N/A')) AS abschriftart_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN abschriftart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN abschriftart_bez
     ELSE NULL
     END), 'N/A')) AS abschriftart_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN abschriftart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN abschriftart_bez
     ELSE NULL
     END), 'N/A')) AS abschriftart_bez_bg,
   TRIM(SUBSTR(CAST(abschriftart_id AS STRING), 1, 39)) || ', ' || TRIM(SUBSTR(CAST(abschriftart_id + 1 AS STRING), 1,
    39)) AS bez,
 mandant_id
FROM kfl_production_dbp_view.v_abschriftart_spr_zu_1 AS V01
WHERE (abschriftart_id <> 955 OR mandant_id <> 2)
 AND abschriftart_id NOT IN (923, 924)
GROUP BY abschriftart_gruppe_id,
 bez,
 mandant_id
UNION ALL
SELECT DISTINCT CASE
  WHEN lager_bewart_id IN ('Y01', 'Y02')
  THEN 210
  WHEN lager_bewart_id IN ('Y07', 'Y08')
  THEN 211
  WHEN lager_bewart_id IN ('Y11', 'Y12')
  THEN 240
  WHEN lager_bewart_id IN ('Y05', 'Y06')
  THEN 241
  WHEN lager_bewart_id IN ('Y35', 'Y36')
  THEN 242
  ELSE NULL
  END,
  CASE
  WHEN lager_bewart_id IN ('Y01', 'Y02')
  THEN 'Y01, Y02 RLZ'
  WHEN lager_bewart_id IN ('Y07', 'Y08')
  THEN 'Y07, Y08 RLZ Spenden'
  WHEN lager_bewart_id IN ('Y11', 'Y12')
  THEN 'Y11, Y12 Bewirtung Zentrale'
  WHEN lager_bewart_id IN ('Y05', 'Y06')
  THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
  WHEN lager_bewart_id IN ('Y35', 'Y36')
  THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
  ELSE NULL
  END AS abschriftart_bez,
  CASE
  WHEN lager_bewart_id IN ('Y01', 'Y02')
  THEN 'Y01, Y02 RLZ'
  WHEN lager_bewart_id IN ('Y07', 'Y08')
  THEN 'Y07, Y08 RLZ Spenden'
  WHEN lager_bewart_id IN ('Y11', 'Y12')
  THEN 'Y11, Y12 Bewirtung Zentrale'
  WHEN lager_bewart_id IN ('Y05', 'Y06')
  THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
  WHEN lager_bewart_id IN ('Y35', 'Y36')
  THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
  ELSE NULL
  END AS abschriftart_bez_de,
  CASE
  WHEN lager_bewart_id IN ('Y01', 'Y02')
  THEN 'Y01, Y02 RLZ'
  WHEN lager_bewart_id IN ('Y07', 'Y08')
  THEN 'Y07, Y08 RLZ Spenden'
  WHEN lager_bewart_id IN ('Y11', 'Y12')
  THEN 'Y11, Y12 Bewirtung Zentrale'
  WHEN lager_bewart_id IN ('Y05', 'Y06')
  THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
  WHEN lager_bewart_id IN ('Y35', 'Y36')
  THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
  ELSE NULL
  END AS abschriftart_bez_cz,
  CASE
  WHEN lager_bewart_id IN ('Y01', 'Y02')
  THEN 'Y01, Y02 RLZ'
  WHEN lager_bewart_id IN ('Y07', 'Y08')
  THEN 'Y07, Y08 RLZ Spenden'
  WHEN lager_bewart_id IN ('Y11', 'Y12')
  THEN 'Y11, Y12 Bewirtung Zentrale'
  WHEN lager_bewart_id IN ('Y05', 'Y06')
  THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
  WHEN lager_bewart_id IN ('Y35', 'Y36')
  THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
  ELSE NULL
  END AS abschriftart_bez_sk,
  CASE
  WHEN lager_bewart_id IN ('Y01', 'Y02')
  THEN 'Y01, Y02 RLZ'
  WHEN lager_bewart_id IN ('Y07', 'Y08')
  THEN 'Y07, Y08 RLZ Spenden'
  WHEN lager_bewart_id IN ('Y11', 'Y12')
  THEN 'Y11, Y12 Bewirtung Zentrale'
  WHEN lager_bewart_id IN ('Y05', 'Y06')
  THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
  WHEN lager_bewart_id IN ('Y35', 'Y36')
  THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
  ELSE NULL
  END AS abschriftart_bez_hr,
  CASE
  WHEN lager_bewart_id IN ('Y01', 'Y02')
  THEN 'Y01, Y02 RLZ'
  WHEN lager_bewart_id IN ('Y07', 'Y08')
  THEN 'Y07, Y08 RLZ Spenden'
  WHEN lager_bewart_id IN ('Y11', 'Y12')
  THEN 'Y11, Y12 Bewirtung Zentrale'
  WHEN lager_bewart_id IN ('Y05', 'Y06')
  THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
  WHEN lager_bewart_id IN ('Y35', 'Y36')
  THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
  ELSE NULL
  END AS abschriftart_bez_pl,
  CASE
  WHEN lager_bewart_id IN ('Y01', 'Y02')
  THEN 'Y01, Y02 RLZ'
  WHEN lager_bewart_id IN ('Y07', 'Y08')
  THEN 'Y07, Y08 RLZ Spenden'
  WHEN lager_bewart_id IN ('Y11', 'Y12')
  THEN 'Y11, Y12 Bewirtung Zentrale'
  WHEN lager_bewart_id IN ('Y05', 'Y06')
  THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
  WHEN lager_bewart_id IN ('Y35', 'Y36')
  THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
  ELSE NULL
  END AS abschriftart_bez_ro,
  CASE
  WHEN lager_bewart_id IN ('Y01', 'Y02')
  THEN 'Y01, Y02 RLZ'
  WHEN lager_bewart_id IN ('Y07', 'Y08')
  THEN 'Y07, Y08 RLZ Spenden'
  WHEN lager_bewart_id IN ('Y11', 'Y12')
  THEN 'Y11, Y12 Bewirtung Zentrale'
  WHEN lager_bewart_id IN ('Y05', 'Y06')
  THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
  WHEN lager_bewart_id IN ('Y35', 'Y36')
  THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
  ELSE NULL
  END AS abschriftart_bez_bg,
  CASE
  WHEN lager_bewart_id IN ('Y01', 'Y02')
  THEN '210'
  WHEN lager_bewart_id IN ('Y07', 'Y08')
  THEN '211'
  WHEN lager_bewart_id IN ('Y11', 'Y12')
  THEN '240'
  WHEN lager_bewart_id IN ('Y05', 'Y06')
  THEN '241'
  WHEN lager_bewart_id IN ('Y35', 'Y36')
  THEN '242'
  ELSE NULL
  END,
 mandant_id
FROM kfl_production_dbp_view.v_l_lager_bewart_1
WHERE lager_bewart_id IN ('Y01', 'Y02', 'Y07', 'Y08', 'Y11', 'Y12', 'Y05', 'Y06', 'Y35', 'Y36');