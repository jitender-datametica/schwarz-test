CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_element_spr_zu_2 AS SELECT V02.rpm_element_id,
 V02.dat_von,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN V02.rpm_element_bez
   ELSE NULL
   END) AS rpm_element_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.rpm_element_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_element_bez
    ELSE NULL
    END)) AS rpm_element_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.rpm_element_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_element_bez
    ELSE NULL
    END)) AS rpm_element_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.rpm_element_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_element_bez
    ELSE NULL
    END)) AS rpm_element_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.rpm_element_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_element_bez
    ELSE NULL
    END)) AS rpm_element_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.rpm_element_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_element_bez
    ELSE NULL
    END)) AS rpm_element_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN V02.rpm_element_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_element_bez
    ELSE NULL
    END)) AS rpm_element_bez_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.rpm_element_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_element_bez
    ELSE NULL
    END)) AS rpm_element_bez_bg,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN V02.rpm_element_langtext
   ELSE NULL
   END) AS rpm_element_langtext,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.rpm_element_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_element_langtext
    ELSE NULL
    END)) AS rpm_element_langtext_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.rpm_element_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_element_langtext
    ELSE NULL
    END)) AS rpm_element_langtext_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.rpm_element_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_element_langtext
    ELSE NULL
    END)) AS rpm_element_langtext_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.rpm_element_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_element_langtext
    ELSE NULL
    END)) AS rpm_element_langtext_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.rpm_element_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_element_langtext
    ELSE NULL
    END)) AS rpm_element_langtext_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN V02.rpm_element_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_element_langtext
    ELSE NULL
    END)) AS rpm_element_langtext_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.rpm_element_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_element_langtext
    ELSE NULL
    END)) AS rpm_element_langtext_bg,
 MAX(CASE
   WHEN RFASZ.spr_id = 22
   THEN RFASZ.rpm_feld_auspr_bez
   ELSE NULL
   END) AS eigentum_bez,
 COALESCE(MAX(CASE
    WHEN RFASZ.spr_id = 124
    THEN RFASZ.rpm_feld_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RFASZ.spr_id = 22
    THEN RFASZ.rpm_feld_auspr_bez
    ELSE NULL
    END)) AS eigentum_bez_cz,
 COALESCE(MAX(CASE
    WHEN RFASZ.spr_id = 108
    THEN RFASZ.rpm_feld_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RFASZ.spr_id = 22
    THEN RFASZ.rpm_feld_auspr_bez
    ELSE NULL
    END)) AS eigentum_bez_sk,
 COALESCE(MAX(CASE
    WHEN RFASZ.spr_id = 65
    THEN RFASZ.rpm_feld_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RFASZ.spr_id = 22
    THEN RFASZ.rpm_feld_auspr_bez
    ELSE NULL
    END)) AS eigentum_bez_hr,
 COALESCE(MAX(CASE
    WHEN RFASZ.spr_id = 90
    THEN RFASZ.rpm_feld_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RFASZ.spr_id = 22
    THEN RFASZ.rpm_feld_auspr_bez
    ELSE NULL
    END)) AS eigentum_bez_pl,
 COALESCE(MAX(CASE
    WHEN RFASZ.spr_id = 95
    THEN RFASZ.rpm_feld_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RFASZ.spr_id = 22
    THEN RFASZ.rpm_feld_auspr_bez
    ELSE NULL
    END)) AS eigentum_bez_ro,
 COALESCE(MAX(CASE
    WHEN RFASZ.spr_id = 24
    THEN RFASZ.rpm_feld_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RFASZ.spr_id = 22
    THEN RFASZ.rpm_feld_auspr_bez
    ELSE NULL
    END)) AS eigentum_bez_en,
 COALESCE(MAX(CASE
    WHEN RFASZ.spr_id = 18
    THEN RFASZ.rpm_feld_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RFASZ.spr_id = 22
    THEN RFASZ.rpm_feld_auspr_bez
    ELSE NULL
    END)) AS eigentum_bez_bg
FROM kfl_production_dbp_view.v_rpm_element_per_2 AS V22
 LEFT JOIN kfl_production_dbp_view.v_rpm_element_spr_zu_2 AS V02 ON V22.rpm_hierarchie_id = V02.rpm_element_id
 LEFT JOIN kfl_production_dbp_view.v_rpm_feld_zu_per_2 AS RFZP ON V02.rpm_element_id = RFZP.rpm_hierarchie_id AND RFZP.rpm_tab_id
      = 1 AND RFZP.rpm_feld_id = 8 AND RFZP.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_rpm_feld_auspr_spr_zu_2 AS RFASZ ON RFZP.rpm_feld_auspr_id = RFASZ.rpm_feld_auspr_id
   AND RFASZ.rpm_tab_id = 1 AND RFASZ.rpm_feld_id = 8
WHERE V22.dat_bis = DATE '9999-12-31'
GROUP BY V02.rpm_element_id,
 V02.dat_von;