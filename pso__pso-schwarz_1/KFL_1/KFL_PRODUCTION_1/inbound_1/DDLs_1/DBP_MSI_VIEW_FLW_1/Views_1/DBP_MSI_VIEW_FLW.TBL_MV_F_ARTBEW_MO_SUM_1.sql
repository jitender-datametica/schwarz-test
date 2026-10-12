CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_ARTBEW_MO_SUM_1 
-- 30.11.2011 MR Performance art_id Verbindung
-- 26.10.2011 system_id entfernt
-- 02.10.2013 twie: Erweitert um mandant_id 2
-- 21.10.2013 twie: Join auf in_art_1 jetzt auf MV-VIEW, damit auch reine Retailartikel mitkommen
-- 22.10.2013 twie: Join zu in_kunde_1 vereinfacht ueber wup_id
-- 23.10.2013 twie: reine Retailartikel ohne Industriependant mit Retailumrechnungsfaktor umrechnen
-- 24.10.2013 twie: gp_id ausgeben
-- 29.01.2014 twie: Waehrungsumrechnung, Achtung Tabelle hat keine wrg_id, manche Fakten sind immer in Euro, manche immer in Landeswrg.
-- 13.02.2014 twie: ek_mep ausgeben, diff_umsatz_netto_konz entfernen
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 18.09.2018 naku:  WG Umstellung und Anpassungen: Alte wg_id durch neue ersetzt
(
    kjmo,
    mandant_id,
    art_id --  ,system_id
,
    in_kunde_id,
    kunde_nr,
    kunde_name,
    in_art_id,
    in_art_nr,
    vk_menge_org,
    basismenge_einh_id,
    vk_menge_st,
    vk_menge_kg,
    ek_mep_umsatz_temp,
    bewart_id,
    gp_id,
    default_wrg,
    max_dat,
    umsatz_netto
) AS
SELECT
    v01.kjmo,
    v01.mandant_id AS mandant_id,
    v01.art_id,
    v05.flw_kunde_id AS in_kunde_id,
    COLLATE(LTRIM(COLLATE(v05.kunde_nr, ''), '0'), 'en-ci') AS kunde_nr,
    v05.kunde_name,
    v03.flw_art_id AS in_art_id,
    v03.in_art_nr,
    v01.menge AS vk_menge_org,
    v03.basismenge_einh_id,
    CASE
        WHEN v03.basismenge_einh_id = 'KG'
        AND v03.flw_art_id >= 0 THEN CAST(v01.menge * v06.umrech_faktor AS DECIMAL(18, 6)) -- Artikel_1, die es nur im Retail gibt (Dummy_1 flw_art_id < 0) mit Retail Umrechnungsfaktor multiplizieren
        WHEN v03.basismenge_einh_id = 'KG'
        AND v03.flw_art_id < 0 THEN CAST(v01.menge * v07.umrech_faktor AS DECIMAL(18, 6))
        WHEN v03.basismenge_einh_id = 'ST' THEN v01.menge
    END AS vk_menge_st,
    CASE
        WHEN v03.basismenge_einh_id = 'KG' THEN v01.menge
        WHEN v03.basismenge_einh_id = 'ST'
        AND v03.flw_art_id >= 0 THEN CAST(v01.menge * v06.umrech_faktor AS DECIMAL(18, 6))
        WHEN v03.basismenge_einh_id = 'ST'
        AND v03.flw_art_id < 0 THEN CAST(v01.menge * v07.umrech_faktor AS DECIMAL(18, 6))
    END AS vk_menge_kg,
    CASE
        WHEN v09.wg_id IN (122, 128, 146, 147, 184, 186) THEN v01.ek_mep
        ELSE NULL
    END AS ek_mep_umsatz_temp,
    v01.bewart_id,
    v01.gp_id,
    v100.default_wrg,
    v08.max_dat,
    v01.umsatz_netto
FROM
    dbp_view.v_artbew_mo_sum_1 v01
    INNER JOIN dbp_view.v_art_1 v02 ON v01.art_id = v02.art_id
    AND v01.mandant_id = v02.mandant_id
    INNER JOIN dbp_msi_view_flw.mv_l_in_art_1 v03 -- MARA_1 + Retailartikel
    ON v03.art_id = v02.art_id
    AND v03.mandant_id = v02.mandant_id
    LEFT JOIN dbp_view.v_flw_kunde_1 v05 ON v05.wup_id = v01.wup_id
    AND v05.mandant_id = v01.mandant_id
    LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per_1 v06 ON v03.mandant_id = v06.mandant_id
    AND v03.flw_art_id = v06.flw_art_id
    AND (
        CASE
            WHEN v03.basismenge_einh_id = 'ST' THEN 'KG'
            WHEN v03.basismenge_einh_id = 'KG' THEN 'ST'
        END
    ) = v06.altnv_menge_einh_id
    LEFT OUTER JOIN dbp_view.v_art_umrechnung_faktor_per_1 v07 ON v03.mandant_id = v07.mandant_id
    AND v03.art_id = v07.art_id
    AND (
        CASE
            WHEN v03.basismenge_einh_id = 'ST' THEN 'KG'
            WHEN v03.basismenge_einh_id = 'KG' THEN 'ST'
        END
    ) = v07.altnv_menge_einh_id
    AND v07.dat_bis = '9999-12-31'
    INNER JOIN dbp_view.v_monat_1 v08 ON v01.kjmo = v08.kjmo
    JOIN dbp_msi_view_flw.mv_art_wg_zu_per_1 v09 ON (
        v03.flw_art_id = v09.flw_art_id
        AND v03.mandant_id = v09.mandant_id
    )
    JOIN dbp_view.v_mandant_1 v100 ON v01.mandant_id = v100.mandant_id
WHERE
    v01.mandant_id IN (1, 2)
    AND v09.arthiertyp_id = 2;