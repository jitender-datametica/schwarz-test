CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_MSEG_1(
	MANDANT_ID,
	MBLNR,
	MBLNR_NUM,
	ZEILE,
	ZEILE_NUM,
	MBLNR_ZEILE,
	MJAHR,
	BWART,
	ART_ID,
	GRUND,
	WERKS,
	NB_ID,
	XAUTO,
	LGORT,
	LIFNR,
	EKORG,
	SHKZG,
	SOLL_HABEN_VZ,
	WAERS,
	EBELN,
	EBELP,
	EBELN_EBELP,
	DMBTR,
	VKWRT,
	ERFME,
	LGPLA,
	KUNNR,
	MENGE,
	LSMNG,
	BPMNG,
	ERFMG,
	WEMPF,
	BUDAT,
	SMBLN,
	SMBLP,
	SJAHR,
	SJAHR_SMBLN_SMBLP,
	VKWRA,
	MANDANT_ID_KUNDE,
	MANDANT_ID_EMPFAENGER,
	EXVKW,
	BETRAG_VK_NETTO_VZ,
	BETRAG_VERKAUF_IST_NETTO,
	EXVKW_NT,
	VK_WERT_NT,
	LBKUM,
	SALK3,
	BUKRS,
	SHKUM,
	KOSTL,
	SAKTO,
	UMMAT,
	UMLGO,
	MATBF,
	PARENT_ID,
	LINE_ID,
	ELIKZ,
	XRUEM,
	EXBWR,
	BNBTR,
	DMBUM
) AS
   --NSR2941808 Modifizierung WWC-Views - Sushi Umsätze
   --AP0038599, SPEC0052815 entfernen Group by Block in dbp_view.v_lagerbew_det_1 
   --04.07.2023, SPEC0205969, prescherad: Ausfiltern Shop in Shop
   --20.11.2023, SPEC0224904, prescherad: Ausfiltern_Eloading
   --22.10.2024, SPEC0276971, prescherad: Ausfiltern WGI969006 für CZ und DE
   --19.11.2024, SPEC0281741, prescherad: WGI969006 Filter für CZ entfernen
   --14.02.2025, SPEC0282957, prescherad: Ausfiltern_Eloading Alle Mandanten außer DE
   SELECT a.mandant_id, a.MBLNR, a.MBLNR_NUM, a.ZEILE, a.ZEILE_NUM, a.MBLNR_ZEILE
   , a.MJAHR, a.BWART, a.art_id, a.GRUND, a.WERKS, a.nb_id, a.XAUTO, a.LGORT, a.LIFNR, a.EKORG
   , a.SHKZG, a.soll_haben_vz, a.WAERS, a.EBELN, a.EBELP, a.EBELN_EBELP, a.DMBTR, a.VKWRT, a.ERFME
   , a.LGPLA, a.KUNNR, a.MENGE, a.LSMNG, a.BPMNG, a.ERFMG, a.WEMPF, a.BUDAT, a.SMBLN, a.SMBLP, a.SJAHR
   , a.SJAHR_SMBLN_SMBLP, a.VKWRA, a.mandant_id_kunde, a.mandant_id_empfaenger, a.EXVKW, a.betrag_vk_netto_vz
   , a.betrag_verkauf_ist_netto, a.EXVKW_nt, a.VK_Wert_nt, a.LBKUM, a.SALK3, a.BUKRS, a.SHKUM, a.KOSTL
   , a.SAKTO, a.UMMAT, a.UMLGO, a.MATBF, a.PARENT_ID, a.LINE_ID, a.ELIKZ, a.XRUEM, a.EXBWR, a.BNBTR, a.DMBUM
   FROM (SELECT
   v01.mandant_id, TO_VARCHAR(v01.lagerbew_beleg_id, 'FM0000000000')   AS MBLNR, v01.lagerbew_beleg_id AS MBLNR_NUM
   , TO_VARCHAR(v01.lagerbew_beleg_pos_id, 'FM0000') AS ZEILE, v01.lagerbew_beleg_pos_id AS ZEILE_NUM
   , TO_VARCHAR(v01.lagerbew_beleg_id, 'FM0000000000') ||' ' || TO_VARCHAR(v01.lagerbew_beleg_pos_id, 'FM0000')  AS MBLNR_ZEILE
   , v01.kj                      AS MJAHR, v01.lager_bewart_id         AS BWART, v01.art_id
   , CAST(v01.grund_id AS CHAR(10)) AS GRUND, v01.wup_id                  AS WERKS
   , v01.nb_id, v01.auto_fg                 AS XAUTO, v01.lagerort_id             AS LGORT
   , v01.gp_id                   AS LIFNR, v01.einkaufsorganisation_id AS EKORG, v01.soll_haben_kz           AS SHKZG
   , CASE WHEN v01.soll_haben_kz = 'H' THEN -1 ELSE 1 END AS soll_haben_vz, v01.wrg_id                  AS WAERS
   , v01.best_beleg_id           AS EBELN, v01.best_beleg_pos_id       AS EBELP
   , TO_VARCHAR(v01.best_beleg_id, 'FM0000000000') ||' ' || TO_VARCHAR(v01.best_beleg_pos_id, 'FM0000') AS EBELN_EBELP
   , v01.betrag_lagerbew         AS DMBTR, v01.betrag_verkauf          AS VKWRT
   , CAST(v01.erfsngs_menge_einh_id AS CHAR(3))   AS ERFME, v01.lagerplatz_id           AS LGPLA
   , v01.kunde_id                AS KUNNR, v01.menge_lagerbew_bme      AS MENGE, v01.menge_lieferschein      AS LSMNG
   , v01.menge_lief              AS BPMNG, v01.menge_erf               AS ERFMG, v01.empfaenger_id                AS WEMPF
   , v01.dat_buch                     AS BUDAT, v01.lagerbew_beleg_storno_id     AS SMBLN
   , v01.lagerbew_beleg_pos_storno_id AS SMBLP, v01.lagerbew_beleg_storno_kj     AS SJAHR
   , TO_VARCHAR(v01.lagerbew_beleg_storno_kj, 'FM0000') ||' ' || TO_VARCHAR(v01.lagerbew_beleg_storno_id, 'FM0000000000') ||' ' || TO_VARCHAR(v01.lagerbew_beleg_pos_storno_id, 'FM0000') AS SJAHR_SMBLN_SMBLP
   , v01.betrag_vk_netto              AS VKWRA, v01.mandant_id_kunde, v01.mandant_id_empfaenger
   , v01.betrag_verkauf_ist           AS EXVKW, v01.betrag_vk_netto_vz, v01.betrag_verkauf_ist_netto
   , CASE WHEN v01.betrag_verkauf_ist = v01.betrag_verkauf THEN v01.betrag_vk_netto ELSE v01.betrag_verkauf_ist_netto END AS EXVKW_nt
   , CASE WHEN v01.lager_bewart_id IN ('251','252') AND v01.betrag_verkauf_ist =  v01.betrag_verkauf THEN v01.betrag_vk_netto
   WHEN v01.lager_bewart_id IN ('251','252') AND v01.betrag_verkauf_ist <> v01.betrag_verkauf THEN v01.betrag_verkauf_ist_netto
   WHEN v01.lager_bewart_id NOT IN ('251','252') THEN v01.betrag_vk_netto
   ELSE 0
   END AS VK_Wert_nt, v02.menge_bestand_bme            AS LBKUM, v02.wert_bestand                 AS SALK3, v02.buchungskreis_id             AS BUKRS, v02.SHKUM, v02.kostenstelle_id              AS KOSTL, v02.sachkonto_id                 AS SAKTO, v02.art_id_empfaenger            AS UMMAT, v02.lagerort_id_empfaenger       AS UMLGO, v02.art_id_bf                    AS MATBF, v02.lagerbew_beleg_pos_mutter_id AS PARENT_ID, v02.LINE_ID
   , CASE v02.endlief_fg WHEN 0 THEN '' WHEN 1 THEN 'X' ELSE CAST(v02.endlief_fg AS VARCHAR(5)) END AS ELIKZ
   , CASE v02.xruem_fg   WHEN 0 THEN '' WHEN 1 THEN 'X' ELSE CAST(v02.xruem_fg AS VARCHAR(5)) END AS XRUEM, v02.betrag_exbwr                 AS EXBWR
   , v02.betrag_bnk                   AS BNBTR, v02.betrag_umbewertung           AS DMBUM
   FROM dbp_view.v_lagerbew_det_1 v01
   INNER JOIN dbp_view.v_lagerbew_det_wwc_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.lagerbew_beleg_id = v02.lagerbew_beleg_id
   AND v01.lagerbew_beleg_pos_id = v02.lagerbew_beleg_pos_id
   AND v01.kj = v02.kj
   AND v01.dat_buch = v02.dat_buch
   --Suhsi RO ausfiltern
   INNER JOIN DBP_VIEW.V_art_wg_zu_per_1 V03
   ON v01.Art_ID=v03.art_id
   AND v01.mandant_id = v03.mandant_id
      -- Wenn nicht Mandant_1 1,7 dann alles   
   AND (v03.MANDANT_ID NOT IN (1,7)
      -- wenn  Mandant_1 1,7 dann  kein Sushi/Shop in Shop 
      OR (V03.MANDANT_ID IN (1,7) AND TO_VARCHAR(V03.wg_id,'FM000')|| TO_VARCHAR(V03.wug_id,'FM000') != '969006' )
   )
   -- Wenn nicht Mandant_1 7 dann alles   
   AND (v03.MANDANT_ID != 7
   -- Wenn  Mandant_1 7 dann kein Pfand 
      OR v03.MANDANT_ID = 7 AND TO_VARCHAR(v03.wg_id,'FM000') !='980')
   --Ausfiltern Shop in Shop
   AND v03.wg_id!=961
   --Ausfiltern E-Loading alle Mandaten ungleich 1
   AND (v03.MANDANT_ID NOT IN (2,3,4,5,6,7,8)
     --- wenn  Mandant_1 ungleich 1 dann  ohne E-loading 
      OR (v03.MANDANT_ID IN  (2,3,4,5,6,7,8) AND TO_VARCHAR(V03.wg_id,'FM000')|| TO_VARCHAR(v03.wug_id,'FM000') NOT IN ('969001','969002','969003','969004'))
	)   
   AND V03.arthiertyp_id = 2
   AND V03.dat_bis = '9999-12-31'    
 )  a
   LEFT JOIN dbp_view.v_lagerbew_det_delta_1 b
   ON a.mandant_id        = b.mandant_id            AND
   a.MBLNR      = b.lagerbew_beleg_id     AND
   a.ZEILE  = b.lagerbew_beleg_pos_id AND
   a.MJAHR                     = b.kj AND
   a.budat = b.dat_buch
   WHERE b.mandant_id IS NULL
   UNION ALL
   SELECT
   mandant_id, TO_VARCHAR(lagerbew_beleg_id, 'FM0000000000')   AS MBLNR, lagerbew_beleg_id AS MBLNR_NUM, TO_VARCHAR(lagerbew_beleg_pos_id, 'FM0000') AS ZEILE, lagerbew_beleg_pos_id AS ZEILE_NUM, TO_VARCHAR(lagerbew_beleg_id, 'FM0000000000') ||' ' || TO_VARCHAR(lagerbew_beleg_pos_id, 'FM0000')  AS MBLNR_ZEILE, kj                      AS MJAHR, lager_bewart_id         AS BWART, art_id, CAST(grund_id AS CHAR(10)) AS GRUND, wup_id                  AS WERKS, nb_id, auto_fg                 AS XAUTO, lagerort_id             AS LGORT, gp_id                   AS LIFNR, einkaufsorganisation_id AS EKORG, soll_haben_kz           AS SHKZG, CASE WHEN soll_haben_kz = 'H' THEN -1 ELSE 1 END AS soll_haben_vz, wrg_id                  AS WAERS, best_beleg_id           AS EBELN, best_beleg_pos_id       AS EBELP, TO_VARCHAR(best_beleg_id, 'FM0000000000') ||' ' || TO_VARCHAR(best_beleg_pos_id, 'FM0000') AS EBELN_EBELP, betrag_lagerbew         AS DMBTR, betrag_verkauf          AS VKWRT, CAST(erfsngs_menge_einh_id AS CHAR(3))   AS ERFME, lagerplatz_id           AS LGPLA, kunde_id                AS KUNNR, menge_lagerbew_bme      AS MENGE, menge_lieferschein      AS LSMNG, menge_lief              AS BPMNG, menge_erf               AS ERFMG, empfaenger_id                AS WEMPF, dat_buch                     AS BUDAT, lagerbew_beleg_storno_id     AS SMBLN, lagerbew_beleg_pos_storno_id AS SMBLP, lagerbew_beleg_storno_kj     AS SJAHR, TO_VARCHAR(lagerbew_beleg_storno_kj, '0000') ||' ' || TO_VARCHAR(lagerbew_beleg_storno_id, 'FM0000000000') ||' ' || TO_VARCHAR(lagerbew_beleg_pos_storno_id, 'FM0000') AS SJAHR_SMBLN_SMBLP, betrag_vk_netto              AS VKWRA, mandant_id_kunde, mandant_id_empfaenger, betrag_verkauf_ist           AS EXVKW, betrag_vk_netto_vz, betrag_verkauf_ist_netto, CASE WHEN betrag_verkauf_ist = betrag_verkauf THEN betrag_vk_netto ELSE betrag_verkauf_ist_netto END AS EXVKW_nt, CASE WHEN lager_bewart_id IN ('251','252') AND betrag_verkauf_ist =  betrag_verkauf THEN betrag_vk_netto
   WHEN lager_bewart_id IN ('251','252') AND betrag_verkauf_ist <> betrag_verkauf THEN betrag_verkauf_ist_netto
   WHEN lager_bewart_id NOT IN ('251','252') THEN betrag_vk_netto
   ELSE 0
   END AS VK_Wert_nt, menge_bestand_bme            AS LBKUM, wert_bestand                 AS SALK3, buchungskreis_id             AS BUKRS, SHKUM, kostenstelle_id              AS KOSTL, sachkonto_id                 AS SAKTO, art_id_empfaenger            AS UMMAT, lagerort_id_empfaenger       AS UMLGO, art_id_bf                    AS MATBF, lagerbew_beleg_pos_mutter_id AS PARENT_ID, LINE_ID
   , CASE endlief_fg WHEN 0 THEN '' WHEN 1 THEN 'X' ELSE CAST(endlief_fg AS VARCHAR(5))  END AS ELIKZ
   , CASE xruem_fg   WHEN 0 THEN '' WHEN 1 THEN 'X' ELSE CAST(xruem_fg AS VARCHAR(5))  END AS XRUEM, betrag_exbwr                 AS EXBWR, betrag_bnk                   AS BNBTR, betrag_umbewertung   AS DMBUM
   FROM dbp_view.v_lagerbew_det_delta_1
   ;