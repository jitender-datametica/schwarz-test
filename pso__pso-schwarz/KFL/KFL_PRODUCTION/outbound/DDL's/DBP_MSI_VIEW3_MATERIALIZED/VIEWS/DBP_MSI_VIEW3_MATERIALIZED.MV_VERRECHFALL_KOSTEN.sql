-- 18.01.2010 Alex Lipkin   Einschränkung soll_ist_fg =1  aufgenommen

-- 06.10.2010: Awol: wegen Incident TMI2104005 werden verrechfall_status_id = BCC080, BCC085 und BCC090 rausgefiltert

-- 05.03.2014: srom, Anforderung 583005, Zeit Verrechnung Intern

-- 01.07.2010: Awol: für KW37 Anforderung 262654 Einschränkung auf verrechfall_status_id auskommentiert

-- 13.04.2010  AL  Eingeschränkt auf die Daten der Beschaffungslogistik

-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_verrechfall_kosten (USERID STRING) AS
-- costqualifier <> Actual  (nur Target und Delta sollen berücksichtigt werden)
 SELECT V01.mandant_id,
 V01.verrechfall_kosten_id,
 V01.mwst_id,
 V01.storno_fg,
 V01.soll_ist_fg,
 V01.manuelle_erfassung_fg,
 V01.wrg_id,
 V01.wrg_typ_id,
 V01.verrechfall_id,
 V01.dat_verrechnung_intern,
 V01.dat_verrechnung_extern,
 V01.verrechfall_kostenart_id,
 V01.verrechfall_status_id,
 V01.betrag_kosten,
 V01.bemerkung,
 V01.zeit_verrechnung_intern
 -- , CAST(CAST(v01.dat_verrechnung_intern AS STRING(11) )||COALESCE(CAST(v01.zeit_verrechnung_intern AS STRING(8) ),'00:00:00') AS timestamp_ntz(9)) AS dt_verechnung_intern

 ,
 V01.dt_verechnung_intern
FROM kfl_production_dbp_msi_view3_materialized.tbl_mv_verrechfall_kosten AS V01
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_akt_msi_user_prj_wrg_typ_zu(USERID) AS V04 ON V01.wrg_typ_id = V04.wrg_typ_id
  
WHERE V01.soll_ist_fg = 1 -- Eingeschränkt auf die Daten der Beschaffungslogistik

 AND V01.belosart_fg = 0
 AND V01.verrechfall_status_id NOT IN ('BCC080', 'BCC085', 'BCC090');
