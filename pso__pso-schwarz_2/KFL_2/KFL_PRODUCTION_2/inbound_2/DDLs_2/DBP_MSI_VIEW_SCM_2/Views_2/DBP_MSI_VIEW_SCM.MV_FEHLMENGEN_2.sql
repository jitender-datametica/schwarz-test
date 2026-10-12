CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_FEHLMENGEN_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	LAGERORT_ID,
	EMPFAENGER_WUP_ID,
	MANDANT_ID_EMPFAENGER,
	EMPFAENGER_NB_ID,
	ART_ID,
	DAT_LIEF_SOLL,
	BESTELLART_ID,
	WRG_ID,
	LIEFERUNGSKUERZUNG_FG,
	DIFF_ID,
	MENGE_LIEF_SOLL_KOLLI,
	MENGE_LIEF_IST_KOLLI,
	VK_NETTO_LIEF_SOLL,
	VK_NETTO_LIEF_IST,
	KZ_MENGE_LIEF_SOLL_KOLLI,
	KZ_MENGE_LIEF_IST_KOLLI,
	KZ_VK_NETTO_LIEF_SOLL,
	KZ_VK_NETTO_LIEF_IST,
	LOESCH_ID,
	KDIS,
	DISPONENT_ID,
	GRUND_ID,
	PRIO_ID,
	LOESCH_ID_HIST
) AS 
--2024-04-22, AP0179753, dknop, initial
--2024-05-17, dknop, change to inner join dbp_view.v_art_wup_status_per_2 
--2024-05-23, dknop, adding loesch_id_hist, including umrechnungskurs in calculations
--2024-06-04, dknop, adding t.akt_kj BETWEEN -2 AND 0
--2024-06-13, dknop, adding UB2K to the filter
--2024-07-19, nwag, switching to regular table
--2024-07-26, dknop, adding 'UBF1','UBFL','ZFLS','ZFW1'  to the filter
--2024-08-05,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2025-03-11, nwag, adding best_beleg_id + best_beleg_pos_id
SELECT
   v01.mandant_id
   ,v01.wup_id
   ,v01.nb_id
   ,v01.best_beleg_id
   ,v01.best_beleg_pos_id
   ,v01.lagerort_id
   --,v01.empfaenger_wup_id
   --, CASE WHEN TRY_CAST(empfaenger_wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END empfaenger_wup_id
   ,v05.aktuell_wup_id empfaenger_wup_id
   ,v01.mandant_id_empfaenger

   ,v01.empfaenger_nb_id
   ,v01.art_id
   ,v01.dat_lief_soll
   ,v01.bestellart_id
   ,CASE WHEN user_wrg.wrg_typ_id=0 THEN 'EUR' ELSE v01.wrg_id END AS wrg_id
   ,COALESCE(v01.kuerzung_fg,0) AS lieferungskuerzung_fg
   ,CASE WHEN lieferungskuerzung_fg = 1 THEN 'F' ELSE v01.diff_id END AS diff_id
   ,v01.menge_lief_soll_kolli
   ,CASE WHEN v01.menge_lief_ist_kolli > v01.menge_lief_soll_kolli THEN v01.menge_lief_soll_kolli ELSE v01.menge_lief_ist_kolli END AS menge_lief_ist_kolli
   ,CASE WHEN user_wrg.wrg_typ_id=0 THEN v01.vk_netto_soll * kurs.umrechnungskurs ELSE v01.vk_netto_soll END AS vk_netto_lief_soll
   ,CASE WHEN v01.vk_netto_ist > v01.vk_netto_soll THEN 
                                                   CASE WHEN user_wrg.wrg_typ_id=0 THEN v01.vk_netto_soll * kurs.umrechnungskurs ELSE v01.vk_netto_soll END 
                                                   ELSE CASE WHEN user_wrg.wrg_typ_id=0 THEN v01.vk_netto_ist * kurs.umrechnungskurs ELSE v01.vk_netto_ist END END AS vk_netto_lief_ist
   ,v01.kuerz_menge_lief_soll_kolli AS kz_menge_lief_soll_kolli
   ,v01.kuerz_menge_lief_ist_kolli AS kz_menge_lief_ist_kolli
   ,CASE WHEN user_wrg.wrg_typ_id=0 THEN v01.kuerz_vk_netto_soll * kurs.umrechnungskurs  ELSE v01.kuerz_vk_netto_soll END AS kz_vk_netto_lief_soll
   ,CASE WHEN user_wrg.wrg_typ_id=0 THEN v01.kuerz_vk_netto_ist * kurs.umrechnungskurs ELSE v01.kuerz_vk_netto_ist END AS kz_vk_netto_lief_ist
   ,v02.loesch_id
   ,v02.kdis
   ,v02.disponent_id
   ,CASE WHEN v02.loesch_id IN ('A', 'L', 'R') THEN 1
         WHEN v01.kuerzung_fg > 1  AND v01.menge_lief_soll_kolli > v01.menge_lief_ist_kolli THEN 2
         WHEN v02.loesch_id IN ('F1', 'F2') THEN 3
         WHEN v01.kuerzung_fg = 0  AND v01.menge_lief_soll_kolli > v01.menge_lief_ist_kolli THEN 4
         WHEN v01.bestellart_id = 'UBE' THEN 5
         ELSE 0 END AS grund_id
     ,CASE WHEN v02.loesch_id IN ('A', 'L', 'R', 'F1', 'F2') THEN 1
         WHEN v01.kuerzung_fg > 1  AND v01.menge_lief_soll_kolli > v01.menge_lief_ist_kolli THEN 4
         WHEN v01.kuerzung_fg = 0  AND v01.menge_lief_soll_kolli > v01.menge_lief_ist_kolli THEN 3
         WHEN v01.bestellart_id = 'UBE' THEN 2
         ELSE -1 END AS prio_id
    ,v02.loesch_id AS loesch_id_hist

   FROM dbp_view.v_besch_lief_fehlmengen_2 v01
   
   INNER JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = CASE WHEN v01.mandant_id_empfaenger IS NULL OR v01.mandant_id_empfaenger = 0 THEN v01.mandant_id ELSE v01.mandant_id_empfaenger END
   --AND v05.wup_id = CASE WHEN TRY_CAST(empfaenger_wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(empfaenger_wup_id AS INTEGER) END
   AND v05.wup_id = v01.empfaenger_wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

   JOIN dbp_msi_view_scm.mv_kurs_2 kurs_2
   ON v01.wrg_id = kurs.von_wrg_id
   
   JOIN dbp_view.v_tag_2 t
   ON v01.dat_lief_soll = t.dat

   CROSS JOIN dbp_msi_view_scm.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 user_wrg 

   INNER JOIN dbp_view.v_art_wup_status_per_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.art_id = v02.art_id
   AND v01.wup_id = v02.wup_id
   AND v01.nb_id = v02.nb_id 
   AND v01.dat_lief_soll BETWEEN v02.dat_von AND v02.dat_bis

 
 WHERE v01.bestellart_id NOT IN ('ZFHS','ZWFH','ZWHM','ZWHS','ZLUB', 'UB2K','UBF1','UBFL','ZFLS','ZFW1')
 AND t.akt_kj BETWEEN -2 AND 0
   ;