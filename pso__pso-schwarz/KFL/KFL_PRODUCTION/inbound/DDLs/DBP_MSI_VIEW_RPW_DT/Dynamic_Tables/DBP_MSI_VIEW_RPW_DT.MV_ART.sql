create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_ART(
	ART_ID,
	MANDANT_ID,
	MWST_ID,
	LAND_ID,
	REGION_ID,
	KL_ART_ID,
	KL_ART_ID_LANG,
	DAT_VON,
	DAT_BIS,
	LOESCH_ID,
	WG_ART_FG,
	POSTEN_ID,
	LEAD_ID,
	LEIST_ID,
	DISCOUNT_ID,
	VERPART_ID,
	ESB_ID,
	ALDI_ID,
	ZEK_ID,
	GEWART_ID,
	EIGENMARKE_ID,
	DISPLAY_ID,
	BEST_MENGE_EINH_ID,
	LOESCHVORM_FG,
	MHD_ZEITRAUM,
	ARTIKELART_ID,
	BASISMENGE_EINH_ID,
	FAKTOR_NETTOINHALT,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 19.10.2018 twie: SPEC0041626 für die Sachkonten (-999000 <= art_id <= -1000) wird pro MWSt Satz ein eigener Dummyartikel erstellt, damit die MWSt. richtig angzeigt und berechnet werden kann.
-- 05.11.2018 twie: SPEC0041626 Aktualisierung der MWSt ID
-- 08.09.2021 lsvi: SPEC0125775 - kl_art_id_lang added

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
