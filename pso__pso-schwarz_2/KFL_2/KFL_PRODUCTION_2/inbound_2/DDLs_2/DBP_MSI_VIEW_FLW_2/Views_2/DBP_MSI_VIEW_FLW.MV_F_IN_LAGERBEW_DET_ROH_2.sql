 CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_IN_LAGERBEW_DET_ROH_2 
-- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 23.01.2013 twie: Lieferantennr. 337028 und 10120130 fuer neues Werk Bad Heiligenstadt hinzugefuegt
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 21.06.2017 twie: RITM0372799 Erweiterung um artikelart_id REWO
-- 10.07.2017 twie: SPEC0025417 lager_bewart_id Filterung auf CHAR statt INT
-- 04.03.2019 srom, AP0020745, SPEC0047687 Anpassung Artikelart-ID ZHAW
-- 13.05.2019 pjan, AP0043250, SPEC0054321 Anpassung Artikelart-ID ZFLV
(
    mandant_id --, system_id
,
    werk_id,
    dat_buch,
    wrg_id_org,
    wrg_id,
    best_beleg_id,
    in_art_id,
    wa_intern
) AS
SELECT
    v01.mandant_id,
    werk_id,
    dat_buch,
    wrg_id_org,
    v01.wrg_id,
    best_beleg_id,
    in_art_id,
    CAST(
        CASE
            -- Landesbeleg in Euro wird in Euro angezeigt
            WHEN v01.preis_steuer_kz = 'V'
            AND v01.wrg_id_org <> v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN COALESCE((v01.betrag_lagerbew), 0) -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
            WHEN v01.preis_steuer_kz = 'V'
            AND v01.wrg_id_org <> v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN (
                COALESCE((v01.betrag_lagerbew), 0) / v500.umrechnungskurs
            ) -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
            WHEN v01.preis_steuer_kz = 'V'
            AND v01.wrg_id_org = v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN COALESCE((v01.betrag_lagerbew), 0) * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
            WHEN v01.preis_steuer_kz = 'V'
            AND v01.wrg_id_org = v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN COALESCE((v01.betrag_lagerbew), 0) -- Standardpreis
            -- Landesbeleg in Euro wird in Euro angezeigt
            WHEN v01.preis_steuer_kz = 'S'
            AND v01.wrg_id_org <> v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN COALESCE((v01.betrag_lagerbew_altnv), 0) -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
            WHEN v01.preis_steuer_kz = 'S'
            AND v01.wrg_id_org <> v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN (
                COALESCE((v01.betrag_lagerbew_altnv), 0) / v500.umrechnungskurs
            ) -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
            WHEN v01.preis_steuer_kz = 'S'
            AND v01.wrg_id_org = v01.default_wrg
            AND v200.wrg_typ_id = 0 THEN COALESCE((v01.betrag_lagerbew_altnv), 0) * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
            WHEN v01.preis_steuer_kz = 'S'
            AND v01.wrg_id_org = v01.default_wrg
            AND v200.wrg_typ_id = 1 THEN COALESCE((v01.betrag_lagerbew_altnv), 0)
        END AS DECIMAL(18, 6)
    ) AS wa_intern
FROM DBP_MSI_VIEW_FLW.TBL_MV_F_IN_LAGERBEW_DET_ROH_2 v01
    CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200
    CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v300 -- Aufloesung eingestellte Waehrung nach Kurstyp(0 = Euro,1 = Landeswaehrung)
    JOIN dbp_view.v_mandant_wrg_typ_zu_2 v400 ON v01.mandant_id = v400.mandant_id
    AND v200.wrg_typ_id = v400.wrg_typ_id -- Umrechnung Standardkurs, Tageskurs
    JOIN dbp_view.v_kurs_2 v500 ON v300.kurstyp_id = v500.kurstyp_id
    AND v01.wrg_id = v500.von_wrg_id
    AND v500.nach_wrg_id = 'EUR'
    AND v01.dat_buch BETWEEN v500.dat_von
    AND v500.dat_bis -- Einschraenkgung auf bestimmte Materialarten ueber artikelart_id IN ('ZKMN','HALB','ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA','ZDIE','REWO','ZFLV')
;