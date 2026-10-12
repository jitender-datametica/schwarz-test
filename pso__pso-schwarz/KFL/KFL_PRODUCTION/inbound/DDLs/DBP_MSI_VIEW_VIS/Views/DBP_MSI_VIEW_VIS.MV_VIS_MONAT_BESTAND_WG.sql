CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_BESTAND_WG(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	KJMO,
	GJ,
	ARTHIERTYP_ID,
	ABT_ID,
	WG_ID,
	WRG_ID,
	RELEVANT_FG,
	MENGE_LGBEST_ERP_FREI_BME,
	MENGE_LGBEST_ERP_QUAL_BME,
	BETRAG_VK_NETTO_FREI_BME,
	BETRAG_VK_NETTO_QUAL_BME,
	BETRAG_VK_BRUTTO_FREI_BME,
	BETRAG_VK_BRUTTO_QUAL_BME,
	MENGE_LGBEST_ERP_FREI_BME_KUM,
	MENGE_LGBEST_ERP_QUAL_BME_KUM,
	BETRAG_VK_NETTO_FREI_BME_KUM,
	BETRAG_VK_NETTO_QUAL_BME_KUM,
	BETRAG_VK_BRUTTO_FREI_BME_KUM,
	BETRAG_VK_BRUTTO_QUAL_BME_KUM
) AS
 
	-- FAKT-AGGREGAT Bestand pro Monat - Markt/Abt/WG
	-- 2012KW46 Initial
	-- 2022-10 NO changes! 
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
 
SELECT
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id 																AS wup_id
 , v01.kjmo
 , v01.gj
 , v01.arthiertyp_id
 , v01.abt_id
 , v01.wg_id
 , v01.wrg_id 
 , v01.relevant_fg
 , v01.menge_lgbest_erp_frei_bme
 , v01.menge_lgbest_erp_qual_bme
 , v01.betrag_vk_netto_frei_bme
 , v01.betrag_vk_netto_qual_bme
 , v01.betrag_vk_brutto_frei_bme
 , v01.betrag_vk_brutto_qual_bme
 , v01.menge_lgbest_erp_frei_bme_kum
 , v01.menge_lgbest_erp_qual_bme_kum
 , v01.betrag_vk_netto_frei_bme_kum
 , v01.betrag_vk_netto_qual_bme_kum
 , v01.betrag_vk_brutto_frei_bme_kum
 , v01.betrag_vk_brutto_qual_bme_kum
FROM dbp_msi_v_view.v_vis_monat_bestand_wg  v01

INNER JOIN dbp_view.v_wup wup
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;