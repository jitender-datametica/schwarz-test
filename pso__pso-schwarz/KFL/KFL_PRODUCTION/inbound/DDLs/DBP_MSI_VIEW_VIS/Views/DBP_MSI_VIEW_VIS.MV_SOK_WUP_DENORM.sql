CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SOK_WUP_DENORM(
    MANDANT_ID,
    WUP_ID,
    ANZ_EINKAUFSWAGEN_BOXEN,
    ANZ_HEISSGETRAENKE_AUTOMATEN,
    ANZ_T_ZELLEN_BACKSHOP,
    HAEUFIGSTE_ULTRA_FRISCHE_LISTUNGSSTUFE_KZ,
    HAEUFIGSTE_MOPRO_LISTUNGSSTUFE_KZ,
    HAEUFIGSTE_TIKO_LISTUNGSSTUFE_KZ,
    HAEUFIGSTE_TROCKEN_LISTUNGSSTUFE_KZ,
    HAEUFIGSTE_NONFOOD_LISTUNGSSTUFE_KZ
) AS 
/* 
   2024-07-01 muellerpatri : Initiale Erstellung der View, AP0186508
   2024-12-20 muellerpatri : Erweiterung um Häufigste-Spalten
*/
SELECT 
    den.mandant_id
    , den.wup_id
    , den.anz_einkaufswagen_boxen
    , den.anz_heissgetraenke_automaten
    , den.anz_t_zellen_backshop
    , den.haeufigste_ultra_frische_listungsstufe_kz
    , den.haeufigste_mopro_listungsstufe_kz
    , den.haeufigste_tiko_listungsstufe_kz
    , den.haeufigste_trocken_listungsstufe_kz
    , den.haeufigste_nonfood_listungsstufe_kz
FROM dbp_msi_v_view.v_wup_denorm den
;