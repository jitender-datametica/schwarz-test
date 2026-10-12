CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ARTBEW_MO_EK_CP_SUM_1(
	MANDANT_ID,
	ART_ID,
      GP_ID,
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
    -- AP0281473/SPEC0323868 Erweiterung um Lieferant / prescherad 14.08.2025
   ,v01.gp_id
   ,v01.bewart_id
   ,v01.bewart_det_id
   ,CAST(CASE WHEN v01.bewart_id = 1001 AND v01.posten_id NOT IN ('PN', 'PF', 'SP', '1') THEN 'SO' ELSE 'PN' END AS VARCHAR(2)) AS posten_id_per
   ,CASE WHEN v01.posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS posten_kz_per																																																													 
   ,v01.wup_id
   ,v01.nb_id
   ,v01.kjmo
   ,v01.wrg_id
    /* ,v01.umsatz_netto
   ,v01.betrag_kmep + v01.preis_abschrift_netto AS wa_kalk_ek_mep_km
   ,v01.betrag_kmep_o_fwu + v01.preis_abschrift_netto AS wa_kalk_ek_mep_o_fwu_km
   ,v01.logkostenzuschlag
   ,v01.preis_abschrift_netto*/

    -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
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

   FROM (dbp_data.artbew_mo_ek_cp_sum_1 v01
   JOIN dbp_data.mandant_1 v03
   ON (v01.mandant_id = v03.mandant_id))
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v02

   WHERE wup_bereinigt_fg = 0
   AND v01.mandant_id > 1
   AND DECODE(v01.wrg_id, 'EUR', 0, 1) = DECODE(v03.default_wrg, 'EUR', 0, v02.wrg_typ_id)
   --AP0190987/SPEC0225041 Filter E-Loading Artikel_1 / sschuecke 17.11.2023
   AND NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
   --AP0227085/SPEC0284781 Filter E-Loading Artikel_1 / sschuecke 25.02.2025
   AND NOT (v01.mandant_id = 2 AND v01.art_id = 208124500)
   AND NOT (v01.mandant_id = 3 AND v01.art_id = 208113690)
   AND NOT (v01.mandant_id = 6 AND v01.art_id = 208131570)
   AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 208114740)
   AND NOT (v01.mandant_id = 8 AND v01.art_id = 208131640)
   
   UNION ALL
    
    SELECT
    mandant_id,
    art_id,
    -- AP0281473/SPEC0323868 Erweiterung um Lieferant / prescherad 14.08.2025
    gp_id,
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
    FROM dbp_data.artbew_mo_sum_1
    WHERE mandant_id = 1;