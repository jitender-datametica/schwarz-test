CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_F_VZ_BESTAND_ERP_PER
(
    MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
     LAGERORT_ID,
	DAT,
	GP_ID,
	DS_VZ_BESTAND_MENGE_FREI,
	DS_VZ_BESTAND_MENGE_QUAL,
	DS_VZ_BESTAND_MENGE_GES,
	DS_VZ_BESTAND_EKN_FREI,
	DS_VZ_BESTAND_EKN_QUAL,
	DS_VZ_BESTAND_EKN_GES,
	DS_VZ_BESTAND_KLEP_FREI,
	DS_VZ_BESTAND_KLEP_QUAL,
	DS_VZ_BESTAND_KLEP_GES,
	DS_VZ_BESTAND_MEP_OLK_FREI,
	DS_VZ_BESTAND_MEP_OLK_QUAL,
	DS_VZ_BESTAND_MEP_OLK_GES,
	DS_VZ_BESTAND_VKN_FREI,
	DS_VZ_BESTAND_VKN_QUAL,
	DS_VZ_BESTAND_VKN_GES
)
AS
-- 20240416 staeblern: Neuerstellung der View (analog zu AIS KMO/DE)
--                     Zusatz DS_* bei den Kennzahlen bedeutet Distribution Service (da dies aus LIS kommt)
-- 2024-04-29, steablern - Lagerort mit aufnehmen & Group by & SUM entfernen 
-- 2024-07-03, prescherad, SPEC0247099, Filterung auf dat < CURRENT_DATE()
SELECT
    t1.mandant_id
   ,t1.wup_id
   ,t1.nb_id
   ,t1.art_id
   ,t1.lagerort_id
   ,t1.dat
   ,t1.gp_id
   ,t1.menge_lgbest_erp_frei_bme AS ds_vz_bestand_menge_frei
   ,t1.menge_lgbest_erp_qual_bme AS ds_vz_bestand_menge_qual
   ,t1.menge_lgbest_erp_gesamt_bme AS ds_vz_bestand_menge_ges

   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   ,CASE WHEN t2.wrg_typ_id = 1 THEN t1.BETRAG_EK_NETTO_LGBEST_ERP_FREI
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =0 THEN t1.BETRAG_EK_NETTO_LGBEST_ERP_FREI_KONZ
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =1 THEN t1.BETRAG_EK_NETTO_LGBEST_ERP_FREI * t1.umrechnungskurs_hist
         END AS ds_vz_bestand_ekn_frei
   ,CASE WHEN t2.wrg_typ_id = 1 THEN t1.BETRAG_EK_NETTO_LGBEST_ERP_QUAL
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =0 THEN t1.BETRAG_EK_NETTO_LGBEST_ERP_QUAL_KONZ
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =1 THEN t1.BETRAG_EK_NETTO_LGBEST_ERP_QUAL * t1.umrechnungskurs_hist
         END AS ds_vz_bestand_ekn_qual

   ,COALESCE(ds_vz_bestand_ekn_frei,0) + COALESCE(ds_vz_bestand_ekn_qual,0) AS ds_vz_bestand_ekn_ges

    ,CASE WHEN t2.wrg_typ_id = 1 THEN t1.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =0 THEN t1.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI_KONZ
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =1 THEN t1.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI * t1.umrechnungskurs_hist
         END AS ds_vz_bestand_klep_frei
   ,CASE WHEN t2.wrg_typ_id = 1 THEN t1.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_QUAL
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =0 THEN t1.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_QUAL_KONZ
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =1 THEN t1.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_QUAL * t1.umrechnungskurs_hist
         END AS ds_vz_bestand_klep_qual

   ,COALESCE(ds_vz_bestand_klep_frei,0) + COALESCE(ds_vz_bestand_klep_qual,0)  AS ds_vz_bestand_klep_ges

   ,CASE WHEN t2.wrg_typ_id = 1 THEN t1.BETRAG_EK_MEP_OLK_LGBEST_ERP_FREI
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =0 THEN t1.BETRAG_EK_MEP_OLK_LGBEST_ERP_FREI_KONZ
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =1 THEN t1.BETRAG_EK_MEP_OLK_LGBEST_ERP_FREI * t1.umrechnungskurs_hist
         END AS ds_vz_bestand_mep_olk_frei
   ,CASE WHEN t2.wrg_typ_id = 1 THEN t1.BETRAG_EK_MEP_OLK_LGBEST_ERP_QUAL
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =0 THEN t1.BETRAG_EK_MEP_OLK_LGBEST_ERP_QUAL_KONZ
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =1 THEN t1.BETRAG_EK_MEP_OLK_LGBEST_ERP_QUAL * t1.umrechnungskurs_hist
         END AS ds_vz_bestand_mep_olk_qual

   ,COALESCE(ds_vz_bestand_mep_olk_frei,0) + COALESCE(ds_vz_bestand_mep_olk_qual,0)  AS ds_vz_bestand_mep_olk_ges

   ,CASE WHEN t2.wrg_typ_id = 1 THEN t1.BETRAG_VK_NETTO_LGBEST_ERP_FREI
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =0 THEN t1.BETRAG_VK_NETTO_LGBEST_ERP_FREI_KONZ
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =1 THEN t1.BETRAG_VK_NETTO_LGBEST_ERP_FREI * t1.umrechnungskurs_hist
         END AS ds_vz_bestand_vkn_frei
   ,CASE WHEN t2.wrg_typ_id = 1 THEN t1.BETRAG_VK_NETTO_LGBEST_ERP_QUAL
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =0 THEN t1.BETRAG_VK_NETTO_LGBEST_ERP_QUAL_KONZ
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =1 THEN t1.BETRAG_VK_NETTO_LGBEST_ERP_QUAL * t1.umrechnungskurs_hist
         END AS ds_vz_bestand_vkn_qual
   ,CASE WHEN t2.wrg_typ_id = 1 THEN t1.BETRAG_VK_NETTO_LGBEST_ERP_GESAMT
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =0 THEN t1.BETRAG_VK_NETTO_LGBEST_ERP_GESAMT_KONZ
         WHEN t2.wrg_typ_id = 0 AND t2.berichtskurs_typ_id =1 THEN t1.BETRAG_VK_NETTO_LGBEST_ERP_GESAMT * t1.umrechnungskurs_hist
         END AS ds_vz_bestand_vkn_ges
         
   FROM DBP_MSI_V_VIEW.v_lagerbestand_erp_tag_SUM t1
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu t2
   WHERE t1.nb_id = -111
   AND t1.dat < CURRENT_DATE();