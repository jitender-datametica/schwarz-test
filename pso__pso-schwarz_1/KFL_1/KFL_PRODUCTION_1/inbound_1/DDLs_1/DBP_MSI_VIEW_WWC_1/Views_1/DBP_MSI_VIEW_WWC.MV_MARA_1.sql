CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_MARA_1 
    (
        art_id
        ,mandant_id
        ,mandant_kbez
        ,MATNR_SAP
        ,mwst_id
        ,land_id
        ,region_id
        ,kl_art_id
        ,dat_von
        ,dat_bis
        ,loesch_id
        ,bio_fg
        ,wg_art_fg
        ,lead_id
        ,leist_id
        ,discount_id
        ,verpart_id
        ,esb_id
        ,aldi_id
        ,zek_id
        ,gewart_id
        ,eigenmarke_id
        ,mutter_wb_id
        ,PMATA
        ,display_id
        ,BPRME
        ,loeschvorm_fg
        ,mhd_zeitraum
        ,MEINS
        ,MTART
        ,faktor_nettoinhalt
        ,lager_prozent
        ,SAISO
        ,posten_id
        ,ATTYP
        ,BISMT
        ,verkauf_sperre_fg
        ,ZZEK_NSALE
        ,yellowprint_fg
        ,tagesartikel_fg
        ,verhandler_id
        ,mutter_vk_id
        ,muki_block_vk_id
        ,muKi_block_kz_vk_id
        ,muki_block_wb_id
        ,muki_block_kz_wb_id
        ,muki_kz_vk_id
        ,muki_kz_wb_id
        ,inhalt_menge
        ,inhalt_menge_einh_id
        ,ipn_id
        ,gtin_id
        ,nettogew
        ,ek_marken_id
        ,int_art_id
    ) AS
    -- 21.06.2018, AP0030703, SPEC0038968, srom: Erweiterung yellowprint_fg
    -- 05.10.2021 INC3581872, richternic: Posten ID Anpassung
    -- NSR2941808 Modifizierung WWC-Views - Sushi Umsätze
    -- 22.09.2022, SPEC0170608, prescherad: Umstellung auf 8 stellige Artikelnummer DE
    -- 08.12.2022, SPEC0171511, prescherad: Aufnahme ek_marken_id
    -- 04.07.2023, SPEC0205969, prescherad: Ausfiltern Shop in Shop
    -- 20.11.2023, SPEC0224904, prescherad: Ausfiltern_Eloading
    -- 22.10.2024, SPEC0276971, prescherad: Ausfiltern WGI969006 für CZ und DE
    -- 19.11.2024, SPEC0281741, prescherad: WGI969006 Filter für CZ entfernen
    -- 08.01.2025, SPEC0285828, prescherad: Aufnahme int_art_id
    -- 27.01.2025, SPEC0291380, prescherad: Wert Artikel_1 Anzeige Anpassung	
	-- 14.02.2025, SPEC0282957, prescherad: Ausfiltern_Eloading Alle Mandanten außer DE
	
    SELECT v01.art_id AS art_id,
    v01.mandant_id,
    v02.mandant_kbez,
    CASE
        WHEN v01.artikelart_id IN ('MWST','ZWER')  THEN CONCAT(TO_CHAR('W'),SUBSTR(v01.kl_art_id,2,4))
        ELSE CASE
            -- Darstellung in KMO mit 8 Stellen
            WHEN v01.mandant_id <> 1 THEN to_CHAR(v01.kl_art_id, 'FM00000000') -- Darstellung in DE mit 8 Stellen
            WHEN v01.mandant_id = 1
            AND v01.art_id > 0 THEN TO_CHAR(v01.kl_art_id, 'FM00000000') -- DE Warengruppenwertartikel
            WHEN v01.mandant_id = 1
            AND v01.art_id < 0 THEN '00' || CAST(TRUNC(v01.art_id / 100) AS VARCHAR(10))
        END
    END AS MATNR_SAP,
    v01.mwst_id,
    v01.land_id,
    v01.region_id,
    v01.kl_art_id,
    v01.dat_von,
    v01.dat_bis,
    v01.loesch_id,
    v01.bio_fg,
    v01.wg_art_fg,
    v01.lead_id,
    v01.leist_id,
    v01.discount_id,
    v01.verpart_id,
    v01.esb_id,
    v01.aldi_id,
    v01.zek_id,
    v01.gewart_id,
    v01.eigenmarke_id,
    v01.mutter_wb_id,
    v01.mutter_vk_id AS PMATA,
    v01.display_id,
    v01.best_menge_einh_id AS BPRME,
    v01.loeschvorm_fg,
    v01.mhd_zeitraum,
    v01.basismenge_einh_id AS MEINS,
    v01.artikelart_id AS MTART,
    v01.faktor_nettoinhalt,
    v01.lager_prozent,
    v01.saison_id AS SAISO,
    CASE
        WHEN v01.mandant_id = 1 THEN v01.posten_id
        ELSE v01.posten_kz_sap
    END AS posten_id,
    v01.artikeltyp_id AS ATTYP,
    CASE
        WHEN v01.artikelart_id = 'MWST' THEN TO_CHAR(v01.kl_art_id_alt, 'FM0000')
        ELSE CASE
            -- Darstellung in KMO mit 8 Stellen
            WHEN v01.mandant_id <> 1 THEN TO_CHAR(v01.kl_art_id_alt, 'FM00000000') -- Darstellung in DE mit 8 Stellen
            WHEN v01.mandant_id = 1
            AND v01.kl_art_id_alt > 0 THEN TO_CHAR(v01.kl_art_id_alt, 'FM00000000') -- DE Warengruppenwertartikel
            WHEN v01.mandant_id = 1
            AND v01.kl_art_id_alt < 0 THEN '00' || CAST(v01.kl_art_id_alt AS VARCHAR(10))
        END
    END AS BISMT,
    v01.verkauf_sperre_fg,
    v01.kein_abverkauf_fg AS ZZEK_NSALE,
    CASE
        WHEN v01.yellowprint_fg = 1 THEN 'X'
        ELSE ''
    END AS yellowprint_fg,
    tagesartikel_fg,
    verhandler_id,
    mutter_vk_id,
    COALESCE(mutter_vk_id, v01.art_id) AS muki_block_vk_id,
    CASE
        WHEN(mutter_vk_id IS NULL) THEN 'W'
        ELSE 'M'
    END AS muki_block_kz_vk_id,
    COALESCE(mutter_wb_id, v01.art_id) AS muki_block_wb_id,
    CASE
        WHEN(mutter_wb_id IS NULL) THEN 'W'
        ELSE 'M'
    END AS muki_block_kz_wb_id,
    CASE
        WHEN(mutter_vk_id IS NULL) THEN 'W'
        WHEN(v01.art_id = mutter_vk_id) THEN 'M'
        ELSE 'K'
    END AS muki_kz_vk_id,
    CASE
        WHEN(mutter_wb_id IS NULL) THEN 'W'
        WHEN(v01.art_id = mutter_wb_id) THEN 'M'
        ELSE 'K'
    END AS muki_kz_wb_id,
    inhalt_menge,
    inhalt_menge_einh_id,
    v01.ipn_id, 
    v01.gtin_id,
    v01.nettogew,
    v01.ek_marken_id,
	v01.int_art_id		   
FROM dbp_view.v_art_1 v01
INNER JOIN dbp_view.v_mandant_1 v02 
ON v01.mandant_id = v02.mandant_id
AND dat_bis = '9999-12-31'
--Suhsi RO ausfiltern
INNER JOIN DBP_VIEW.V_art_wg_zu_per_1 V03
ON v01.Art_ID=v03.art_id
AND v01.mandant_id = v03.mandant_id
-- Wenn nicht Mandant_1 1,7 dann alles   
  AND (v03.MANDANT_ID NOT IN (1,7)
     -- Wenn  Mandant_1 1,7 dann  kein Sushi/Shop in Shop 
  OR (V03.MANDANT_ID IN (1,7) AND TO_VARCHAR(V03.wg_id,'FM000')|| TO_VARCHAR(V03.wug_id,'FM000') != '969006' )
   )
   -- Wenn nicht Mandant_1 7 dann alles   
  AND (v03.MANDANT_ID != 7
   -- Wenn  Mandant_1 7 dann kein Pfand 
  OR v03.MANDANT_ID = 7 AND TO_VARCHAR(v03.wg_id,'FM000') !='980')
--Ausfiltern Shop in Shop
AND v03.wg_id!=961
--Ausfiltern E-Loading alle Mandaten ungleich 1
AND (v03.MANDANT_ID NOT IN (2,3,4,5,6,7,8)
     --- wenn  Mandant_1 ungleich 1 dann  ohne E-loading 
      OR (v03.MANDANT_ID IN  (2,3,4,5,6,7,8) AND TO_VARCHAR(V03.wg_id,'FM000')|| TO_VARCHAR(v03.wug_id,'FM000') NOT IN ('969001','969002','969003','969004'))
)        
AND V03.arthiertyp_id = 2
AND V03.dat_bis = '9999-12-31';