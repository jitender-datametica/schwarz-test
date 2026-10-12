CREATE OR REPLACE VIEW dbp_msi_view_ais_kmo.mv_art_1
(
  mandant_id
, art_id
, mwst_id
, region_id
, kl_art_id
, bio_fg
, kl_art_id_lang
, zek_id
, gewart_id
, best_menge_einh_id
, einh_id
, lactose_fg
, gluten_fg
, artikeltyp_id
, platz_relevant_fg
, verpart_id
, land_id
, eigenmarke_id
, posten_id
, temperatur_id
, lead_id
, mutter_wb_id
, muki_block_wb_id
, muki_kz_wb_id
, muki_block_kz_wb_id
, mutter_vk_id
, muki_block_vk_id
, muki_kz_vk_id
, muki_block_kz_vk_id
, wg_art_fg
, mhd_zeitraum
, lager_prozent
, eindeutig
, bitrex_fg
, blauer_engel_fg
, dachlogo_fg
, dolphin_safe_fg
, euro_blume_fg
, ecocert_fg
, eier_bh_fh_fg
, fair_trade_fg
, fos_fg
, fsc_fg
, fsc_verpackung_fg
, gap_fg
, gots_fg
, gots_organ_fg
, gots_proz_fg
, gu_fg
, gga_fg
, halal_fg
, kaninchen_bh_fg
, keimling_fg
, kein_stopf_rupf_fg
, msc_fg
, marktfrisch_fg
, kon_nat_kosmetik_fg
, natrue_fg
, naturland_fg
, ohne_gentechnik_fg
, oeko_tex_fg
, pefc_fg
, rainforest_fg
, rainf_kakao_fg
, rainf_kaffee_fg
, sustain_clean_fg
, tierschutz_gepr_fg
, aquagap_fg
, saison_id
, jugendschutz_id
, follow_fish_fg
, gepa_fg
, green_brands_fg
, gts_fg
, nature_and_respect_fg
, utz_certified_fg
, oeko_tex_std_100_plus_fg
, vier_pfoten_fg
, asc_fg
, bap_fg
, rspo_fg
, tagesartikel_fg
, div_fg
, fcp_fg
, vegan_fg
, vegetarisch_fg
, ean_id
, bio_fg_cz
, verhandler_id
, inhalt_menge
, inhalt_menge_einh_id
, ipn_id
, aldi_id
, display_id
, loesch_id

, bio_bw_fg
, bioland_fg
, duales_system_fg
, grs_fg
, ear_fg
, gema_fg
, blauer_engel_abbaubar_fg
, blauer_engel_altpapier_fg
, blauer_engel_kunststoff_fg
, blauer_engel_mehrweg_fg
, blauer_engel_wirkstoff_fg
, blauer_engel_wasser2_fg
, blauer_engel_solarbetrieb_fg
, blauer_engel_ungebleicht_fg
, dtb_einstieg_fg
, dtb_premium_fg
, freilandhaltung_fg
, neuland_fg
, tierwohl_kz
, tierwohl_fg
, kein_vk_fg
, qs_fg
, weidehaltung_fg
, posten_id_orig
, kaufempfehlung_fg
, neu_sort_fg
, posten_kz
, yellowprint_fg
, discount_id
, discountart_id 
, positionstyp_grp
, unsere_region_fg
, lets_bbq_fg
, verpackungseinsparung_fg
, cz_norm_fg
, kl_exclusiv_fg
, zum_fasten_fg
, kl_besonderes_fg
, stahlhaltung_fg
, stahlhaltung_plus_fg
, aussenklima_haltung_fg
, premium_haltung_fg
, machen_macht_unterschied_fg
, premium_fg
, qafp_fg
, qudal_fg
, regionale_lebensmittel_fg
, startup_fg
, togo_fg
, ohne_microplastik_fg
, grk_fg
, ppl_fg
, rpp_fg
, rsc_fg
, daa_fg
, okt_fg
, int_art_id
, ggn_fg
, oug_id
, wsi_fg
, vbe_fg
, fte_fg
, kni_fg
, nhi_fg
, vac_fg
, gbs_fg
, nat_bio_siegel_fg
, fair_sugar_prog_fg
, fair_cotton_prog_fg
, sustainable_cleaning_fg
, rainforest_alliance_tee_fg
, organic_cont_std_fg
, global_rec_std_fg
, global_rec_std_50_fg
, global_rec_std_55_fg
, global_rec_std_60_fg
, global_rec_std_65_fg
, global_rec_std_70_fg
, global_rec_std_75_fg
, global_rec_std_80_fg
, global_rec_std_85_fg
, global_rec_std_90_fg
, institut_heidger_fg
, cotton_mia_fg
, downpass_fg
, junghahnaufzucht_fg
, bord_bia_fg
, gss_fg
, ces_fg
, natulon_fg
, aklasa_fg
, i_know_fg
, czech_guild_std_fg
, czech_food_fg
, organic_cotton_fg
, sephora_fg
, green_globe_fg
, certificare_fg
, bg_state_std_fg
, ayvar_quality_fg
, creekstone_farm_fg
, milchprodukte_fg
, stara_planina_fg
, bgi_fg
, bgs_fg
, brot_qual_fg
, dti_fg
, mfd_fg
, consumer_choice_fg
, flash_fg
, cz_appetizer_fg
, children_appetizer_fg
, traditional_certified_product_fg
, seitenbehang_fg
, herkunftskennzeichen_de_fg
, leather_working_group_fg
, rainforest_banane_fg
, rainforest_schwarztee_fg
, rainforest_orange_fg
, vlabel_fg
, global_rec_std_filling_fg
, organic_con_std_blended_fg
, gots_made_with_organic_fg
, rcs_fg
, rcs_blended_fg
, rcs_filling_fg
, rcs_filling_blended_fg
, cyclos_fg
, rainforest_haselnuss_fg
, rmc_blue_fg
, rws_fg
, bio_haltung_fg
, vegan_kaufland_fg
, sustainable_rice_platform_fg
, acknowledged_recipe_fg
, sustainable_snap_buttons_fg
, thkz_stall_fg
, thkz_stall_platz_fg
, thkz_frischluftstall_fg
, thkz_auslauf_fg
, thkz_bio_fg
, mischform_haltung_fg
, eudr_fg
)
AS
-- 581 Redesign QBM: wg_art_fg hinzugefügt 24.10.2011/sschuecke
-- MR 9.1.2012 neue Spalte:mhd_zeitraum,lager_prozent,eindeutig
-- MR 22.02.2012 bio_fg zugeben
-- MR 28.02.2012 saison_id  zugeben, 29.02.2012 jugendschutz_fg 
-- Anfo #588643 Feld tagesartikel hinzugefügt; sschuecke 27.06.2014
-- Anfo #603385 Aufnahme weiterer Logos - sschuecke 06.03.2015
-- interne Anfo Aufnahme gtin_id durch Wegfall art_ean_zu nur für KMO - sschuecke 24.08.2015
-- AP0002974 Aufnahme , bio_fg_cz nur für KMO - sschuecke 12.04.2016
-- SPEC0008803 Erweiterung um Feld verhandler_id - sschuecke 19.09.2016
-- SPEC0030872 Erweiterung um Feld inhalt_menge + inhalt_menge_einh_id - sschuecke 11.12.2017
--SPEC0031068 Erweiterung mit zusatzlichen Nachhaltigkeitslogos
--SPEC0043042 - ipn_id hinzugefügt 
--NSR0446344 - aldi_id hinzugefügt 
/*SPEC0049888 - display_id, loesch_id hinzugefügt 5.02.19 dhoe0404
Nachhaltigkeitslogos hinzugefügt 8.02.19
*SPEC0049888 posten_id__orig  hinzugefügt 20.02.2018 dhoe0404*/
--SPEC0055794- neue Artikelkennzeichen hinzugefügt 
--SPEC0070447 - 19 neue Artikelkennzeichen columns added
--24.07.2020 lsvi0303 AP0055938, SPEC0083417 field einh_id added
--SPEC0079343 - 5 neue Artikelkennzeichen columns added
--SPEC0090812 - 2 neue Artikelkennzeichen columns added
--SPEC0104526 - ZSM article number
--SPEC0124293 - GGN attribute
--SPEC0127115 - OuG-Kennzeichen attribute
--SPEC0133022 - Sustainability logos
--SPEC0187442 - New Sustainability logos
--SPEC0222247 - neue Spalte Seitenbehang_FG
-- SPEC0244168 - neue Spalte Herkunftskennzeichen_de_fg
SELECT
v01.mandant_id,
v01.art_id,
v01.mwst_id,
v01.region_id,
v01.kl_art_id,
v01.bio_fg,
to_varchar(v01.kl_art_id, 'FM00000000') kl_art_id_lang,
v01.zek_id,
v01.gewart_id,
v01.best_menge_einh_id,
v01.einh_id,
v01.lactose_fg,
v01.gluten_fg,
v01.artikeltyp_id,
v01.platz_relevant_fg,
v01.verpart_id,
v01.land_id,
v01.eigenmarke_id,
CASE
WHEN v01.posten_id = '' OR posten_id IS NULL THEN '0'
ELSE v01.posten_id END AS posten_id,
v01.temperatur_id,
v01.lead_id,
v01.mutter_wb_id,
COALESCE(v01.mutter_wb_id, v01.art_id) AS muki_block_wb_id,
CASE
WHEN (v01.mutter_wb_id IS NULL) THEN 'W'
WHEN (v01.art_id = v01.mutter_wb_id) THEN 'M'
ELSE 'K' END AS muki_kz_wb_id,
CASE
WHEN (v01.mutter_wb_id IS NULL) THEN 'W'
ELSE 'M' END AS muki_block_kz_wb_id,
v01.mutter_vk_id,
COALESCE(v01.mutter_vk_id, art_id) AS muki_block_vk_id,
CASE
WHEN (v01.mutter_vk_id IS NULL) THEN 'W'
WHEN (v01.art_id = v01.mutter_vk_id) THEN 'M'
ELSE 'K' END AS muki_kz_vk_id,
CASE
WHEN (v01.mutter_vk_id IS NULL) THEN 'W'
ELSE 'M' END AS muki_block_kz_vk_id,
v01.wg_art_fg,
v01.mhd_zeitraum,
v01.lager_prozent,
CAST( art_id AS VARCHAR(15) )
 || TRIM(v02.mandant_kbez) AS eindeutig,
v01.bitrex_fg,
v01.blauer_engel_fg,
v01.dachlogo_fg,
v01.dolphin_safe_fg,
v01.euro_blume_fg,
v01.ecocert_fg,
v01.eier_bh_fh_fg,
v01.fair_trade_fg,
v01.fos_fg,
v01.fsc_fg,
v01.fsc_verpackung_fg,
v01.gap_fg,
v01.gots_fg,
v01.gots_organ_fg,
v01.gots_proz_fg,
v01.gu_fg,
v01.gga_fg,
v01.halal_fg,
v01.kaninchen_bh_fg,
v01.keimling_fg,
v01.kein_stopf_rupf_fg,
v01.msc_fg,
v01.marktfrisch_fg,
v01.kon_nat_kosmetik_fg,
v01.natrue_fg,
v01.naturland_fg,
v01.ohne_gentechnik_fg,
v01.oeko_tex_fg,
v01.pefc_fg,
v01.rainforest_fg,
v01.rainf_kakao_fg,
v01.rainf_kaffee_fg,
v01.sustain_clean_fg,
v01.tierschutz_gepr_fg,
v01.aquagap_fg,
v01.saison_id,
v01.jugendschutz_id,
v01.follow_fish_fg,
v01.gepa_fg,
v01.green_brands_fg,
v01.gts_fg,
v01.nature_and_respect_fg,
v01.utz_certified_fg,
v01.oeko_tex_std_100_plus_fg,
v01.vier_pfoten_fg,
v01.asc_fg,
v01.bap_fg,
v01.rspo_fg,
v01.tagesartikel_fg,
v01.div_fg,
v01.fcp_fg,
v01.vegan_fg,
v01.vegetarisch_fg,
v01.gtin_id AS ean_id,
v01.bio_fg_cz,
v01.verhandler_id,
v01.inhalt_menge,
v01.inhalt_menge_einh_id,
v01.ipn_id,
v01.aldi_id,
v01.display_id,
v01.loesch_id,
v01.bio_bw_fg,
v01.bioland_fg,
v01.duales_system_fg,
v01.grs_fg,
v01.ear_fg,
v01.gema_fg,
v01.blauer_engel_abbaubar_fg,
v01.blauer_engel_altpapier_fg,
v01.blauer_engel_kunststoff_fg,
v01.blauer_engel_mehrweg_fg,
v01.blauer_engel_wirkstoff_fg,
v01.blauer_engel_wasser2_fg,
v01.blauer_engel_solarbetrieb_fg,
v01.blauer_engel_ungebleicht_fg,
v01.dtb_einstieg_fg,
v01.dtb_premium_fg,
v01.freilandhaltung_fg,
v01.neuland_fg,
v01.tierwohl_kz,
v01.tierwohl_fg,
v01.kein_vk_fg,
v01.qs_fg,
v01.weidehaltung_fg,
v01.posten_id,
v01.kaufempfehlung_fg,
v01.neu_sort_fg,
v01.posten_kz_sap,
v01.yellowprint_fg,
v01.discount_id,
--NSR3712233
 CASE 
  WHEN v01.discountart_id IS NULL OR v01.discountart_id = '' 
  THEN 'N/A' ELSE v01.discountart_id 
  END AS discountart_id,
v01.positionstyp_grp_id,
v01.unsere_region_fg,
v01.lets_bbq_fg,
v01.verpackungseinsparung_fg,
v01.cz_norm_fg,
v01.kl_exclusiv_fg,
v01.zum_fasten_fg,
v01.kl_besonderes_fg,
v01.stahlhaltung_fg,
v01.stahlhaltung_plus_fg,
v01.aussenklima_haltung_fg,
v01.premium_haltung_fg,
v01.machen_macht_unterschied_fg,
v01.premium_fg,
v01.qafp_fg,
v01.qudal_fg,
v01.regionale_lebensmittel_fg,
v01.startup_fg,
v01.togo_fg,
v01.ohne_microplastik_fg,
v01.grk_fg,
v01.ppl_fg,
v01.rpp_fg,
v01.rsc_fg,
v01.daa_fg,
v01.okt_fg,
v01.int_art_id,
v01.ggn_fg,
v01.oug_id,
v01.wsi_fg,
v01.vbe_fg,
v01.fte_fg,
v01.kni_fg,
v01.nhi_fg,
v01.vac_fg,
v01.gbs_fg,
v01.nat_bio_siegel_fg,
v01.fair_sugar_prog_fg,
v01.fair_cotton_prog_fg,
v01.sustainable_cleaning_fg,
v01.rainforest_alliance_tee_fg,
v01.organic_cont_std_fg,
v01.global_rec_std_fg,
v01.global_rec_std_50_fg,
v01.global_rec_std_55_fg,
v01.global_rec_std_60_fg,
v01.global_rec_std_65_fg,
v01.global_rec_std_70_fg,
v01.global_rec_std_75_fg,
v01.global_rec_std_80_fg,
v01.global_rec_std_85_fg,
v01.global_rec_std_90_fg,
v01.institut_heidger_fg,
v01.cotton_mia_fg,
v01.downpass_fg,
v01.junghahnaufzucht_fg,
v01.bord_bia_fg,
v01.gss_fg,
v01.ces_fg,
v01.natulon_fg,
v01.aklasa_fg,
v01.i_know_fg,
v01.czech_guild_std_fg,
v01.czech_food_fg,
v01.organic_cotton_fg,
v01.sephora_fg,
v01.green_globe_fg,
v01.certificare_fg,
v01.bg_state_std_fg,
v01.ayvar_quality_fg,
v01.creekstone_farm_fg,
v01.milchprodukte_fg,
v01.stara_planina_fg,
v01.bgi_fg,
v01.bgs_fg,
v01.brot_qual_fg,
v01.dti_fg,
v01.mfd_fg,
v01.consumer_choice_fg,
v01.flash_fg,
v01.cz_appetizer_fg,
v01.children_appetizer_fg,
v01.traditional_certified_product_fg,
v01.seitenbehang_fg,
v01.herkunftskennzeichen_de_fg,
/* AP0221513/SPEC0256687 Erweiterung Nachhaltigkeitslogos / sschuecke 11.07.2024 */
v01.leather_working_group_fg,
v01.rainforest_banane_fg,
v01.rainforest_schwarztee_fg,
v01.rainforest_orange_fg,
v01.vlabel_fg,
v01.global_rec_std_filling_fg,
v01.organic_con_std_blended_fg,
v01.gots_made_with_organic_fg,
v01.rcs_fg,
v01.rcs_blended_fg,
v01.rcs_filling_fg,
v01.rcs_filling_blended_fg,
v01.cyclos_fg,
v01.rainforest_haselnuss_fg,
v01.rmc_blue_fg,
v01.rws_fg,
/* AP0231710/SPEC0284465 Erweiterung Nachhaltigkeitslogos / bauertob 03.01.2025 */
v01.bio_haltung_fg,
v01.vegan_kaufland_fg,
v01.sustainable_rice_platform_fg,
/* AP0273661/SPEC0321124 Erweiterung Nachhaltigkeitslogos / prescherad 07.11.2025 */
v01.acknowledged_recipe_fg,
v01.sustainable_snap_buttons_fg,
v01.thkz_stall_fg,
v01.thkz_stall_platz_fg,
v01.thkz_frischluftstall_fg,
v01.thkz_auslauf_fg,
v01.thkz_bio_fg,
v01.mischform_haltung_fg,
/*AP0268623/SPEC0309372 Erweiterung EUDR_FG / prescherad 12.11.2025 */
v01.eudr_fg
FROM dbp_view.v_art_1 v01

JOIN dbp_view.v_mandant_1 v02
ON v01.mandant_id = v02.mandant_id

WHERE v01.mandant_id <> 1;