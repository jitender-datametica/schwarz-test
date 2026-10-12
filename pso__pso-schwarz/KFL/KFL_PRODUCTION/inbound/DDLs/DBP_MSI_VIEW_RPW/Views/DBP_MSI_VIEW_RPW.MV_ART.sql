CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ART
 -- 19.10.2018 twie: SPEC0041626 für die Sachkonten (-999000 <= art_id <= -1000) wird pro MWSt Satz ein eigener Dummyartikel erstellt, damit die MWSt. richtig angzeigt und berechnet werden kann.
 -- 05.11.2018 twie: SPEC0041626 Aktualisierung der MWSt ID
 -- 08.09.2021 lsvi: SPEC0125775 - kl_art_id_lang added

 (
 art_id
 ,mandant_id
 ,mwst_id
 ,land_id
 ,region_id
 ,kl_art_id
 ,kl_art_id_lang
 ,dat_von
 ,dat_bis
 ,loesch_id
 ,wg_art_fg
 ,posten_id
 ,lead_id
 ,leist_id
 ,discount_id
 ,verpart_id
 ,esb_id
 ,aldi_id
 ,zek_id
 ,gewart_id
 ,eigenmarke_id
 -- ,mutter_art_id
 ,display_id
 ,best_menge_einh_id
 ,loeschvorm_fg
 ,mhd_zeitraum
 ,artikelart_id
 ,basismenge_einh_id
 ,faktor_nettoinhalt
 ,system_id
 )
 AS
    SELECT
    art_id,
    mandant_id,
    mwst_id,
    land_id,
    region_id,
    kl_art_id,
    to_varchar(kl_art_id, 'FM00000000') kl_art_id_lang,
    dat_von,
    dat_bis,
    loesch_id,
    wg_art_fg,
    posten_id,
    lead_id,
    leist_id,
    discount_id,
    verpart_id,
    esb_id,
    aldi_id,
    zek_id,
    gewart_id,
    eigenmarke_id,
    display_id,
    best_menge_einh_id,
    loeschvorm_fg,
    mhd_zeitraum,
    artikelart_id,
    basismenge_einh_id,
    faktor_nettoinhalt,
    7
    FROM dbp_view.v_art
    WHERE mandant_id = 1


    -- Dummyartikel für Sachkonten mit unterschiedlicher MWSt.

    UNION


    -- Dummyartikel für MWSt ID 1
    SELECT
    art_id -1 AS art_id,
    mandant_id,
    1 AS mwst_id,
    land_id,
    region_id,
    kl_art_id,
    to_varchar(kl_art_id, 'FM00000000') kl_art_id_lang,
    dat_von,
    dat_bis,
    loesch_id,
    wg_art_fg,
    posten_id,
    lead_id,
    leist_id,
    discount_id,
    verpart_id,
    esb_id,
    aldi_id,
    zek_id,
    gewart_id,
    eigenmarke_id,
    display_id,
    best_menge_einh_id,
    loeschvorm_fg,
    mhd_zeitraum,
    artikelart_id,
    basismenge_einh_id,
    faktor_nettoinhalt,
    7
    FROM dbp_view.v_art
    WHERE mandant_id = 1
    AND art_id BETWEEN -999000 AND -1000


    UNION


    -- Dummyartikel für MWSt ID 2
    SELECT
    art_id -2 AS art_id,
    mandant_id,
    2 AS mwst_id,
    land_id,
    region_id,
    kl_art_id,
    to_varchar(kl_art_id, 'FM00000000') kl_art_id_lang,
    dat_von,
    dat_bis,
    loesch_id,
    wg_art_fg,
    posten_id,
    lead_id,
    leist_id,
    discount_id,
    verpart_id,
    esb_id,
    aldi_id,
    zek_id,
    gewart_id,
    eigenmarke_id,
    display_id,
    best_menge_einh_id,
    loeschvorm_fg,
    mhd_zeitraum,
    artikelart_id,
    basismenge_einh_id,
    faktor_nettoinhalt,
    7
    FROM dbp_view.v_art
    WHERE mandant_id = 1
    AND art_id BETWEEN -999000 AND -1000


    UNION


    -- Dummyartikel für MWSt ID 3
    SELECT
    art_id -3 AS art_id,
    mandant_id,
    3 AS mwst_id,
    land_id,
    region_id,
    kl_art_id,
    to_varchar(kl_art_id, 'FM00000000') kl_art_id_lang,
    dat_von,
    dat_bis,
    loesch_id,
    wg_art_fg,
    posten_id,
    lead_id,
    leist_id,
    discount_id,
    verpart_id,
    esb_id,
    aldi_id,
    zek_id,
    gewart_id,
    eigenmarke_id,
    display_id,
    best_menge_einh_id,
    loeschvorm_fg,
    mhd_zeitraum,
    artikelart_id,
    basismenge_einh_id,
    faktor_nettoinhalt,
    7
    FROM dbp_view.v_art
    WHERE mandant_id = 1
    AND art_id BETWEEN -999000 AND -1000


    UNION


    -- Dummyartikel für MWSt ID 9
    SELECT
    art_id -9 AS art_id,
    mandant_id,
    9 AS mwst_id,
    land_id,
    region_id,
    kl_art_id,
    to_varchar(kl_art_id, 'FM00000000') kl_art_id_lang,
    dat_von,
    dat_bis,
    loesch_id,
    wg_art_fg,
    posten_id,
    lead_id,
    leist_id,
    discount_id,
    verpart_id,
    esb_id,
    aldi_id,
    zek_id,
    gewart_id,
    eigenmarke_id,
    display_id,
    best_menge_einh_id,
    loeschvorm_fg,
    mhd_zeitraum,
    artikelart_id,
    basismenge_einh_id,
    faktor_nettoinhalt,
    7
    FROM dbp_view.v_art
    WHERE mandant_id = 1
    AND art_id BETWEEN -999000 AND -1000
 ;