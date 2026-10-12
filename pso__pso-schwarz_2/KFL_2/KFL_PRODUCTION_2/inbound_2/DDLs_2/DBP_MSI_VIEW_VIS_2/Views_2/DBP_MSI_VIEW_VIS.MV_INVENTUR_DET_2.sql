CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_INVENTUR_DET_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	DAT_BUCH,
	DAT_LETZT_ZAEHL,
	NULLZAEHL_FG,
	ART_ID,
	WRG_ID,
	ERFSNGS_MENGE_EINH_ID,
	MENGE_ERF,
	MENGE_GEZAEHLT,
	MENGE_GEBUCHT,
	MENGE_DIFFERENZ,
	WERT_VK_BRUTTO,
	VK_INVENTUR_DIFF_BRUTTO,
	VK_BRUTTO,
	BESTAND_KORREKTUR_BRUTTO,
	WERT_VK_NETTO,
	VK_INVENTUR_DIFF_NETTO,
	VK_NETTO,
	BESTAND_KORREKTUR_NETTO,
	WERT_DIFF_INV,
	WERT_VK_EXTERN,
	MENGE_BUCH,
	MENGE_ZAEHL
) AS

	-- FAKT : Inventuren (SAP iseg) pro Filiale, Artikel_2, Tag_2
    -- Anbindung ohne Beleg- und Positionsdaten
    -- 20150225 : Initial, Thema Bestandskorrekturen
    -- 19.04.2016, srom: Umstellen von vk_inventur_diff_brutto (vkmzl) auf vk_wert_brutto (vkwrt), Mail von A. Wolter / D. Dorn (19.04.2016)
    -- 19.04.2016, srom: Umstellen von vk_inventur_diff_netto (vknzl) auf vk_wert_netto (vkwra), Mail von A. Wolter / D. Dorn (19.04.2016)
    -- 28.05.2020, snik: Removed default value 'EUR' for WRG_2 and added default values per country_2 from mandant_2
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
	 
SELECT 
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id 														AS wup_id
 , v01.dat_buch
 , v01.dat_letzt_zaehl
 , v01.nullzaehl_fg
 , v01.art_id
 , v02.default_wrg 															AS wrg_id
 , v01.erfsngs_menge_einh_id
 , v01.menge_erf -- not used
 , v01.menge_zaehl 															AS menge_gezaehlt
 , v01.menge_buch 															AS menge_gebucht
 , (menge_gezaehlt - menge_gebucht) 										AS menge_differenz
 , v01.wert_vk_brutto
 , v01.vk_inventur_diff_brutto
 , ABS(
     v01.wert_vk_brutto / 	CASE
						WHEN menge_differenz = 0 THEN NULL
						ELSE menge_differenz
						END
   ) 																		AS vk_brutto
 , CASE
   WHEN menge_differenz < 0 THEN wert_vk_brutto * -1
   ELSE wert_vk_brutto
   END 																		AS bestand_korrektur_brutto
 , v01.wert_vk_netto
 , vk_inventur_diff_netto,
   ABS(
           v01.wert_vk_netto / 	CASE
								WHEN menge_differenz = 0 THEN NULL
								ELSE menge_differenz
								END
   ) 																		AS vk_netto
 , CASE
   WHEN menge_differenz < 0 THEN wert_vk_netto * -1
   ELSE wert_vk_netto
   END 																		AS bestand_korrektur_netto
 , v01.wert_diff_inv -- not used
 , v01.wert_vk_extern -- not used
 , v01.menge_buch
 , v01.menge_zaehl
FROM dbp_view.v_inventur_det_2 v01

INNER JOIN dbp_data.mandant_2 v02
ON v01.mandant_id = v02.mandant_id

INNER JOIN dbp_view.v_wup_2 wup_2
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;