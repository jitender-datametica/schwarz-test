CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_projekt_bauabschnitt_zu_spr_zu_2 AS SELECT CAST(V01.bauabschnitt_id AS STRING)
 AS bauabschnitt_id,
 MAX(CASE
   WHEN sub01.spr_id = 22
   THEN sub01.bauabschnitt_bez
   ELSE NULL
   END) AS bauabschnitt_bez,
 COALESCE(MAX(CASE
    WHEN sub01.spr_id = 124
    THEN sub01.bauabschnitt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN sub01.spr_id = 22
    THEN sub01.bauabschnitt_bez
    ELSE NULL
    END)) AS bauabschnitt_bez_cz,
 COALESCE(MAX(CASE
    WHEN sub01.spr_id = 108
    THEN sub01.bauabschnitt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN sub01.spr_id = 22
    THEN sub01.bauabschnitt_bez
    ELSE NULL
    END)) AS bauabschnitt_bez_sk,
 COALESCE(MAX(CASE
    WHEN sub01.spr_id = 65
    THEN sub01.bauabschnitt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN sub01.spr_id = 22
    THEN sub01.bauabschnitt_bez
    ELSE NULL
    END)) AS bauabschnitt_bez_hr,
 COALESCE(MAX(CASE
    WHEN sub01.spr_id = 90
    THEN sub01.bauabschnitt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN sub01.spr_id = 22
    THEN sub01.bauabschnitt_bez
    ELSE NULL
    END)) AS bauabschnitt_bez_pl,
 COALESCE(MAX(CASE
    WHEN sub01.spr_id = 95
    THEN sub01.bauabschnitt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN sub01.spr_id = 22
    THEN sub01.bauabschnitt_bez
    ELSE NULL
    END)) AS bauabschnitt_bez_ro,
 COALESCE(MAX(CASE
    WHEN sub01.spr_id = 24
    THEN sub01.bauabschnitt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN sub01.spr_id = 22
    THEN sub01.bauabschnitt_bez
    ELSE NULL
    END)) AS bauabschnitt_bez_en,
 COALESCE(MAX(CASE
    WHEN sub01.spr_id = 18
    THEN sub01.bauabschnitt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN sub01.spr_id = 22
    THEN sub01.bauabschnitt_bez
    ELSE NULL
    END)) AS bauabschnitt_bez_bg,
 MAX(CASE
   WHEN sub01.spr_id = 22
   THEN sub01.bauabschnitt_langtext
   ELSE NULL
   END) AS bauabschnitt_langtext,
 COALESCE(MAX(CASE
    WHEN sub01.spr_id = 124
    THEN sub01.bauabschnitt_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN sub01.spr_id = 22
    THEN sub01.bauabschnitt_langtext
    ELSE NULL
    END)) AS bauabschnitt_langtext_cz,
 COALESCE(MAX(CASE
    WHEN sub01.spr_id = 108
    THEN sub01.bauabschnitt_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN sub01.spr_id = 22
    THEN sub01.bauabschnitt_langtext
    ELSE NULL
    END)) AS bauabschnitt_langtext_sk,
 COALESCE(MAX(CASE
    WHEN sub01.spr_id = 65
    THEN sub01.bauabschnitt_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN sub01.spr_id = 22
    THEN sub01.bauabschnitt_langtext
    ELSE NULL
    END)) AS bauabschnitt_langtext_hr,
 COALESCE(MAX(CASE
    WHEN sub01.spr_id = 90
    THEN sub01.bauabschnitt_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN sub01.spr_id = 22
    THEN sub01.bauabschnitt_langtext
    ELSE NULL
    END)) AS bauabschnitt_langtext_pl,
 COALESCE(MAX(CASE
    WHEN sub01.spr_id = 95
    THEN sub01.bauabschnitt_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN sub01.spr_id = 22
    THEN sub01.bauabschnitt_langtext
    ELSE NULL
    END)) AS bauabschnitt_langtext_ro,
 COALESCE(MAX(CASE
    WHEN sub01.spr_id = 24
    THEN sub01.bauabschnitt_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN sub01.spr_id = 22
    THEN sub01.bauabschnitt_langtext
    ELSE NULL
    END)) AS bauabschnitt_langtext_en,
 COALESCE(MAX(CASE
    WHEN sub01.spr_id = 18
    THEN sub01.bauabschnitt_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN sub01.spr_id = 22
    THEN sub01.bauabschnitt_langtext
    ELSE NULL
    END)) AS bauabschnitt_langtext_bg
FROM kfl_production_dbp_view.v_cpr_projekt_bauabschnitt_zu_2 AS V01
 INNER JOIN ((SELECT V05.projekt_id AS bauabschnitt_id,
     V05.cpr_projekt_bez AS bauabschnitt_bez,
     V05.cpr_projekt_langtext AS bauabschnitt_langtext,
     V05.spr_id
    FROM kfl_production_dbp_view.v_cpr_projekt_spr_zu_per_2 AS V05
     INNER JOIN kfl_production_dbp_view.v_cpr_projekt_bauabschnitt_zu_2 AS V01 ON V05.projekt_id = V01.projekt_id
    WHERE V05.dat_bis = DATE '9999-12-31'
    UNION DISTINCT
    SELECT V06.projekt_phase_id AS bauabschnitt_id,
     V06.cpr_phase_bez AS bauabschnitt_bez,
     V06.cpr_phase_langtext AS bauabschnitt_langtext,
     V06.spr_id
    FROM kfl_production_dbp_view.v_cpr_phase_spr_zu_per_2 AS V06
     INNER JOIN kfl_production_dbp_view.v_cpr_projekt_bauabschnitt_zu_2 AS V01 ON V06.projekt_phase_id = V01.bauabschnitt_id
      
    WHERE V06.dat_bis = DATE '9999-12-31')
   UNION DISTINCT
   SELECT V07.cpr_aufgabe_id AS bauabschnitt_id,
    V07.aufgabe_bez AS bauabschnitt_bez,
    V07.aufgabe_langtext AS bauabschnitt_langtext,
    V07.spr_id
   FROM kfl_production_dbp_view.v_cpr_aufgabe_spr_zu_per_2 AS V07
    INNER JOIN kfl_production_dbp_view.v_cpr_projekt_bauabschnitt_zu_2 AS V01 ON V07.cpr_aufgabe_id = V01.bauabschnitt_id
   WHERE V07.dat_bis = DATE '9999-12-31') AS sub01 ON V01.bauabschnitt_id = sub01.bauabschnitt_id
GROUP BY V01.bauabschnitt_id;