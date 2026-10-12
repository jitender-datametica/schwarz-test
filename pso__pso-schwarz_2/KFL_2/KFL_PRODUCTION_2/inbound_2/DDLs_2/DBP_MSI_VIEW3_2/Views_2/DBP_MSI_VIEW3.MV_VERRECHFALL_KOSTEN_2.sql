CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_VERRECHFALL_KOSTEN_2 
(
    mandant_id,
    verrechfall_kosten_id,
    mwst_id,
    storno_fg,
    soll_ist_fg,
    manuelle_erfassung_fg,
    wrg_id,
    wrg_typ_id,
    verrechfall_id,
    dat_verrechnung_intern,
    dat_verrechnung_extern,
    verrechfall_kostenart_id,
    verrechfall_status_id,
    betrag_kosten,
    bemerkung,
    zeit_verrechnung_intern,
    dt_verechnung_intern
) AS
-- 18.01.2010 Alex Lipkin   Einschränkung soll_ist_fg =1  aufgenommen
-- 13.04.2010  AL  Eingeschränkt auf die Daten der Beschaffungslogistik
-- 01.07.2010: Awol: für KW37 Anforderung 262654 Einschränkung auf verrechfall_status_id auskommentiert
-- 06.10.2010: Awol: wegen Incident TMI2104005 werden verrechfall_status_id = BCC080, BCC085 und BCC090 rausgefiltert
-- 05.03.2014: srom, Anforderung 583005, Zeit_2 Verrechnung Intern
-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu_2 ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

SELECT
    v01.mandant_id,
    v01.verrechfall_kosten_id,
    v01.mwst_id,
    v01.storno_fg,
    v01.soll_ist_fg,
    v01.manuelle_erfassung_fg,
    v01.wrg_id,
    v01.wrg_typ_id,
    v01.verrechfall_id,
    v01.dat_verrechnung_intern,
    v01.dat_verrechnung_extern,
    v01.verrechfall_kostenart_id,
    v01.verrechfall_status_id,
betrag_kosten,
    v01.bemerkung,
    v01.zeit_verrechnung_intern --, CAST(CAST(v01.dat_verrechnung_intern AS CHAR(11))||COALESCE(CAST(v01.zeit_verrechnung_intern AS CHAR(8)),'00:00:00') AS TIMESTAMP) AS dt_verechnung_intern
,
dt_verechnung_intern
FROM
    DBP_MSI_VIEW3.TBL_MV_VERRECHFALL_KOSTEN_2 v01
    INNER JOIN dbp_msi_view3.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 v04 
    ON v01.wrg_typ_id = v04.wrg_typ_id
WHERE
    verrechfall_status_id NOT IN ('BCC080', 'BCC085', 'BCC090') --costqualifier <> Actual  (nur Target und Delta sollen berücksichtigt werden)
    AND soll_ist_fg = 1 -- Eingeschränkt auf die Daten der Beschaffungslogistik
    AND belosart_fg = 0;