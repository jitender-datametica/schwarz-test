create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LAGERBEW_DET(
	ART_ID,
	AUTO_FG,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	BETRAG_LAGERBEW,
	BETRAG_VERKAUF,
	EINKAUFSORGANISATION_ID,
	ERF_MENGE_EINH_ID,
	GRUND_ID,
	KJ,
	LAGER_BEWART_ID,
	LAGERBEW_BELEG_ID,
	LAGERBEW_BELEG_POS_ID,
	LAGERORT_ID,
	LAGERPLATZ_ID,
	MANDANT_ID,
	MANDANT_ID_EMPFAENGER,
	MANDANT_ID_KUNDE,
	MENGE_LAGERBEW_KOLLI,
	MENGE_LAGERBEW_BME,
	MENGE_LIEF,
	MENGE_LIEFERSCHEIN,
	MENGE_LAGERBEW_PALETTE,
	NB_ID,
	SOLL_HABEN_KZ,
	WRG_ID,
	WUP_ID,
	DAT_BUCH,
	KUNDE_ID,
	EMPFAENGER_ID,
	GP_ID,
	WRG_TYP_ID,
	BETRAG_VK_NETTO_VZ
) as






   SELECT
   v01.art_id, v01.auto_fg, v01.best_beleg_id, v01.best_beleg_pos_id, 
   CASE WHEN v03.wrg_typ_id = 0 THEN (v01.betrag_lagerbew * v02.umrechnungskurs * v04.ek_anzeige_fg) ELSE (v01.betrag_lagerbew * v04.ek_anzeige_fg)END
   *
   CASE WHEN (v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642','644', '648', 'Z11') AND v01.mandant_id <> 1)THEN -1 ELSE 1 END AS betrag_lagerbew, 
   CASE WHEN v03.wrg_typ_id = 0 THEN (v01.betrag_verkauf * v02.umrechnungskurs)ELSE v01.betrag_verkauf END
   *
   CASE WHEN (v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642','644', '648', 'Z11') AND v01.mandant_id <> 1)THEN -1 ELSE 1 END AS betrag_verkauf,
   v01.einkaufsorganisation_id, v01.erfsngs_menge_einh_id, v01.grund_id, v01.kj, v01.lager_bewart_id, v01.lagerbew_beleg_id, v01.lagerbew_beleg_pos_id, v01.lagerort_id, 
   CASE WHEN v01.lagerplatz_id IS NULL THEN 'Kein Lagerplatz' ELSE v01.lagerplatz_id END AS lagerplatz_id,
   v01.mandant_id,
   CASE WHEN v01.mandant_id_empfaenger IS NULL OR v01.mandant_id_empfaenger = 0 THEN v01.mandant_id ELSE v01.mandant_id_empfaenger END AS mandant_id_empfaenger,
   CASE WHEN v01.mandant_id_kunde IS NULL OR v01.mandant_id_kunde = 0 THEN v01.mandant_id ELSE v01.mandant_id_kunde END AS mandant_id_kunde,
   CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642','644', '648', 'Z11') AND v01.mandant_id <> 1 
        THEN v01.menge_lagerbew_kolli * -1 ELSE v01.menge_lagerbew_kolli END AS menge_lagerbew_kolli,
   CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642','644', '648', 'Z11') AND v01.mandant_id <> 1
        THEN v01.menge_lagerbew_bme * -1 ELSE v01.menge_lagerbew_bme END AS menge_lagerbew_bme, 
   CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642','644', '648', 'Z11') AND v01.mandant_id <> 1
        THEN v01.menge_lief * -1 ELSE v01.menge_lief END AS menge_lief,
   CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642','644', '648', 'Z11') AND v01.mandant_id <> 1
        THEN v01.menge_lieferschein * 1 ELSE v01.menge_lieferschein END AS menge_lieferschein,
   CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642','644', '648', 'Z11') AND v01.mandant_id <> 1
        THEN v01.menge_lagerbew_palette * -1 ELSE v01.menge_lagerbew_palette END AS menge_lagerbew_palette,
   v01.nb_id,
   v01.soll_haben_kz,
   v03.wrg_id,
   v01.wup_id,
   v01.dat_buch,
   CASE WHEN TRY_CAST(SUBSTR(v01.kunde_id,7,4) AS INTEGER) IS NULL THEN 0  ELSE CAST(SUBSTR(v01.kunde_id,7,4) AS INTEGER)END AS kunde_id, 
   
   CASE WHEN v01.empfaenger_id IS NULL THEN 0 ELSE COALESCE(v06.aktuell_wup_id,v01.empfaenger_id) END AS empfaenger_id,
   v01.gp_id,
   v03.wrg_typ_id,
   CASE WHEN v03.wrg_typ_id = 0 THEN (v01.betrag_vk_netto_vz * v02.umrechnungskurs) ELSE v01.betrag_vk_netto_vz END
   *
   CASE WHEN (v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642','644', '648', 'Z11') AND v01.mandant_id <> 1) THEN -1 ELSE 1 END AS betrag_vk_netto_vz
   FROM dbp_view.v_lagerbew_det v01
   
   LEFT JOIN dbp_view.v_wup v06
   ON v06.mandant_id = CASE WHEN v01.mandant_id_empfaenger IS NULL OR v01.mandant_id_empfaenger = 0 THEN v01.mandant_id ELSE v01.mandant_id_empfaenger END
   AND v06.wup_id = v01.empfaenger_id
   AND v06.nb_id = 0

   JOIN DBP_MSI_VIEW3_MATERIALIZED.mv_kurs v02
   ON v01.wrg_id = v02.von_wrg_id
   JOIN dbp_view.v_mandant_wrg_typ_zu v03
   ON v01.mandant_id = v03.mandant_id
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU v05
   ON v03.wrg_typ_id = v05.wrg_typ_id
   CROSS JOIN dbp_msi.akt_msi_user_ek_anzeige_zu v04
   WHERE v01.lagerort_id NOT IN ('-1', '-2', '-3');