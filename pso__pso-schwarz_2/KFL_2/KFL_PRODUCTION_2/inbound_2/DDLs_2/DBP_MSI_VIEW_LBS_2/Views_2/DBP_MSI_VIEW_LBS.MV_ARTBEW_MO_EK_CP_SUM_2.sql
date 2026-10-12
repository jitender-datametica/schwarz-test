CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_ARTBEW_MO_EK_CP_SUM_2(
	MANDANT_ID,
	ART_ID,
	BEWART_ID,
	BEWART_DET_ID,
	POSTEN_ID_PER,
	POSTEN_KZ_PER,
	WUP_ID,
	NB_ID,
	KJMO,
	WRG_ID,
	UMSATZ_NETTO,
	WA_KALK_EK_MEP_KM,
	WA_KALK_EK_MEP_O_FWU_KM,
	LOGKOSTENZUSCHLAG,
	PREIS_ABSCHRIFT_NETTO
) AS
   SELECT
    v01.mandant_id
   ,v01.art_id
   ,v01.bewart_id
   ,v01.bewart_det_id
   ,CAST(CASE WHEN v01.bewart_id = 1001 AND v01.posten_id NOT IN ('PN', 'PF', 'SP', '1') THEN 'SO' ELSE 'PN' END AS VARCHAR(2)) AS posten_id_per
   ,CASE WHEN v01.posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS posten_kz_per
   ,v01.wup_id
   ,v01.nb_id
   ,v01.kjmo
   ,v01.wrg_id
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.umsatz_netto
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.umsatz_netto * umrechnungskurs_hist
        ELSE v01.umsatz_netto END AS umsatz_netto
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep + v01.preis_abschrift_netto
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN (v01.betrag_kmep + v01.preis_abschrift_netto) * umrechnungskurs_hist
        ELSE v01.betrag_kmep + v01.preis_abschrift_netto END AS wa_kalk_ek_mep_km
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_o_fwu + v01.preis_abschrift_netto
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN (v01.betrag_kmep_o_fwu + v01.preis_abschrift_netto) * umrechnungskurs_hist
        ELSE v01.betrag_kmep_o_fwu + v01.preis_abschrift_netto END AS wa_kalk_ek_mep_o_fwu_km
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.logkostenzuschlag
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.logkostenzuschlag * umrechnungskurs_hist
        ELSE v01.logkostenzuschlag END AS logkostenzuschlag
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.preis_abschrift_netto
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.preis_abschrift_netto * umrechnungskurs_hist
        ELSE v01.preis_abschrift_netto END AS preis_abschrift_netto

   FROM (dbp_view.v_artbew_mo_ek_cp_sum_2 v01
   JOIN dbp_view.v_mandant_2 v03
   ON (v01.mandant_id = v03.mandant_id))
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v02

   WHERE wup_bereinigt_fg = 0
   AND v01.mandant_id > 1
   AND DECODE(v01.wrg_id, 'EUR', 0, 1) = DECODE(v03.default_wrg, 'EUR', 0, v02.wrg_typ_id)
   
   
   AND NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
   
   AND NOT (v01.mandant_id = 2 AND v01.art_id = 20812450)
   AND NOT (v01.mandant_id = 3 AND v01.art_id = 20811369)
   AND NOT (v01.mandant_id = 6 AND v01.art_id = 20813157)
   AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 20811474)
   AND NOT (v01.mandant_id = 8 AND v01.art_id = 20813164)
   
   UNION ALL
    
    SELECT
    mandant_id,
    art_id,
    bewart_id,
    bewart_det_id,
    CAST(CASE WHEN bewart_id = 1001 AND posten_id NOT IN ('PN', 'PF', 'SP', '1') THEN 'SO' ELSE 'PN' END AS VARCHAR(2)) AS posten_id_per,
    CASE WHEN posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS posten_kz_per,
    wup_id,
    nb_id,
    kjmo,
    'EUR' AS wrg_id,
    umsatz_netto,
    ek_mep - logkostenzuschlag AS wa_kalk_ek_mep_km,
    ek_mep - logkostenzuschlag AS wa_kalk_ek_mep_o_fwu_km,
    logkostenzuschlag,
    CAST(0 AS NUMBER(18,2)) 
    FROM dbp_view.v_artbew_mo_sum_2
    WHERE mandant_id = 1;