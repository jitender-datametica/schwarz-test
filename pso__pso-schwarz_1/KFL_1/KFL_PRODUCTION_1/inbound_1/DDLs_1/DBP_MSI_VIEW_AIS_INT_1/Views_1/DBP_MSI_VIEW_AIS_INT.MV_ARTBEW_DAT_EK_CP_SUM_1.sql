CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ARTBEW_DAT_EK_CP_SUM_1 (
	MANDANT_ID,
	ART_ID,
      GP_ID,
	BEWART_ID,
	BEWART_DET_ID,
	WUP_ID,
	NB_ID,
	DAT,
	WRG_ID,
	UMSATZ_NETTO,
	WA_KALK_EK_MEP_KW,
	WA_KALK_EK_MEP_WW,
      WA_KALK_EK_MEP_O_FWU_KW,
	WA_KALK_EK_MEP_O_FWU_WW,
	LOGKOSTENZUSCHLAG,
	PREIS_ABSCHRIFT_NETTO,
      POSTEN_ID_PER,
	POSTEN_KZ_PER
) AS
    SELECT
    v01.mandant_id
   ,v01.art_id
   -- AP0281473/SPEC0323868 Erweiterung um Lieferant / prescherad 23.07.2025
   ,v01.gp_id
   ,v01.bewart_id
   ,v01.bewart_det_id
   ,v01.wup_id
   ,v01.nb_id
   ,v01.dat
   ,v01.wrg_id
       -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.umsatz_netto
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.umsatz_netto * umrechnungskurs_hist
        ELSE v01.umsatz_netto END AS umsatz_netto
   /*,v01.betrag_kmep_kw + v01.preis_abschrift_netto AS wa_kalk_ek_mep_kw
   ,v01.betrag_kmep_ww + v01.preis_abschrift_netto AS wa_kalk_ek_mep_ww
   ,v01.betrag_kmep_o_fwu_kw + v01.preis_abschrift_netto AS wa_kalk_ek_mep_o_fwu_kw
   ,v01.betrag_kmep_o_fwu_ww + v01.preis_abschrift_netto AS wa_kalk_ek_mep_o_fwu_ww*/
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_kw + v01.preis_abschrift_netto
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN (v01.betrag_kmep_kw + v01.preis_abschrift_netto) * umrechnungskurs_hist
        ELSE v01.betrag_kmep_kw + v01.preis_abschrift_netto END AS wa_kalk_ek_mep_kw
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_ww + v01.preis_abschrift_netto
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN (v01.betrag_kmep_ww + v01.preis_abschrift_netto) * umrechnungskurs_hist
        ELSE v01.betrag_kmep_ww + v01.preis_abschrift_netto END AS wa_kalk_ek_mep_ww
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_o_fwu_kw + v01.preis_abschrift_netto
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN (v01.betrag_kmep_o_fwu_kw + v01.preis_abschrift_netto) * umrechnungskurs_hist
        ELSE v01.betrag_kmep_o_fwu_kw + v01.preis_abschrift_netto END AS wa_kalk_ek_mep_o_fwu_kw
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_o_fwu_ww + v01.preis_abschrift_netto
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN (v01.betrag_kmep_o_fwu_ww + v01.preis_abschrift_netto) * umrechnungskurs_hist
        ELSE v01.betrag_kmep_o_fwu_ww + v01.preis_abschrift_netto END AS wa_kalk_ek_mep_o_fwu_ww
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.logkostenzuschlag
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.logkostenzuschlag * umrechnungskurs_hist
        ELSE v01.logkostenzuschlag END AS logkostenzuschlag
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.preis_abschrift_netto
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.preis_abschrift_netto * umrechnungskurs_hist
        ELSE v01.preis_abschrift_netto END AS preis_abschrift_netto
     --Erweiterung um Posten_id und Posten_KZ - NSR4967339 prescherad 14.01.2025
  ,CASE WHEN v01.BEWART_ID = 1001 AND v04.POSTEN_ID NOT IN ('PN', 'PF', 'SP', '1') THEN ''
         ELSE 'PN' END  AS POSTEN_ID_PER
  ,CASE WHEN v04.POSTEN_ID NOT IN ('PN', 'PF', 'SP','1') THEN 'SO'
         ELSE 'PN' END AS POSTEN_KZ_PER

   FROM (dbp_data.artbew_dat_ek_cp_sum_1 v01
   JOIN dbp_data.mandant_1 v03
   ON (v01.mandant_id = v03.mandant_id))
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v02
                                                                              
   LEFT JOIN dbp_data.art_per_1 v04
   ON (v01.art_id = v04.art_id
   AND v01.mandant_id = v04.mandant_id
   AND v01.dat BETWEEN v04.dat_von-1 AND v04.dat_bis-1)

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
    v01.mandant_id,
    v01.art_id,
    -- AP0281473/SPEC0323868 Erweiterung um Lieferant / prescherad 23.07.2025
    v01.gp_id,
    v01.bewart_id,
    v01.bewart_det_id,
    v01.wup_id,
    v01.nb_id,
    v01.dat,
    v01.wrg_1,
    v01.umsatz_netto,
    v01.ek_mep - v01.logkostenzuschlag AS wa_kalk_ek_mep_kw,
    v01.ek_mep - v01.logkostenzuschlag AS wa_kalk_ek_mep_ww,
    v01.ek_mep - v01.logkostenzuschlag AS wa_kalk_ek_mep_o_fwu_kw,
    v01.ek_mep - v01.logkostenzuschlag AS wa_kalk_ek_mep_o_fwu_ww,
    v01.logkostenzuschlag,
    CAST(0 AS NUMBER(18,2)),
    CASE WHEN v01.BEWART_ID = 1001 AND v04.POSTEN_ID NOT IN ('PN', 'PF', 'SP', '1') THEN ''
         ELSE 'PN' END  AS POSTEN_ID_PER,
    CASE WHEN v04.POSTEN_ID NOT IN ('PN', 'PF', 'SP', '1') THEN 'SO'
         ELSE 'PN' END AS POSTEN_KZ_PER

    FROM dbp_data.artbew_1 v01
    LEFT JOIN dbp_data.art_per_1 v04
    ON (v01.art_id = v04.art_id
    AND v01.mandant_id = v04.mandant_id
    AND v01.dat BETWEEN v04.dat_von-1 AND v04.dat_bis-1)
    WHERE v01.mandant_id = 1;