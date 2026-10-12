CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_LAGERBEW_DET_1 -- 15.10.2013 twie: neu erstellt fuer CZ Abschriften_1
-- 21.10.2013 twie: Join auf in_art_1 jetzt auf MV-VIEW, damit auch reine Retailartikel mitkommen
-- 23.10.2013 twie: reine Retailartikel ohne Industriependant mit Retailumrechnungsfaktor umrechnen
-- 28.05.2014 twie: betrag_vk in netto statt brutto ausgeben, sowie menge_lagerbew_bme
-- Vorzeichen umdrehen bei Storno Bewegungsart?
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
    lagerbew_beleg_id,
    lagerbew_beleg_pos_id,
    mandant_id,
    kj,
    wup_id,
    nb_id,
    in_kunde_id,
    dat_buch,
    art_id,
    in_art_id,
    lager_bewart_id,
    menge_lagerbew_bme,
    menge_lagerbew_kg,
    wrg_id,
    default_wrg,
    betrag_vk_netto,
    mwst
) AS
SELECT
    v01.lagerbew_beleg_id,
    v01.lagerbew_beleg_pos_id,
    v01.mandant_id,
    v01.kj,
    v01.wup_id,
    v01.nb_id,
    v07.flw_kunde_id AS in_kunde_id,
    v01.dat_buch,
    v01.art_id,
    v05.flw_art_id AS in_art_id,
    v01.lager_bewart_id,
    v01.menge_lagerbew_bme,
    CASE
        WHEN v05.basismenge_einh_id = 'KG' THEN v01.menge_lagerbew_bme -- Artikel_1, die es im Industrie gibt (flw_art_id >= 0) mit Industrie Umrechnungsfaktor multiplizieren
        WHEN v05.basismenge_einh_id = 'ST'
        AND v05.flw_art_id >= 0 THEN CAST(
            v01.menge_lagerbew_bme * v08.umrech_faktor AS DECIMAL(18, 6)
        ) -- Artikel_1, die es nur im Retail gibt (Dummy_1 flw_art_id < 0) mit Retail Umrechnungsfaktor multiplizieren
        WHEN v05.basismenge_einh_id = 'ST'
        AND v05.flw_art_id < 0 THEN CAST(
            v01.menge_lagerbew_bme * v09.umrech_faktor AS DECIMAL(18, 6)
        )
    END AS menge_lagerbew_kg,
    v01.wrg_id,
    v100.default_wrg,
    v01.betrag_vk_netto,
    v06.mwst
FROM
    dbp_view.v_lagerbew_det_1 v01
    INNER JOIN dbp_view.v_art_1 v04 ON v01.art_id = v04.art_id
    AND v01.mandant_id = v04.mandant_id
    AND v01.dat_buch BETWEEN v04.dat_von
    AND v04.dat_bis
    INNER JOIN dbp_msi_view_flw.mv_l_in_art_1 v05 -- MARA_1 + Retailartikel
    ON v05.art_id = v04.art_id
    AND v05.mandant_id = v04.mandant_id
    LEFT OUTER JOIN dbp_view.v_mwst_per_1 v06 ON v04.mwst_id = v06.mwst_id
    AND v04.mandant_id = v06.mandant_id
    AND v01.dat_buch BETWEEN v06.dat_von
    AND v06.dat_bis
    LEFT OUTER JOIN dbp_view.v_flw_kunde_1 v07 ON v01.wup_id = v07.wup_id
    AND v01.mandant_id = v07.mandant_id
    LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per_1 v08 ON v05.flw_art_id = v08.flw_art_id
    AND v05.mandant_id = v08.mandant_id
    AND (
        CASE
            WHEN v05.basismenge_einh_id = 'ST' THEN 'KG'
            WHEN v05.basismenge_einh_id = 'KG' THEN 'ST'
        END
    ) = v08.altnv_menge_einh_id
    LEFT OUTER JOIN dbp_view.v_art_umrechnung_faktor_per_1 v09 ON v05.mandant_id = v09.mandant_id
    AND v05.art_id = v09.art_id
    AND (
        CASE
            WHEN v05.basismenge_einh_id = 'ST' THEN 'KG'
            WHEN v05.basismenge_einh_id = 'KG' THEN 'ST'
        END
    ) = v09.altnv_menge_einh_id
    AND v09.dat_bis = '9999-12-31' -- Ermittlung der default Waehrung
    JOIN dbp_view.v_mandant_1 v100 ON v01.mandant_id = v100.mandant_id
   WHERE
    v01.mandant_id IN (1, 2);