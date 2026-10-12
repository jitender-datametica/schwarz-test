CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_projekt_typ_1 AS SELECT DISTINCT LRP.rpm_projekt_typ_id,
 LRP.rpm_projekt_typ_id AS rpm_projekt_typ,
 CAST(CASE
   WHEN LRP.rpm_projekt_typ_id IN ('DM', 'FM', 'LM', 'NB_1', 'UB', 'UE', 'XP')
   THEN '1EX'
   WHEN LRP.rpm_projekt_typ_id IN ('MM_1', 'MO', 'RE_1', 'RN', 'ST')
   THEN '2MM_1'
   WHEN LRP.rpm_projekt_typ_id IN ('IG', 'PM_1')
   THEN '3IG'
   WHEN LRP.rpm_projekt_typ_id IN ('BM', 'SM_1', 'WM_1')
   THEN '4SB'
   WHEN LRP.rpm_projekt_typ_id IN ('GM', 'KM')
   THEN '5KM'
   WHEN LRP.rpm_projekt_typ_id IN ('KO')
   THEN '6KO'
   WHEN LRP.rpm_projekt_typ_id IN ('DB', 'FB', 'FK', 'LB', 'LK', 'LO', 'NF', 'NV', 'NW', 'RF', 'RL', 'RS_1', 'RV', 'SF', 'VK_1', 'WR')
   THEN '7LF'
   ELSE '8SO'
   END AS STRING) AS rpm_projekt_kat,
 MAX(CASE
   WHEN MS.spr_id = 22
   THEN MS.massnahmenart_bez
   ELSE NULL
   END) AS rpm_projekt_typ_bez,
 COALESCE(MAX(CASE
    WHEN MS.spr_id = 124
    THEN MS.massnahmenart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN MS.spr_id = 22
    THEN MS.massnahmenart_bez
    ELSE NULL
    END)) AS rpm_projekt_typ_bez_cz,
 COALESCE(MAX(CASE
    WHEN MS.spr_id = 108
    THEN MS.massnahmenart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN MS.spr_id = 22
    THEN MS.massnahmenart_bez
    ELSE NULL
    END)) AS rpm_projekt_typ_bez_sk,
 COALESCE(MAX(CASE
    WHEN MS.spr_id = 65
    THEN MS.massnahmenart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN MS.spr_id = 22
    THEN MS.massnahmenart_bez
    ELSE NULL
    END)) AS rpm_projekt_typ_bez_hr,
 COALESCE(MAX(CASE
    WHEN MS.spr_id = 90
    THEN MS.massnahmenart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN MS.spr_id = 22
    THEN MS.massnahmenart_bez
    ELSE NULL
    END)) AS rpm_projekt_typ_bez_pl,
 COALESCE(MAX(CASE
    WHEN MS.spr_id = 95
    THEN MS.massnahmenart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN MS.spr_id = 22
    THEN MS.massnahmenart_bez
    ELSE NULL
    END)) AS rpm_projekt_typ_bez_ro,
 COALESCE(MAX(CASE
    WHEN MS.spr_id = 24
    THEN MS.massnahmenart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN MS.spr_id = 22
    THEN MS.massnahmenart_bez
    ELSE NULL
    END)) AS rpm_projekt_typ_bez_en,
 COALESCE(MAX(CASE
    WHEN MS.spr_id = 18
    THEN MS.massnahmenart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN MS.spr_id = 22
    THEN MS.massnahmenart_bez
    ELSE NULL
    END)) AS rpm_projekt_typ_bez_bg
FROM kfl_production_dbp_view.v_l_rpm_phase_1 AS LRP
 INNER JOIN kfl_production_dbp_view.v_l_massnahme_1 AS LM ON LRP.rpm_projekt_typ_id = LM.massnahme_id
 INNER JOIN kfl_production_dbp_view.v_massnahmenart_spr_zu_1 AS MS ON LM.massnahmenart_id = MS.massnahmenart_id
WHERE LENGTH(TRIM(LRP.rpm_projekt_typ_id)) BETWEEN 2 AND 3
GROUP BY LRP.rpm_projekt_typ_id,
 rpm_projekt_typ,
 rpm_projekt_kat;