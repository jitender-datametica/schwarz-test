CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_IN_BESCH_LIEF_DET 
-- 26.10.2011 system_id entfernt
-- 30.11.2011  MR Performance anpassen
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 22.10.2013 TWIE: Join zu in_kunde vereinfacht ueber wup_id
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 24.09.2015 TWIE: NPN, NPB, VKPN, VKPB entfernen, wenn Fakten geloescht sind
-- 21.06.2017 twie: RITM0372799 Erweiterung um artikelart_id REWO
-- 04.03.2019 srom, AP0020745, SPEC0047687 Anpassung Artikelart-ID ZHAW
-- 07.03.2019 twie: nicht mehr benoetigte Felder mit zugehoerigen Joins entfernt (siehe 24.09.2015)
-- 13.05.2019 pjan, AP0043250, SPEC0054321 Anpassung Artikelart-ID ZFLV
(
    lief_beleg_id,
    lief_beleg_pos_id,
    mandant_id --, system_id
,
    dat_lief_soll,
    in_verkaufsorganisation_id,
    werk_id,
    lief_pos_typ_id,
    in_art_id,
    charge_id,
    in_vw_id,
    dat_mat_bereitstllg,
    menge_lief_ist_bme,
    verk_menge_einh_id,
    nettogew,
    menge_lief_ist_lme,
    wrg_id,
    vorlage_beleg_id
) AS
SELECT
    lief_beleg_id,
    lief_beleg_pos_id,
    v01.mandant_id,
    dat_lief_soll,
    in_verkaufsorganisation_id,
    werk_id,
    lief_pos_typ_id,
    in_art_id,
    charge_id,
    in_vw_id,
    dat_mat_bereitstllg,
    MAX(menge_lief_ist_bme) AS menge_lief_ist_bme,
    verk_menge_einh_id,
    MAX(nettogew) AS nettogew,
    MAX(menge_lief_ist_lme) AS menge_lief_ist_lme,
    wrg_id,
    vorlage_beleg_id
FROM DBP_MSI_VIEW_FLW.TBL_MV_F_IN_BESCH_LIEF_DET v01
CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v07
JOIN dbp_view.v_mandant_wrg_typ_zu v08 ON v01.mandant_id = v08.mandant_id
AND v07.wrg_typ_id = v08.wrg_typ_id
        
-- Daher Gruppierung ueber Belege, Positionen, Artikel ... und die max-Werte nehmen
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    13,
    16,
    17;