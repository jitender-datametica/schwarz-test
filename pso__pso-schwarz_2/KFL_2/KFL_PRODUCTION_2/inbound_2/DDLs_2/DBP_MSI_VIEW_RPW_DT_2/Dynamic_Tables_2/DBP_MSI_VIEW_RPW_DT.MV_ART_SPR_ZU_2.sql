create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_ART_SPR_ZU_2(
	SPR_ID,
	ART_ID,
	MANDANT_ID,
	ART_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 05.11.2013 twie: Wertartikel (pro WG vorhanden mit art_id = wg_id * -1000) umbenannt in Sachkonto, da in Bericht 6.04 für Sachkontobuchungen ROW, GOW verwendet (siehen View mv_spanne_wb_lbd_2)
-- 19.10.2018 twie: SPEC0041626 für die Sachkonten (-999000 <= art_id <= -1000) wird pro MWSt Satz ein eigener Dummyartikel erstellt, damit die MWSt. richtig berechnet werden kann.
-- 05.11.2018 twie: SPEC0041626 Aktualisierung der MWSt ID

    SELECT
    spr_id,
    art_id,
    mandant_id,
    CASE WHEN SUBSTR( art_bez, 1, 11) = 'Wertartikel' AND art_id < 0 THEN 'Sachkonto WG '  || TRIM( art_id/-1000) ELSE art_bez END art_bez,
    7
    FROM dbp_view.v_art_spr_zu_2
    WHERE mandant_id = 1
    AND spr_id = 22


    UNION


    -- Dummyartikel für MWSt ID 1, in die Bez die SAP MWSt ID 76, 78, 95, 96
    SELECT
    spr_id,
    art_id -1 AS art_id,
    mandant_id,
    CASE WHEN SUBSTR( art_bez, 1, 11) = 'Wertartikel' AND art_id < 0 THEN 'Sachkonto WG '  || TRIM( art_id/-1000 || '_76_78_95_96') ELSE art_bez END art_bez,
    7
    FROM dbp_view.v_art_spr_zu_2
    WHERE mandant_id = 1
    AND art_id  BETWEEN -999000 AND -1000
    AND spr_id = 22


    UNION


    -- Dummyartikel für MWSt ID 2, in die Bez die SAP MWSt ID 55, 97
    SELECT
    spr_id,
    art_id -2 AS art_id,
    mandant_id,
    CASE WHEN SUBSTR( art_bez, 1, 11) = 'Wertartikel' AND art_id < 0 THEN 'Sachkonto WG '  || TRIM( art_id/-1000 || '_55_79') ELSE art_bez END art_bez,
    7
    FROM dbp_view.v_art_spr_zu_2
    WHERE mandant_id = 1
    AND art_id  BETWEEN -999000 AND -1000
    AND spr_id = 22


    UNION


    -- Dummyartikel für MWSt ID 3, in die Bez die SAP MWSt ID 71, 74
    SELECT
    spr_id,
    art_id -3 AS art_id,
    mandant_id,
    CASE WHEN SUBSTR( art_bez, 1, 11) = 'Wertartikel' AND art_id < 0 THEN 'Sachkonto WG '  || TRIM( art_id/-1000 || '_71_74') ELSE art_bez END art_bez,
    7
    FROM dbp_view.v_art_spr_zu_2
    WHERE mandant_id = 1
    AND art_id  BETWEEN -999000 AND -1000
    AND spr_id = 22


    UNION


    -- Dummyartikel für MWSt ID 9, in die Bez die SAP MWSt ID 99
    SELECT
    spr_id,
    art_id -9 AS art_id,
    mandant_id,
    CASE WHEN SUBSTR( art_bez, 1, 11) = 'Wertartikel' AND art_id < 0 THEN 'Sachkonto WG '  || TRIM( art_id/-1000 || '_99') ELSE art_bez END art_bez,
    7
    FROM dbp_view.v_art_spr_zu_2
    WHERE mandant_id = 1
    AND art_id  BETWEEN -999000 AND -1000
    AND spr_id = 22
 ;
