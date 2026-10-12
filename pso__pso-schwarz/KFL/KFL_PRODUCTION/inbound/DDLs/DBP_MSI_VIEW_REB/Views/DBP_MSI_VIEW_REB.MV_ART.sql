CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ART
-- SPEC0125775 - kl_art_id_lang added
(
art_id
, mandant_id
, mwst_id
, land_id
, region_id
, kl_art_id
, kl_art_id_lang
, dat_von
, dat_bis
, loesch_id
, best_menge_einh_id
, bio_fg
, wg_art_fg
, posten_id
, lead_id
, leist_id
, discount_id
, verpart_id
, esb_id
, aldi_id
, zek_id
, gewart_id
, eigenmarke_id
, mutter_vk_id
, mutter_wb_id
, display_id
, mhd_zeitraum
, muki_block_wb_id
, muki_kz_wb_id
, muki_block_kz_wb_id
, muki_block_vk_id
, muki_kz_vk_id
, muki_block_kz_vk_id
, temperatur_id
, aquagap_fg
, duales_system_fg
, grs_fg
, ear_fg
, gema_fg
, lactose_fg
, gluten_fg
, diaet_fg
, verkauf_sperre_fg
, einh_id
, einh_id_neu
, platz_relevant_fg
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
, gap_fg
, gots_fg
, halal_fg
, kaninchen_bh_fg
, keimling_fg
, kein_stopf_rupf_fg
, msc_fg
, kon_nat_kosmetik_fg
, natrue_fg
, naturland_fg
, ohne_gentechnik_fg
, oeko_tex_fg
, pefc_fg
, rainforest_fg
, sustain_clean_fg
, tierschutz_gepr_fg
, follow_fish_fg
, gepa_fg
, green_brands_fg
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
, tierwohl_kz
, psf_id
, menge_haus
, smgrp
, posten_id_orig
, verhandler_id
)
AS
   SELECT
   art_id, mandant_id, mwst_id, land_id, region_id, kl_art_id, to_varchar(kl_art_id, 'FM00000000') kl_art_id_lang, dat_von, dat_bis, loesch_id, best_menge_einh_id, CASE WHEN bio_fg = 1         THEN 'X' ELSE ' ' END AS bio_fg, wg_art_fg, CASE WHEN posten_id IN ('PN', 'PF')    THEN CAST('PN' AS CHAR(2)) ELSE CAST(' ' AS CHAR(2)) END AS posten_id, lead_id, CASE WHEN leist_id = ''          THEN 'keine' ELSE leist_id END AS leist_id, discount_id, verpart_id, CASE WHEN esb_id IS NULL       THEN ' ' ELSE esb_id END AS esb_id, aldi_id, zek_id, gewart_id, eigenmarke_id, mutter_vk_id, mutter_wb_id, display_id, mhd_zeitraum, COALESCE(mutter_wb_id,art_id) AS muki_block_wb_id, CASE  WHEN(mutter_wb_id IS NULL)   THEN 'W' WHEN(art_id=mutter_wb_id) THEN 'M' ELSE 'K' END AS MuKi_kz_wb_id, CASE  WHEN(mutter_wb_id IS NULL)   THEN 'W' ELSE 'M' END AS MuKi_block_kz_wb_id, COALESCE(mutter_vk_id,art_id) AS muki_block_vk_id, CASE  WHEN(mutter_vk_id IS NULL)    THEN 'W'  WHEN(art_id=mutter_vk_id) THEN 'M' ELSE 'K' END AS MuKi_kz_vk_id, CASE  WHEN(mutter_vk_id IS NULL)    THEN 'W' ELSE 'M' END AS MuKi_block_kz_vk_id, temperatur_id, CASE WHEN aquagap_fg = 1       THEN 'X' ELSE ' '  END AS aquagap_fg, CASE WHEN duales_system_fg = 1     THEN 'X' ELSE ' '  END AS duales_system_fg, CASE WHEN grs_fg = 1          THEN 'X' ELSE ' '  END AS grs_fg, CASE WHEN ear_fg = 1         THEN 'X' ELSE ' '  END AS ear_fg, CASE WHEN gema_fg  = 1        THEN 'X' ELSE ' '  END AS gema_fg, CASE WHEN lactose_fg = 1        THEN 'X' ELSE ' '  END AS lactose_fg, CASE WHEN gluten_fg = 1        THEN 'X' ELSE ' '  END AS gluten_fg, CASE WHEN diaet_fg = 1         THEN 'X' ELSE ' '  END AS diaet_fg, CASE WHEN verkauf_sperre_fg = 1     THEN 'X' ELSE ' '  END AS verkauf_sperre_fg, einh_id, CASE WHEN einh_id = 'ML'        THEN 'L'
   WHEN einh_id = 'CL'           THEN 'L'
   WHEN einh_id = 'DL'           THEN 'L'
   WHEN einh_id = 'L'            THEN 'L'
   ELSE ' ' END AS einh_id_neu, CASE WHEN platz_relevant_fg = '0'     THEN ' '  ELSE 'X' END AS platz_relevant_fg, CASE WHEN bitrex_fg= 1         THEN 'X' ELSE ' '  END AS bitrex_fg, CASE WHEN blauer_engel_fg= 1      THEN 'X' ELSE ' '  END AS blauer_engel_fg, CASE WHEN dachlogo_fg= 1       THEN 'X' ELSE ' '  END AS dachlogo_fg, CASE WHEN dolphin_safe_fg= 1      THEN 'X' ELSE ' '  END AS dolphin_safe_fg, CASE WHEN euro_blume_fg= 1      THEN 'X' ELSE ' '  END AS euro_blume_fg, CASE WHEN ecocert_fg= 1        THEN 'X' ELSE ' '  END AS ecocert_fg, CASE WHEN eier_bh_fh_fg= 1       THEN 'X' ELSE ' '  END AS eier_bh_fh_fg, CASE WHEN fair_trade_fg= 1       THEN 'X' ELSE ' '  END AS fair_trade_fg, CASE WHEN fos_fg= 1          THEN 'X' ELSE ' '  END AS fos_fg, CASE WHEN fsc_fg= 1          THEN 'X' ELSE ' '  END AS fsc_fg, CASE WHEN gap_fg= 1          THEN 'X' ELSE ' '  END AS gap_fg, CASE WHEN gots_fg= 1         THEN 'X' ELSE ' '  END AS gots_fg, CASE WHEN halal_fg= 1         THEN 'X' ELSE ' '  END AS halal_fg, CASE WHEN kaninchen_bh_fg= 1      THEN 'X' ELSE ' '  END AS kaninchen_bh_fg, CASE WHEN keimling_fg= 1        THEN 'X' ELSE ' '  END AS keimling_fg, CASE WHEN kein_stopf_rupf_fg= 1     THEN 'X' ELSE ' '  END AS kein_stopf_rupf_fg, CASE WHEN msc_fg= 1         THEN 'X' ELSE ' '  END AS msc_fg, CASE WHEN kon_nat_kosmetik_fg= 1    THEN 'X' ELSE ' '  END AS kon_nat_kosmetik_fg, CASE WHEN natrue_fg= 1         THEN 'X' ELSE ' '  END AS natrue_fg, CASE WHEN naturland_fg= 1       THEN 'X' ELSE ' '  END AS naturland_fg, CASE WHEN ohne_gentechnik_fg= 1     THEN 'X' ELSE ' '  END AS ohne_gentechnik_fg, CASE WHEN oeko_tex_fg= 1       THEN 'X' ELSE ' '  END AS oeko_tex_fg, CASE WHEN pefc_fg= 1         THEN 'X' ELSE ' '  END AS pefc_fg, CASE WHEN rainforest_fg= 1       THEN 'X' ELSE ' '  END AS rainforest_fg, CASE WHEN sustain_clean_fg= 1      THEN 'X' ELSE ' '  END AS sustain_clean_fg, CASE WHEN tierschutz_gepr_fg= 1     THEN 'X' ELSE ' '  END AS tierschutz_gepr_fg, CASE WHEN follow_fish_fg = 1       THEN 'X' ELSE ' '  END AS follow_fish_fg, CASE WHEN gepa_fg = 1         THEN 'X' ELSE ' '  END AS gepa_fg, CASE WHEN green_brands_fg = 1      THEN 'X' ELSE ' '  END AS green_brands_fg, CASE WHEN nature_and_respect_fg = 1   THEN 'X' ELSE ' '  END AS nature_and_respect_fg, CASE WHEN utz_certified_fg = 1      THEN 'X' ELSE ' '  END AS utz_certified_fg, CASE WHEN oeko_tex_std_100_plus_fg = 1 THEN 'X' ELSE ' '  END AS oeko_tex_std_100_plus_fg, CASE WHEN vier_pfoten_fg = 1      THEN 'X' ELSE ' '  END AS vier_pfoten_fg, CASE WHEN asc_fg = 1         THEN 'X' ELSE ' '  END AS asc_fg, CASE WHEN bap_fg = 1         THEN 'X' ELSE ' '  END AS bap_fg, CASE WHEN rspo_fg = 1         THEN 'X' ELSE ' '  END AS rspo_fg, CASE WHEN tagesartikel_fg = 1      THEN 'X' ELSE ' '  END AS tagesartikel_fg, CASE WHEN div_fg = 1          THEN 'X' ELSE ' '  END AS div_fg, CASE WHEN fcp_fg = 1         THEN 'X' ELSE ' '  END AS fcp_fg, CASE WHEN vegan_fg = 1        THEN 'X' ELSE ' '  END AS vegan_fg, CASE WHEN vegetarisch_fg = 1      THEN 'X' ELSE ' '  END AS vegetarisch_fg, CASE WHEN tierwohl_kz = 'Sw'      THEN 'Schwein'
   WHEN tierwohl_kz = 'Pu'       THEN 'Pute'
   WHEN tierwohl_kz = 'Ha'       THEN 'HÃýhnchen'
   WHEN tierwohl_kz = 'Rd'       THEN 'Rind'
   WHEN tierwohl_kz IS NULL               THEN ' '
   ELSE 'Sonstiges'  END AS tierwohl_kz, psf_id, menge_haus, smgrp, posten_id, verhandler_id
   FROM dbp_view.v_art
   WHERE mandant_id=1
;