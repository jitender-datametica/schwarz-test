CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WOCHE_1
AS
 -- ZEIT_1-Hierachie : Kalenderwoche
 -- 2009KW47: Review + Neue Felder
 -- 2011KW28 Neue Felder + Korrektur VJ
 -- 2013KW28 Begrenzuung auf letzten 10 Jahre + akt. Jahr erweitert
 -- 2015KW22 wo_von, KW und nur Anfangsdatum (benötigt weniger Platz, u.a. HL_1 Cockpit)
 -- 2020.0121 ssch0611 : VJ-Join removed. kw_bez (text) added
 -- 2021.1115 snik1809 : Cast(kjwo/100) --> FLOOR(kjwo/100)
 -- 2025-01-27 muellerpatri : Erweiterung um Spalte JWO

SELECT 
  v01.kjwo
, v01.akt_wo
, v01.akt_wo_komplett
, v01.wo_dat_von
, v01.wo_dat_bis
, v01.kjwo_vj
  -- Format
, FLOOR(v01.kjwo    / 100)                       AS kj
, FLOOR(v01.kjwo_vj / 100)                       AS kj_vj
, CAST(MOD(v01.kjwo,100) AS INTEGER)             AS wo_kj
, CAST(MOD(v01.kjwo,100) AS INTEGER)             AS jwo 
, CAST(MOD(v01.kjwo_vj,100) AS INTEGER)          AS wo_vj
, TO_VARCHAR(wo_kj, '00')  AS kw_ist
, TO_VARCHAR(wo_vj,'00') AS kw_vj
  -- Text
, CAST(kw_ist || ' (' || SUBSTR(wo_dat_von, 9,2) || '.' || SUBSTR(wo_dat_von, 6,2) || '.-' || SUBSTR(wo_dat_bis, 9,2) || '.' || SUBSTR(wo_dat_bis, 6,2) || '.)'  AS VARCHAR(20)) AS wo_von_bis
, CAST(kw_ist || ' (' || SUBSTR(wo_dat_von, 9,2) || '.' || SUBSTR(wo_dat_von, 6,2) || '.)'  AS VARCHAR(20))  AS wo_von
, TO_DATE(SUBSTRING(v01.wo_dat_von,1, 8)||'01','yyyy-mm_1-dd')  AS wo_dat_mo
, CAST(kw_ist || ' | ' || kw_vj  AS VARCHAR(20))  AS kw_ist_vj
, CAST('KW' || kw_ist AS VARCHAR(20))           AS kw_bez      --standard (DE)
, CAST('KW' || kw_ist AS VARCHAR(20))           AS kw_bez_de   --deutsch
, CAST('KT' || kw_ist AS VARCHAR(20))           AS kw_bez_cz   --tschechisch
, CAST('KW' || kw_ist AS VARCHAR(20))           AS kw_bez_sk   --slowakisch
, CAST('KW' || kw_ist AS VARCHAR(20))           AS kw_bez_hr   --kroatisch
, CAST('KW' || kw_ist AS VARCHAR(20))           AS kw_bez_pl   --polnisch
, CAST('KW' || kw_ist AS VARCHAR(20))           AS kw_bez_ro   --rumänisch
, CAST('КС' || kw_ist AS VARCHAR(20))           AS kw_bez_bg   --bulgarisch 
, CAST('KW' || kw_ist || ' aufg.' AS VARCHAR(20))  AS kw_aufg_bez      --standard (DE)
, CAST('KW' || kw_ist || ' kum.'  AS VARCHAR(20))  AS kw_aufg_bez_de   --deutsch
, CAST('KT' || kw_ist || ' kum.'  AS VARCHAR(20))  AS kw_aufg_bez_cz   --tschechisch
, CAST('KW' || kw_ist || ' kum.'  AS VARCHAR(20))  AS kw_aufg_bez_sk   --slowakisch
, CAST('KW' || kw_ist || ' kum.'  AS VARCHAR(20))  AS kw_aufg_bez_hr   --kroatisch
, CAST('KW' || kw_ist || ' skum.' AS VARCHAR(20))  AS kw_aufg_bez_pl   --polnisch
, CAST('KW' || kw_ist || ' cum.'  AS VARCHAR(20))  AS kw_aufg_bez_ro   --rumänisch
, CAST('КС' || kw_ist || ' кум.'  AS VARCHAR(20))  AS kw_aufg_bez_bg   --bulgarisch 

FROM dbp_view.v_woche_1 v01

WHERE v01.akt_wo BETWEEN -571 AND 55;