CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_IN_PRUEF_LOS_2 
-- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 12.12.2012 twie: Filterung auf ekorg_id 5000 und 5013 da Filterung in EKKO_2 beim Beladen entfaellt
-- 18.02.2013 twie: aenderung in Datenmodell, Spaltnname ekorg_id heisst jetzt einkaufsorganisation_id
-- 22.07.2013 twieder: Bew.art_2 531 und 532 hinzu
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 21.06.2017 twie: RITM0372799 Erweiterung um artikelart_id REWO (im Kommentar)
-- 10.07.2017 twie: SPEC0025417 lager_bewart_id Y29 + Y30 ergaenzt, Filterung auf CHAR statt INT
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including einkaufsorganisation_id 5014
(
    mandant_id --, system_id
,
    best_beleg_id,
    best_beleg_pos_id,
    dat_buch,
    prueflos_id,
    werk_id,
    in_art_id,
    in_lief_id,
    herkunft,
    pruefart_id,
    wrg_id,
    anz_stp_merkmal,
    anz_wert_ergebnis,
    menge_lagerbew_kg,
    lbd_we_menge_kg,
    lbd_we_wert,
    lbd_we_wert_eur
) AS
SELECT
    v00.mandant_id,
    v00.best_beleg_id,
    v00.best_beleg_pos_id,
    v00.dat_buch,
    v00.prueflos_id,
    v00.werk_id,
    v00.in_art_id,
    v00.in_lief_id,
    v00.herkunft,
    v00.pruefart_id,
    v00.wrg_id,
    v00.anz_stp_merkmal,
    v00.anz_wert_ergebnis,
    v00.menge_lagerbew_kg,
    v00.lbd_we_menge_kg,
    v00.lbd_we_wert,
    v00.lbd_we_wert_eur
FROM
    (
        SELECT
            v01.mandant_id,
            v01.best_beleg_id,
            v01.best_beleg_pos_id,
            v01.dat_buch,
            v01.prueflos_id,
            v01.werk_id,
            v01.in_art_id,
            v01.in_lief_id,
            v01.herkunft,
            v01.pruefart_id,
            v400.wrg_id,
            CASE
                -- Landesbeleg in Euro wird in Euro angezeigt
                WHEN v01.wrg_id <> v01.default_wrg
                AND v200.wrg_typ_id = 0 -- 0 = Euro
                THEN v01.betrag_lagerbew * vorzeichen -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
                WHEN v01.wrg_id <> v01.default_wrg
                AND v200.wrg_typ_id = 1 -- 1 = Landeswaehrung
                THEN (
                    v01.betrag_lagerbew * vorzeichen / v500.umrechnungskurs
                ) --Landesbeleg in Landeswaehrung wird in Euro angezeigt
                WHEN v01.wrg_id = v01.default_wrg
                AND v200.wrg_typ_id = 0 -- 0 = Euro
                THEN v01.betrag_lagerbew * vorzeichen * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
                WHEN v01.wrg_id = v01.default_wrg
                AND v200.wrg_typ_id = 1 -- 1 = Landeswaehrung
                THEN v01.betrag_lagerbew * vorzeichen
            END AS betrag_lagerbew_,
            CASE
                -- Landesbeleg in Euro wird in Euro angezeigt
                WHEN v01.wrg_id <> v01.default_wrg
                AND v200.wrg_typ_id = 0 -- 0 = Euro
                THEN v01.betrag_lagerbew_altnv * vorzeichen -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
                WHEN v01.wrg_id <> v01.default_wrg
                AND v200.wrg_typ_id = 1 -- 1 = Landeswaehrung
                THEN (
                    v01.betrag_lagerbew_altnv * vorzeichen / v500.umrechnungskurs
                ) --Landesbeleg in Landeswaehrung wird in Euro angezeigt
                WHEN v01.wrg_id = v01.default_wrg
                AND v200.wrg_typ_id = 0 -- 0 = Euro
                THEN v01.betrag_lagerbew_altnv * vorzeichen * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
                WHEN v01.wrg_id = v01.default_wrg
                AND v200.wrg_typ_id = 1 -- 1 = Landeswaehrung
                THEN v01.betrag_lagerbew_altnv * vorzeichen
            END AS betrag_lagerbew_altnv_,
            CASE
                -- Landesbeleg in Euro wird in Euro angezeigt
                WHEN v01.wrg_id <> v01.default_wrg THEN v01.betrag_lagerbew * vorzeichen --Landesbeleg in Landeswaehrung wird in Euro angezeigt
                WHEN v01.wrg_id = v01.default_wrg THEN v01.betrag_lagerbew * vorzeichen * v500.umrechnungskurs
            END AS betrag_lagerbew_eur_,
            CASE
                -- Landesbeleg in Euro wird in Euro angezeigt
                WHEN v01.wrg_id <> v01.default_wrg THEN v01.betrag_lagerbew_altnv * vorzeichen --Landesbeleg in Landeswaehrung wird in Euro angezeigt
                WHEN v01.wrg_id = v01.default_wrg THEN v01.betrag_lagerbew_altnv * vorzeichen * v500.umrechnungskurs
            END AS betrag_lagerbew_altnv_eur_,
            anz_stp_merkmal,
            anz_wert_ergebnis,
            CASE
                WHEN v01.basismenge_einh_id = 'KG' THEN v01.menge_lagerbew_bme * vorzeichen
                WHEN v01.basismenge_einh_id = 'ST' THEN CAST(
                    v01.menge_lagerbew_bme * vorzeichen * v01.umrech_faktor AS DECIMAL(18, 6)
                )
            END AS menge_lagerbew_kg,
            CASE
                WHEN v01.best_menge_einh_id = 'KG' THEN menge_lagerbew_kg
                WHEN v01.best_menge_einh_id <> 'KG'
                AND v01.altnv_menge_einh_id = 'KG' THEN menge_lagerbew_kg
            END AS lbd_we_menge_kg,
            CASE
                WHEN v01.preis_steuer_kz = 'V' THEN betrag_lagerbew_
                WHEN v01.preis_steuer_kz = 'S' THEN betrag_lagerbew_altnv_
            END AS lbd_we_wert,
            CASE
                WHEN v01.preis_steuer_kz = 'V' THEN betrag_lagerbew_eur_
                WHEN v01.preis_steuer_kz = 'S' THEN betrag_lagerbew_altnv_eur_
            END AS lbd_we_wert_eur
        FROM DBP_MSI_VIEW_FLW.TBL_MV_F_IN_PRUEF_LOS_2 v01
          
            CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200
            CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v300 -- Aufloesung eingestellte Waehrung nach Kurstyp(0 = Euro,1 = Landeswaehrung)
            JOIN dbp_view.v_mandant_wrg_typ_zu_2 v400 ON v01.mandant_id = v400.mandant_id
            AND v200.wrg_typ_id = v400.wrg_typ_id -- Umrechnung Standardkurs, Tageskurs
            JOIN dbp_view.v_kurs_2 v500 ON v300.kurstyp_id = v500.kurstyp_id
            AND v01.wrg_id = v500.von_wrg_id
            AND v500.nach_wrg_id = 'EUR'
            AND v01.dat_buch BETWEEN v500.dat_von
            AND v500.dat_bis
 
    ) v00;