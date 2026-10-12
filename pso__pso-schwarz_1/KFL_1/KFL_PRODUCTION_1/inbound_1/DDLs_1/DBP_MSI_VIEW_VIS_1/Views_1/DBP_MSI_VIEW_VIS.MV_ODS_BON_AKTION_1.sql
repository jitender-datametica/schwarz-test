CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_BON_AKTION_1 (
  MANDANT_ID,
	NB_ID,
	WUP_ID,
	AKTION_KJWO_VON,
	AKTION_ID,
	AKTION_THEMA_ID,
	AKTION_VON,
	AKTION_BIS,
	ART_MUTTER_WB_ID,
	ART_MUTTER_WB_NR,
	ART_MUTTER_WB_BEZ,
	ART_MUTTER_WB_FG,
	ART_ID,
	ART_NR,
	ART_BEZ,
	ART_DISPLAY_ID,
	ART_BASISMENGE_EINH_ID,
	ART_VERPART_ID,
	BON_DAT,
	EINH_ID,
	MENGE,
	UMSATZ_BRUTTO,
	UMSATZ_NETTO,
	START_BON_ZEILE,
	BON_ERSTER_VERKAUF,
	BON_LETZTER_VERKAUF
) AS
   -- FAKT : Sonderauswertung Bondaten (heute) fuer Artikel_1 in Aktion_1
   -- Datenbasis ODS bon_kopf, ODS bon_verkauf + aktion_1 + aktion_art_wup + art_1
   -- 2018.0326 : Initial
   -- 2024-10-16 muellerpatri : Filter auf wg_id <> 961 hinzugefügt [SPEC0276475]

SELECT
     sub01.mandant_id
     , sub01.nb_id
     , sub01.wup_id
     , sub01.kjwo_von AS aktion_kjwo_von, sub01.aktion_id
     , sub01.aktion_thema_id, MIN(sub01.dat_von) OVER (PARTITION BY sub01.mandant_id, sub01.nb_id
     , sub01.wup_id
     , sub01.aktion_id
     , sub01.art_id ORDER BY sub01.mandant_id
     , sub01.nb_id
     , sub01.wup_id
     , sub01.aktion_id
     , sub01.art_id
     , ods.start_bon_zeile) aktion_von
     , MAX(sub01.dat_bis) OVER (PARTITION BY sub01.mandant_id, sub01.nb_id, sub01.wup_id, sub01.aktion_id, sub01.art_id ORDER BY sub01.mandant_id, sub01.nb_id, sub01.wup_id, sub01.aktion_id, sub01.art_id, ods.start_bon_zeile) aktion_bis
     , mwb.art_id              AS art_mutter_wb_id
     , TO_VARCHAR((CASE WHEN sub01.mandant_id = 1 THEN (mwb.art_id/100) ELSE (mwb.art_id/10) END), 'FM00000000')  AS art_mutter_wb_nr
     , msz.art_bez                   AS art_mutter_wb_bez
     , CASE WHEN mwb.art_id = sub01.art_id THEN 0 ELSE 1 END::BYTEINT AS art_mutter_wb_fg -- Kennzeichnung Mutterelement
     , art.art_id
     , TO_VARCHAR((CASE WHEN sub01.mandant_id = 1 THEN (art.art_id/100) ELSE (art.art_id/10) END), 'FM00000000')  AS art_nr
     , asz.art_bez                  AS art_bez
     , art.display_id               AS art_display_id
     , art.basismenge_einh_id       AS art_basismenge_einh_id
     , COALESCE(art.verpart_id,' ') AS art_verpart_id
     , ods.bon_dat, ods.einh_id
     , ods.menge
     , ods.umsatz_brutto
     , ods.umsatz_netto
     , ods.start_bon_zeile
     , MIN(ods.start_bon_zeile) OVER (PARTITION BY sub01.mandant_id, sub01.nb_id, sub01.wup_id, sub01.aktion_id, sub01.art_id ORDER BY sub01.mandant_id, sub01.nb_id, sub01.wup_id, sub01.aktion_id, sub01.art_id, ods.start_bon_zeile) bon_erster_verkauf
     , MAX(ods.start_bon_zeile) OVER (PARTITION BY sub01.mandant_id, sub01.nb_id, sub01.wup_id, sub01.aktion_id, sub01.art_id ORDER BY sub01.mandant_id, sub01.nb_id, sub01.wup_id, sub01.aktion_id, sub01.art_id, ods.start_bon_zeile) bon_letzter_verkauf
   FROM (
     SELECT
       aaw.mandant_id, aaw.aktion_id, aaw.art_id, aaw.wup_id, aaw.nb_id, aaw.vk_aktion_brutto, aaw.bezugsweg_id, aaw.wrg_id, aaw.grund_sperrung, aaw.dat_sperrung, aaw.aktion_thema_id, aaw.vk_vor_aktion_brutto, aaw.dat_preisaktiviert, aaw.bewart_id bewart_id, aa.aktionsart_id, aa.werbe_kat_id, aa.dat_von, aa.dat_bis, aa.preisaktiviert_fg, aa.kjwo_von
   FROM dbp_view.v_aktion_art_wup_zu_1 aaw
   JOIN dbp_view.v_aktion_1 aa
   ON aa.mandant_id = aaw.mandant_id AND aa.aktion_id = aaw.aktion_id
   AND CURRENT_DATE BETWEEN aa.dat_von AND aa.dat_bis
   WHERE aaw.dat_sperrung IS NULL
 )  sub01
 JOIN dbp_view.v_art_1   art_1
   ON art.mandant_id = sub01.mandant_id AND art.art_id = sub01.art_id
   AND art.dat_bis = '9999-12-31'
   JOIN dbp_view.v_art_spr_zu_1    asz
   ON asz.mandant_id = sub01.mandant_id AND asz.art_id = sub01.art_id
   AND asz.spr_id = 22
   JOIN dbp_view.v_art_1     mwb
   ON mwb.mandant_id = art.mandant_id AND mwb.art_id = COALESCE(art.mutter_wb_id, art.art_id)
   AND mwb.dat_bis = '9999-12-31'
   JOIN dbp_view.v_art_spr_zu_1    msz
   ON msz.mandant_id = art.mandant_id AND msz.art_id = COALESCE(art.mutter_wb_id, art.art_id)
   AND msz.spr_id = 22
   LEFT OUTER JOIN (
   SELECT
     bk.bon_id, bk.bon_dat, bk.wup_id, bk.mandant_id, bk.bon_nr, bk.kasse_nr, bk.kassierer_nr, bk.kunde_fg, bk.bon_beginn, bk.bon_ende, bk.umsatz_mwst bon_umsatz_mwst, bk.umsatz_brutto bon_umsatz_brutto, bk.bon_booking, bk.dat_booking, bk.turnover_fg, bk.wrg_id, bk.kasse_typ_id, bk.reactivated_fg, bk.personal_id, bk.betrag_personal_rabatt, bk.kpos_kasse_typ, bk.wagen_nr, bv.bon_zeile, bv.kl_art_id, bv.ean_kasse, bv.wg_id, bv.menge, bv.einh_id, bv.umsatz_brutto, (bv.umsatz_brutto * 100) / (100 + bm.mwst) AS umsatz_netto, bm.mwst, bv.erfassung_id, bv.aktion_id, bv.talon_id, bv.start_bon_zeile, bv.bon_nr_extern, bv.kpos_erfassung_id, bv.umsatz_brutto_norm, bv.vk_brutto_obb, bv.bon_vorgang_id
   FROM dbp_v_ods.v_ods_bon_kopf_1 bk
   INNER JOIN dbp_v_ods.v_ods_bon_verkauf_1 bv
   ON bv.mandant_id = bk.mandant_id AND bv.wup_id = bk.wup_id AND bv.bon_id = bk.bon_id
   INNER JOIN dbp_view.v_mwst_per_1 bm
   ON bm.mandant_id = bv.mandant_id AND bm.mwst_id = bv.mwst_id
  AND bv.bon_dat BETWEEN bm.dat_von AND bm.dat_bis
   WHERE (bk.bon_id, bk.wup_id, bk.mandant_id) NOT IN (
         SELECT bon_id, wup_id, mandant_id
   FROM dbp_v_ods.v_ods_bon_storno_1
   )
   AND bv.wg_id <> 961
AND bk.bon_dat = CURRENT_DATE
) ods
   ON ods.mandant_id = sub01.mandant_id AND ods.wup_id = sub01.wup_id
   AND ods.kl_art_id = sub01.art_id/100;
