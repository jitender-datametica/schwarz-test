CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_BESTAND_RW_WG_1 (
   MANDANT_ID
 , NB_ID
 , WUP_ID
 , BEZUGSWEG_ID
 , RELEVANT_FG
 , ARTHIERTYP_ID
 , ABT_ID
 , WG_ID
 , GJ
 , KJMO
 , KJWO
 , DAT
 , WRG_ID
 , MENGE_LGBEST_ERP_FREI_BME
 , MENGE_LGBEST_ERP_QUAL_BME
 , BETRAG_VK_NETTO_FREI_BME
 , BETRAG_VK_NETTO_QUAL_BME
 , BETRAG_VK_BRUTTO_FREI_BME
 , BETRAG_VK_BRUTTO_QUAL_BME
 , BETRAG_MO_ANF_VK_NTTO_FREI_BME
 , BETRAG_MO_ANF_VK_NTTO_QUAL_BME
 , BETRAG_MO_ANF_VK_BTTO_FREI_BME
 , BETRAG_MO_ANF_VK_BTTO_QUAL_BME
 , BETRAG_D_VMO_VK_NTTO_FREI_BME
 , BETRAG_D_VMO_VK_NTTO_QUAL_BME
 , BETRAG_D_VMO_VK_BTTO_FREI_BME
 , BETRAG_D_VMO_VK_BTTO_QUAL_BME
) AS 
 
	-- FAKT-AGGREGAT Bestand für Reichweiten pro Tag_1 - Markt/Abt_1/WG
	-- 2022-10-07 NO changes
	-- 2024-06-20 beisswenger : Filialumgliederung
 
SELECT 
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id 															AS wup_id
 , v01.bezugsweg_id
 , v01.relevant_fg
 , v01.arthiertyp_id
 , v01.abt_id
 , v01.wg_id
 , v01.gj
 , v01.kjmo
 , v01.kjwo
 , v01.dat
 , v01.wrg_id
 , v01.menge_lgbest_erp_frei_bme
 , v01.menge_lgbest_erp_qual_bme
 , v01.betrag_vk_netto_frei_bme
 , v01.betrag_vk_netto_qual_bme
 , v01.betrag_vk_brutto_frei_bme
 , v01.betrag_vk_brutto_qual_bme
 , v01.betrag_mo_anf_vk_ntto_frei_bme
 , v01.betrag_mo_anf_vk_ntto_qual_bme
 , v01.betrag_mo_anf_vk_btto_frei_bme
 , v01.betrag_mo_anf_vk_btto_qual_bme
 , v01.betrag_d_vmo_vk_ntto_frei_bme
 , v01.betrag_d_vmo_vk_ntto_qual_bme
 , v01.betrag_d_vmo_vk_btto_frei_bme
 , v01.betrag_d_vmo_vk_btto_qual_bme
FROM dbp_msi_v_view.v_vis_tag_bestand_wg_1 v01

INNER JOIN dbp_view.v_wup_1 wup_1
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id

;