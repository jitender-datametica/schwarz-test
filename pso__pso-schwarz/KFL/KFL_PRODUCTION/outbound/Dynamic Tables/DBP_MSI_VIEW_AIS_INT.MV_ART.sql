CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_art
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
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
  WHEN V01.eigenmarke_id <> ''
  THEN 1
  ELSE 2
  END AS eigenmarke_agg,
  CASE
  WHEN V01.eigenmarke_id = ''
  THEN 1
  ELSE 2
  END AS gfk_marke_id,
  CASE
  WHEN CASE
    WHEN V01.eigenmarke_id = ''
    THEN 1
    ELSE 2
    END = 1
  THEN 'FMCG Marke'
  ELSE 'FMCG Handelsmarke'
  END AS gfk_marke_bez,
  CASE
  WHEN V01.posten_id IS NULL OR V01.posten_id = ''
  THEN '0'
  WHEN V01.posten_id IN ('PN', 'PF')
  THEN 'PN'
  ELSE ' '
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
 COALESCE(V01.mutter_1_n_id, V01.art_id) AS one_n_block_id,
  CASE
  WHEN V01.mutter_1_n_id = V01.art_id
  THEN '1:N'
  ELSE '1:1'
  END AS one_n_kz_art_vk,
  CASE
  WHEN V01.mutter_1_n_id IS NULL
  THEN '1:1'
  ELSE '1:N'
  END AS one_n_kz_block,
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
 V01.faktor_nettoinhalt,
 ROUND(CAST(CASE
    WHEN V01.einh_id = 'ML'
    THEN V01.faktor_nettoinhalt * 0.001
    WHEN V01.einh_id = 'CL'
    THEN V01.faktor_nettoinhalt * 0.01
    WHEN V01.einh_id = 'DL'
    THEN V01.faktor_nettoinhalt * 0.1
    ELSE V01.faktor_nettoinhalt
    END AS NUMERIC), 4) AS faktor_nettoinhalt_liter,
  CASE
  WHEN V01.ipn_id IS NULL
  THEN 0
  ELSE CAST(V01.ipn_id AS BIGNUMERIC)
  END AS ipn_id,
 V01.aldi_id,
  CASE
  WHEN V01.mandant_id > 1 AND V01.artikeltyp_id = 12
  THEN V01.artikeltyp_id
  WHEN V01.mandant_id > 1 AND V01.artikeltyp_id <> 12
  THEN 0
  ELSE V01.display_id
  END AS display_id,
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
 V01.demeter_fg,
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
 V01.dat_von,
 V01.dat_bis,
 V01.sustain_concat,
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
 V01.heumilch_fg,
 V01.fairmast_fg,
 V01.kat_kontrolliert_fg,
 V01.kdk_kalb_fg,
 V01.tuv_fg,
 V01.laenderherz_5d_fg,
 V01.ohne_gentechnik_nicht_vlog_fg,
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
 V01.leather_working_group_fg,
 V01.silphie_fg,
 V01.rainforest_banane_fg,
 V01.rainforest_schwarztee_fg,
 V01.rainforest_orange_fg,
 V01.vlabel_fg,
 V01.qmilch_plus_fg,
 V01.global_rec_std_filling_fg,
 V01.organic_con_std_blended_fg,
 V01.gots_made_with_organic_fg,
 V01.rcs_fg,
 V01.rcs_blended_fg,
 -V01.rcs_filling_fg AS rcs_filling_fg,
 V01.rcs_filling_blended_fg,
 V01.made_in_germany_fg,
 V01.cyclos_fg,
 V01.rainforest_haselnuss_fg,
 V01.rmc_blue_fg,
 V01.rws_fg,
 V01.bio_haltung_fg,
 V01.vegan_kaufland_fg,
 V01.sustainable_rice_platform_fg,
 V01.dat_angelegt,
 V01.zek_vat_id,
  CASE
  WHEN V01.mandant_id = 1
  THEN V01.zek_id
  ELSE COALESCE(V01.zek_vat_id, V01.zek_id)
  END AS zek_int_id,
 V01.menge_haus,
 V01.kein_abverkauf_fg,
 V01.smgrp,
 V01.verkauf_sperre_fg,
 V01.tage_uebernachtungen,
 V01.diaet_fg,
 V01.acknowledged_recipe_fg,
 V01.sustainable_snap_buttons_fg,
 V01.thkz_stall_fg,
 V01.thkz_stall_platz_fg,
 V01.thkz_frischluftstall_fg,
 V01.thkz_auslauf_fg,
 V01.thkz_bio_fg,
 V01.mischform_haltung_fg,
 V01.eudr_fg
FROM kfl_production_dbp_data.art AS V01
 INNER JOIN kfl_production_dbp_data.mandant AS V02 ON V01.mandant_id = V02.mandant_id;