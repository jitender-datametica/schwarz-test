-- MR 9.1.2012 neue Spalte:mhd_zeitraum,lager_prozent,eindeutig
 -- SPEC0133022 - Sustainability logos

-- Anfo #588643 Feld tagesartikel hinzugefügt; sschuecke 27.06.2014

-- SPEC0244168 - neue Spalte Herkunftskennzeichen_de_fg
 -- SPEC0043042 - ipn_id hinzugefügt

-- AP0002974 Aufnahme , bio_fg_cz nur für KMO - sschuecke 12.04.2016

-- SPEC0008803 Erweiterung um Feld verhandler_id - sschuecke 19.09.2016
 -- SPEC0124293 - GGN attribute

-- MR 28.02.2012 saison_id  zugeben, 29.02.2012 jugendschutz_fg

-- SPEC0070447 - 19 neue Artikelkennzeichen columns added

/* SPEC0049888 - display_id, loesch_id hinzugefügt 5.02.19 dhoe0404
Nachhaltigkeitslogos hinzugefügt 8.02.19
*SPEC0049888 posten_id__orig  hinzugefügt 20.02.2018 dhoe0404 */
-- 581 Redesign QBM: wg_art_fg hinzugefügt 24.10.2011/sschuecke

-- SPEC0079343 - 5 neue Artikelkennzeichen columns added
 -- SPEC0055794- neue Artikelkennzeichen hinzugefügt

-- SPEC0104526 - ZSM article number

-- SPEC0030872 Erweiterung um Feld inhalt_menge + inhalt_menge_einh_id - sschuecke 11.12.2017

-- SPEC0187442 - New Sustainability logos
 -- SPEC0222247 - neue Spalte Seitenbehang_FG

-- SPEC0127115 - OuG-Kennzeichen attribute

-- interne Anfo Aufnahme gtin_id durch Wegfall art_ean_zu nur für KMO - sschuecke 24.08.2015

-- 24.07.2020 lsvi0303 AP0055938, SPEC0083417 field einh_id added

-- SPEC0090812 - 2 neue Artikelkennzeichen columns added

-- Anfo #603385 Aufnahme weiterer Logos - sschuecke 06.03.2015

-- SPEC0031068 Erweiterung mit zusatzlichen Nachhaltigkeitslogos
 -- MR 22.02.2012 bio_fg zugeben

-- NSR0446344 - aldi_id hinzugefügt
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_2 (mandant_id,
art_id, mwst_id, region_id, kl_art_id, bio_fg, kl_art_id_lang, zek_id, gewart_id, best_menge_einh_id, einh_id,
lactose_fg, gluten_fg, artikeltyp_id, platz_relevant_fg, verpart_id, land_id, eigenmarke_id, posten_id, temperatur_id,
lead_id, mutter_wb_id, muki_block_wb_id, muki_kz_wb_id, muki_block_kz_wb_id, mutter_vk_id, muki_block_vk_id,
muki_kz_vk_id, muki_block_kz_vk_id, wg_art_fg, mhd_zeitraum, lager_prozent, eindeutig, bitrex_fg, blauer_engel_fg,
dachlogo_fg, dolphin_safe_fg, euro_blume_fg, ecocert_fg, eier_bh_fh_fg, fair_trade_fg, fos_fg, fsc_fg, fsc_verpackung_fg
, gap_fg, gots_fg, gots_organ_fg, gots_proz_fg, gu_fg, gga_fg, halal_fg, kaninchen_bh_fg, keimling_fg,
kein_stopf_rupf_fg, msc_fg, marktfrisch_fg, kon_nat_kosmetik_fg, natrue_fg, naturland_fg, ohne_gentechnik_fg,
oeko_tex_fg, pefc_fg, rainforest_fg, rainf_kakao_fg, rainf_kaffee_fg, sustain_clean_fg, tierschutz_gepr_fg, aquagap_fg,
saison_id, jugendschutz_id, follow_fish_fg, gepa_fg, green_brands_fg, gts_fg, nature_and_respect_fg, utz_certified_fg,
oeko_tex_std_100_plus_fg, vier_pfoten_fg, asc_fg, bap_fg, rspo_fg, tagesartikel_fg, div_fg, fcp_fg, vegan_fg,
vegetarisch_fg, ean_id, bio_fg_cz, verhandler_id, inhalt_menge, inhalt_menge_einh_id, ipn_id, aldi_id, display_id,
loesch_id, bio_bw_fg, bioland_fg, duales_system_fg, grs_fg, ear_fg, gema_fg, blauer_engel_abbaubar_fg,
blauer_engel_altpapier_fg, blauer_engel_kunststoff_fg, blauer_engel_mehrweg_fg, blauer_engel_wirkstoff_fg,
blauer_engel_wasser2_fg, blauer_engel_solarbetrieb_fg, blauer_engel_ungebleicht_fg, dtb_einstieg_fg, dtb_premium_fg,
freilandhaltung_fg, neuland_fg, tierwohl_kz, tierwohl_fg, kein_vk_fg, qs_fg, weidehaltung_fg, posten_id_orig,
kaufempfehlung_fg, neu_sort_fg, posten_kz, yellowprint_fg, discount_id, discountart_id, positionstyp_grp,
unsere_region_fg, lets_bbq_fg, verpackungseinsparung_fg, cz_norm_fg, kl_exclusiv_fg, zum_fasten_fg, kl_besonderes_fg,
stahlhaltung_fg, stahlhaltung_plus_fg, aussenklima_haltung_fg, premium_haltung_fg, machen_macht_unterschied_fg,
premium_fg, qafp_fg, qudal_fg, regionale_lebensmittel_fg, startup_fg, togo_fg, ohne_microplastik_fg, grk_fg, ppl_fg,
rpp_fg, rsc_fg, daa_fg, okt_fg, int_art_id, ggn_fg, oug_id, wsi_fg, vbe_fg, fte_fg, kni_fg, nhi_fg, vac_fg, gbs_fg,
nat_bio_siegel_fg, fair_sugar_prog_fg, fair_cotton_prog_fg, sustainable_cleaning_fg, rainforest_alliance_tee_fg,
organic_cont_std_fg, global_rec_std_fg, global_rec_std_50_fg, global_rec_std_55_fg, global_rec_std_60_fg,
global_rec_std_65_fg, global_rec_std_70_fg, global_rec_std_75_fg, global_rec_std_80_fg, global_rec_std_85_fg,
global_rec_std_90_fg, institut_heidger_fg, cotton_mia_fg, downpass_fg, junghahnaufzucht_fg, bord_bia_fg, gss_fg, ces_fg
, natulon_fg, aklasa_fg, i_know_fg, czech_guild_std_fg, czech_food_fg, organic_cotton_fg, sephora_fg, green_globe_fg,
certificare_fg, bg_state_std_fg, ayvar_quality_fg, creekstone_farm_fg, milchprodukte_fg, stara_planina_fg, bgi_fg,
bgs_fg, brot_qual_fg, dti_fg, mfd_fg, consumer_choice_fg, flash_fg, cz_appetizer_fg, children_appetizer_fg,
traditional_certified_product_fg, seitenbehang_fg, herkunftskennzeichen_de_fg, leather_working_group_fg,
rainforest_banane_fg, rainforest_schwarztee_fg, rainforest_orange_fg, vlabel_fg, global_rec_std_filling_fg,
organic_con_std_blended_fg, gots_made_with_organic_fg, rcs_fg, rcs_blended_fg, rcs_filling_fg, rcs_filling_blended_fg,
cyclos_fg, rainforest_haselnuss_fg, rmc_blue_fg, rws_fg, bio_haltung_fg, vegan_kaufland_fg, sustainable_rice_platform_fg
, acknowledged_recipe_fg, sustainable_snap_buttons_fg, thkz_stall_fg, thkz_stall_platz_fg, thkz_frischluftstall_fg,
thkz_auslauf_fg, thkz_bio_fg, mischform_haltung_fg, eudr_fg) AS -- NSR3712233
 SELECT V01.mandant_id,
 V01.art_id,
 V01.mwst_id,
 V01.region_id,
 V01.kl_art_id,
 V01.bio_fg,
 TRIM(CAST(V01.kl_art_id AS STRING FORMAT '00000000')) AS kl_art_id_lang,
 V01.zek_id,
 V01.gewart_id,
 V01.best_menge_einh_id,
 V01.einh_id,
 V01.lactose_fg,
 V01.gluten_fg,
 V01.artikeltyp_id,
 V01.platz_relevant_fg,
 V01.verpart_id,
 V01.land_id,
 V01.eigenmarke_id,
  CASE
  WHEN V01.posten_id IS NULL OR V01.posten_id = ''
  THEN '0'
  ELSE V01.posten_id
  END AS posten_id,
 V01.temperatur_id,
 V01.lead_id,
 V01.mutter_wb_id,
 COALESCE(V01.mutter_wb_id, V01.art_id) AS muki_block_wb_id,
  CASE
  WHEN V01.mutter_wb_id IS NULL
  THEN 'W'
  WHEN V01.art_id = V01.mutter_wb_id
  THEN 'M'
  ELSE 'K'
  END AS muki_kz_wb_id,
  CASE
  WHEN V01.mutter_wb_id IS NULL
  THEN 'W'
  ELSE 'M'
  END AS muki_block_kz_wb_id,
 V01.mutter_vk_id,
 COALESCE(V01.mutter_vk_id, V01.art_id) AS muki_block_vk_id,
  CASE
  WHEN V01.mutter_vk_id IS NULL
  THEN 'W'
  WHEN V01.art_id = V01.mutter_vk_id
  THEN 'M'
  ELSE 'K'
  END AS muki_kz_vk_id,
  CASE
  WHEN V01.mutter_vk_id IS NULL
  THEN 'W'
  ELSE 'M'
  END AS muki_block_kz_vk_id,
 V01.wg_art_fg,
 V01.mhd_zeitraum,
 V01.lager_prozent,
  CAST(V01.art_id AS STRING) || TRIM(V02.mandant_kbez) AS eindeutig,
 V01.bitrex_fg,
 V01.blauer_engel_fg,
 V01.dachlogo_fg,
 V01.dolphin_safe_fg,
 V01.euro_blume_fg,
 V01.ecocert_fg,
 V01.eier_bh_fh_fg,
 V01.fair_trade_fg,
 V01.fos_fg,
 V01.fsc_fg,
 V01.fsc_verpackung_fg,
 V01.gap_fg,
 V01.gots_fg,
 V01.gots_organ_fg,
 V01.gots_proz_fg,
 V01.gu_fg,
 V01.gga_fg,
 V01.halal_fg,
 V01.kaninchen_bh_fg,
 V01.keimling_fg,
 V01.kein_stopf_rupf_fg,
 V01.msc_fg,
 V01.marktfrisch_fg,
 V01.kon_nat_kosmetik_fg,
 V01.natrue_fg,
 V01.naturland_fg,
 V01.ohne_gentechnik_fg,
 V01.oeko_tex_fg,
 V01.pefc_fg,
 V01.rainforest_fg,
 V01.rainf_kakao_fg,
 V01.rainf_kaffee_fg,
 V01.sustain_clean_fg,
 V01.tierschutz_gepr_fg,
 V01.aquagap_fg,
 V01.saison_id,
 V01.jugendschutz_id,
 V01.follow_fish_fg,
 V01.gepa_fg,
 V01.green_brands_fg,
 V01.gts_fg,
 V01.nature_and_respect_fg,
 V01.utz_certified_fg,
 V01.oeko_tex_std_100_plus_fg,
 V01.vier_pfoten_fg,
 V01.asc_fg,
 V01.bap_fg,
 V01.rspo_fg,
 V01.tagesartikel_fg,
 V01.div_fg,
 V01.fcp_fg,
 V01.vegan_fg,
 V01.vegetarisch_fg,
 V01.gtin_id AS ean_id,
 V01.bio_fg_cz,
 V01.verhandler_id,
 V01.inhalt_menge,
 V01.inhalt_menge_einh_id,
 V01.ipn_id,
 V01.aldi_id,
 V01.display_id,
 V01.loesch_id,
 V01.bio_bw_fg,
 V01.bioland_fg,
 V01.duales_system_fg,
 V01.grs_fg,
 V01.ear_fg,
 V01.gema_fg,
 V01.blauer_engel_abbaubar_fg,
 V01.blauer_engel_altpapier_fg,
 V01.blauer_engel_kunststoff_fg,
 V01.blauer_engel_mehrweg_fg,
 V01.blauer_engel_wirkstoff_fg,
 V01.blauer_engel_wasser2_fg,
 V01.blauer_engel_solarbetrieb_fg,
 V01.blauer_engel_ungebleicht_fg,
 V01.dtb_einstieg_fg,
 V01.dtb_premium_fg,
 V01.freilandhaltung_fg,
 V01.neuland_fg,
 V01.tierwohl_kz,
 V01.tierwohl_fg,
 V01.kein_vk_fg,
 V01.qs_fg,
 V01.weidehaltung_fg,
 V01.posten_id AS posten_id_orig,
 V01.kaufempfehlung_fg,
 V01.neu_sort_fg,
 V01.posten_kz_sap AS posten_kz,
 V01.yellowprint_fg,
 V01.discount_id,
  CASE
  WHEN V01.discountart_id IS NULL OR V01.discountart_id = ''
  THEN 'N/A'
  ELSE V01.discountart_id
  END AS discountart_id,
 V01.positionstyp_grp_id AS positionstyp_grp,
 V01.unsere_region_fg,
 V01.lets_bbq_fg,
 V01.verpackungseinsparung_fg,
 V01.cz_norm_fg,
 V01.kl_exclusiv_fg,
 V01.zum_fasten_fg,
 V01.kl_besonderes_fg,
 V01.stahlhaltung_fg,
 V01.stahlhaltung_plus_fg,
 V01.aussenklima_haltung_fg,
 V01.premium_haltung_fg,
 V01.machen_macht_unterschied_fg,
 V01.premium_fg,
 V01.qafp_fg,
 V01.qudal_fg,
 V01.regionale_lebensmittel_fg,
 V01.startup_fg,
 V01.togo_fg,
 V01.ohne_microplastik_fg,
 V01.grk_fg,
 V01.ppl_fg,
 V01.rpp_fg,
 V01.rsc_fg,
 V01.daa_fg,
 V01.okt_fg,
 V01.int_art_id,
 V01.ggn_fg,
 V01.oug_id,
 V01.wsi_fg,
 V01.vbe_fg,
 V01.fte_fg,
 V01.kni_fg,
 V01.nhi_fg,
 V01.vac_fg,
 V01.gbs_fg,
 V01.nat_bio_siegel_fg,
 V01.fair_sugar_prog_fg,
 V01.fair_cotton_prog_fg,
 V01.sustainable_cleaning_fg,
 V01.rainforest_alliance_tee_fg,
 V01.organic_cont_std_fg,
 V01.global_rec_std_fg,
 V01.global_rec_std_50_fg,
 V01.global_rec_std_55_fg,
 V01.global_rec_std_60_fg,
 V01.global_rec_std_65_fg,
 V01.global_rec_std_70_fg,
 V01.global_rec_std_75_fg,
 V01.global_rec_std_80_fg,
 V01.global_rec_std_85_fg,
 V01.global_rec_std_90_fg,
 V01.institut_heidger_fg,
 V01.cotton_mia_fg,
 V01.downpass_fg,
 V01.junghahnaufzucht_fg,
 V01.bord_bia_fg,
 V01.gss_fg,
 V01.ces_fg,
 V01.natulon_fg,
 V01.aklasa_fg,
 V01.i_know_fg,
 V01.czech_guild_std_fg,
 V01.czech_food_fg,
 V01.organic_cotton_fg,
 V01.sephora_fg,
 V01.green_globe_fg,
 V01.certificare_fg,
 V01.bg_state_std_fg,
 V01.ayvar_quality_fg,
 V01.creekstone_farm_fg,
 V01.milchprodukte_fg,
 V01.stara_planina_fg,
 V01.bgi_fg,
 V01.bgs_fg,
 V01.brot_qual_fg,
 V01.dti_fg,
 V01.mfd_fg,
 V01.consumer_choice_fg,
 V01.flash_fg,
 V01.cz_appetizer_fg,
 V01.children_appetizer_fg,
 V01.traditional_certified_product_fg,
 V01.seitenbehang_fg,
 V01.herkunftskennzeichen_de_fg,
 /* AP0221513/SPEC0256687 Erweiterung Nachhaltigkeitslogos / sschuecke 11.07.2024 */ V01.leather_working_group_fg,
 V01.rainforest_banane_fg,
 V01.rainforest_schwarztee_fg,
 V01.rainforest_orange_fg,
 V01.vlabel_fg,
 V01.global_rec_std_filling_fg,
 V01.organic_con_std_blended_fg,
 V01.gots_made_with_organic_fg,
 V01.rcs_fg,
 V01.rcs_blended_fg,
 V01.rcs_filling_fg,
 V01.rcs_filling_blended_fg,
 V01.cyclos_fg,
 V01.rainforest_haselnuss_fg,
 V01.rmc_blue_fg,
 V01.rws_fg,
 /* AP0231710/SPEC0284465 Erweiterung Nachhaltigkeitslogos / bauertob 03.01.2025 */ V01.bio_haltung_fg,
 V01.vegan_kaufland_fg,
 V01.sustainable_rice_platform_fg,
 /* AP0273661/SPEC0321124 Erweiterung Nachhaltigkeitslogos / prescherad 07.11.2025 */ V01.acknowledged_recipe_fg,
 V01.sustainable_snap_buttons_fg,
 V01.thkz_stall_fg,
 V01.thkz_stall_platz_fg,
 V01.thkz_frischluftstall_fg,
 V01.thkz_auslauf_fg,
 V01.thkz_bio_fg,
 V01.mischform_haltung_fg,
 /* AP0268623/SPEC0309372 Erweiterung EUDR_FG / prescherad 12.11.2025 */ V01.eudr_fg
FROM kfl_production_dbp_view.v_art_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V02 ON V01.mandant_id = V02.mandant_id
WHERE V01.mandant_id <> 1;