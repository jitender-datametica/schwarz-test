CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_IN_BESCH_LIEF_DET 
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
    vorlage_beleg_id
) AS
SELECT
    lief_beleg_id,
    lief_beleg_pos_id,
    mandant_id,
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
    vorlage_beleg_id
FROM
    (
        SELECT
            v01.lief_beleg_id AS lief_beleg_id,
            v02.lief_beleg_pos_id AS lief_beleg_pos_id,
            v01.mandant_id AS mandant_id,
            v01.dat_lief_soll AS dat_lief_soll,
            v01.flw_verkaufsorganisation_id AS in_verkaufsorganisation_id,
            v02.werk_id AS werk_id,
            v02.lief_pos_typ_id AS lief_pos_typ_id,
            v02.flw_art_id AS in_art_id,
            v02.charge_id AS charge_id,
            v02.flw_vw_id AS in_vw_id,
            v02.dat_mat_bereitstllg AS dat_mat_bereitstllg,
            v02.menge_lief_ist_bme AS menge_lief_ist_bme,
            v02.verk_menge_einh_id AS verk_menge_einh_id,
            v02.nettogew AS nettogew,
            v02.menge_lief_ist_lme AS menge_lief_ist_lme,
            v02.vorlage_beleg_id
        FROM
            dbp_view.v_flw_besch_lief v01
            JOIN dbp_view.v_flw_besch_lief_det v02 ON v01.mandant_id = v02.mandant_id
            AND v01.lief_beleg_id = v02.lief_beleg_id -- Einschraenkung auf bestimmte Materialarten ueber artikelart_id IN ('ZKMN','HALB','ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA','ZDIE','REWO','ZFLV')
            JOIN dbp_view.v_flw_art v05 ON v01.mandant_id = v05.mandant_id
            AND v02.flw_art_id = v05.flw_art_id
        WHERE
            v05.artikelart_id IN (
                'ZKMN',
                'HALB',
                'ZERL',
                'ZFER',
                'ROH',
                'VERP',
                'FERT',
                'HAWA',
                'ZDIE',
                'REWO',
                'ZHAW',
                'ZFLV'
            )
            AND v01.mandant_id IN (1, 2)
    ) dt1 -- Es kann zu einem Zeitpunkt mehrere Aktionen fuer einen Artikel im Markt geben
    -- Daher Gruppierung ueber Belege, Positionen, Artikel ... und die max-Werte nehmen
;