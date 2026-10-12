CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTBEW_DAT_EK_CP_SUM_2
-- SPEC0055656 Aufnahme Felder betrag_kmep_km+ betrag_kmep_km_vj / ssch1303 29.05.2019
(
 mandant_id
,art_id
,gp_id
,bewart_id
,bewart_det_id
,wup_id
,nb_id
,dat
,wrg_id
,wup_bereinigt_fg
,zek_id
,eigenmarke_fg
,umsatz_netto
,umsatz_netto_vj
,betrag_kmep_kw
,betrag_kmep_kw_vj
,betrag_kmep_ww
,betrag_kmep_ww_vj
,betrag_kmep_km
,betrag_kmep_km_vj
,betrag_kmep_o_fwu_kw
,betrag_kmep_o_fwu_kw_vj
,betrag_kmep_o_fwu_ww
,betrag_kmep_o_fwu_ww_vj
,betrag_kmep_o_fwu_km
,betrag_kmep_o_fwu_km_vj
,logkostenzuschlag
,logkostenzuschlag_vj
,werbe_abschrift_netto
,werbe_abschrift_netto_vj
,preis_abschrift_netto
,preis_abschrift_netto_vj
,posten_id_per
,posten_kz_per
)
AS
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
   ,v01.wup_bereinigt_fg
   ,v01.zek_id
   ,v01.eigenmarke_fg
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.umsatz_netto
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.umsatz_netto * umrechnungskurs_hist
        ELSE v01.umsatz_netto END AS umsatz_netto
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.umsatz_netto_vj
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.umsatz_netto_vj * umrechnungskurs_hist
        ELSE v01.umsatz_netto_vj END AS umsatz_netto_vj
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_kw
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.betrag_kmep_kw * umrechnungskurs_hist
        ELSE v01.betrag_kmep_kw END AS betrag_kmep_kw
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_kw_vj
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.betrag_kmep_kw_vj * umrechnungskurs_hist
        ELSE v01.betrag_kmep_kw_vj END AS betrag_kmep_kw_vj
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_ww
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.betrag_kmep_ww * umrechnungskurs_hist
        ELSE v01.betrag_kmep_ww END AS betrag_kmep_ww
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_ww_vj
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.betrag_kmep_ww_vj * umrechnungskurs_hist
        ELSE v01.betrag_kmep_ww_vj END AS betrag_kmep_ww_vj
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_km
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.betrag_kmep_km * umrechnungskurs_hist
        ELSE v01.betrag_kmep_km END AS betrag_kmep_km
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_km_vj
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.betrag_kmep_km_vj * umrechnungskurs_hist
        ELSE v01.betrag_kmep_km_vj END AS betrag_kmep_km_vj
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_o_fwu_kw
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.betrag_kmep_o_fwu_kw * umrechnungskurs_hist
        ELSE v01.betrag_kmep_o_fwu_kw END AS betrag_kmep_o_fwu_kw
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_o_fwu_kw_vj
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.betrag_kmep_o_fwu_kw_vj * umrechnungskurs_hist
        ELSE v01.betrag_kmep_o_fwu_kw_vj END AS betrag_kmep_o_fwu_kw_vj
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_o_fwu_ww
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.betrag_kmep_o_fwu_ww * umrechnungskurs_hist
        ELSE v01.betrag_kmep_o_fwu_ww END AS betrag_kmep_o_fwu_ww
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_o_fwu_ww_vj
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.betrag_kmep_o_fwu_ww_vj * umrechnungskurs_hist
        ELSE v01.betrag_kmep_o_fwu_ww_vj END AS betrag_kmep_o_fwu_ww_vj
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_o_fwu_km
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.betrag_kmep_o_fwu_km * umrechnungskurs_hist
        ELSE v01.betrag_kmep_o_fwu_km END AS betrag_kmep_o_fwu_km
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.betrag_kmep_o_fwu_km_vj
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.betrag_kmep_o_fwu_km_vj * umrechnungskurs_hist
        ELSE v01.betrag_kmep_o_fwu_km_vj END AS betrag_kmep_o_fwu_km_vj
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.logkostenzuschlag
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.logkostenzuschlag * umrechnungskurs_hist
        ELSE v01.logkostenzuschlag END AS logkostenzuschlag
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.logkostenzuschlag_vj
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.logkostenzuschlag_vj * umrechnungskurs_hist
        ELSE v01.logkostenzuschlag_vj END AS logkostenzuschlag_vj
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.werbe_abschrift_netto
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.werbe_abschrift_netto * umrechnungskurs_hist
        ELSE v01.werbe_abschrift_netto END AS werbe_abschrift_netto
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.werbe_abschrift_netto_vj
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.werbe_abschrift_netto_vj * umrechnungskurs_hist
        ELSE v01.werbe_abschrift_netto_vj END AS werbe_abschrift_netto_vj
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.preis_abschrift_netto
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.preis_abschrift_netto * umrechnungskurs_hist
        ELSE v01.preis_abschrift_netto END AS preis_abschrift_netto
  ,CASE WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.preis_abschrift_netto_vj
        WHEN v01.wrg_id = 'EUR' AND v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.preis_abschrift_netto_vj * umrechnungskurs_hist
        ELSE v01.preis_abschrift_netto_vj END AS preis_abschrift_netto_vj
     --Erweiterung um Posten_id und Posten_KZ - NSR4967339 prescherad 14.01.2025
   ,CASE WHEN v01.BEWART_ID = 1001 AND v04.POSTEN_ID NOT IN ('PN', 'PF', 'SP', '1') THEN ''
         ELSE 'PN' END AS POSTEN_ID_PER
   ,CASE WHEN v04.POSTEN_ID NOT IN ('PN', 'PF', 'SP', '1') THEN 'SO'
         ELSE 'PN' END AS POSTEN_KZ_PER


   FROM (dbp_data.artbew_dat_ek_cp_sum_2 v01
   
   JOIN dbp_data.mandant_2 v03
   ON (v01.mandant_id = v03.mandant_id))
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v02

   LEFT JOIN dbp_data.art_per_2 v04
   ON (v01.art_id = v04.art_id
   AND v01.mandant_id = v04.mandant_id
   AND v01.dat BETWEEN v04.dat_von-1 AND v04.dat_bis-1)

   WHERE v01.mandant_id > 1
   AND wup_bereinigt_fg =0
   AND DECODE(v01.wrg_id, 'EUR', 0, 1) = DECODE(v03.default_wrg, 'EUR', 0, v02.wrg_typ_id)
   --AP0190987/SPEC0225041 Filter E-Loading Artikel_2 / sschuecke 17.11.2023
   AND NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
      --AP0227085/SPEC0284781 Filter E-Loading Artikel_2 / sschuecke 25.02.2025
   AND NOT (v01.mandant_id = 2 AND v01.art_id = 208124500)
   AND NOT (v01.mandant_id = 3 AND v01.art_id = 208113690)
   AND NOT (v01.mandant_id = 6 AND v01.art_id = 208131570)
   AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 208114740)
   AND NOT (v01.mandant_id = 8 AND v01.art_id = 208131640);