CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FRISCHE_INVENTUR_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	ARTHIERTYP_ID,
	FRISCHE_WG_ID,
	KJMO,
	WRG_ID,
	ANF_BESTAND_VK_BRUTTO,
	END_BESTAND_VK_BRUTTO,
	WE_ZL_VK_BRUTTO,
	WE_DEZENTRAL_VK_BRUTTO,
	TKL_LIEFERUNG_VK_BRUTTO,
	AUSSAFT_PAUSCH_VK_BRUTTO,
	ABSCHRIFT_BRUTTO,
	WERBE_ABSCHRIFT_BRUTTO,
	ERL_MIND_BRUTTO,
	UMSATZ_BRUTTO,
	ANF_BESTAND_EK_NETTO,
	END_BESTAND_EK_NETTO,
	WE_DEZENTRAL_EK_NETTO,
	WE_ZL_EK_NETTO,
	WE_ZL_VK_NETTO,
	WE_SHOP_IN_SHOP_EK_NETTO,
	WE_SHOP_IN_SHOP_VK_NETTO,
	TKL_LIEFERUNG_EK_NETTO,
	UMSATZ_NETTO,
	ERL_MIND_NETTO,
	GEPLANT_FG,
	DURCHGEFUEHRT_FG,
	FRISCHE_FG
) AS

   -- FAKT Fruehinfo Frischeinventur pro Monat_2 - Warengruppe / Markt
   -- Vorberechnete Daten - Eigene WG (arthiertyp_2 2)
   -- 2009KW37 Initial Frischeinventur DE
   -- 2010KW28 Review + Erweiterung
   -- 2010KW47 Erweiterung Frische-Inventur_2-Kalender
   -- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id 															AS wup_id
 , v01.arthiertyp_id
 , v01.wg_id         															AS frische_wg_id
 , v01.kjmo
 , v01.wrg_id
 , v01.anf_bestand_vk_brutto
 , v01.end_bestand_vk_brutto
 , v01.we_zl_vk_brutto
 , v01.we_dezentral_vk_brutto
 , v01.tkl_lieferung_vk_brutto
 , CASE 
   WHEN wg_id = 1 THEN (v01.we_zl_vk_brutto * 0.006)
   ELSE 0 END::DECIMAL(18,2) 													AS aussaft_pausch_vk_brutto
 , v01.abschrift_brutto
 , v01.werbe_abschrift_brutto
 , v01.erl_mind_brutto
 , v01.umsatz_brutto
 , v01.anf_bestand_ek_netto
 , v01.end_bestand_ek_netto
 , v01.we_dezentral_ek_netto
 , v01.we_zl_ek_netto
 , v01.we_zl_vk_netto
 , v01.we_shop_in_shop_ek_netto
 , v01.we_shop_in_shop_vk_netto
 , v01.tkl_lieferung_ek_netto
 , v01.umsatz_netto
 , v01.erl_mind_netto
 , v01.geplant_fg
 , v01.durchgefuehrt_fg
 , v01.geplant_fg * 10 + v01.durchgefuehrt_fg 									AS frische_fg
 --  0  nicht geplant (und nicht durchgefuehrt)
 --  1 (nicht geplant und durchgefuehrt)
 -- 10 (geplant und) nicht durchgefuehrt
 -- 11 (geplant und) durchgefuehrt
FROM dbp_view.v_frische_inventur_2  v01

INNER JOIN dbp_view.v_wup_2 wup_2
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;