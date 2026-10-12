CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_F_VZ_BESTAND_ERP_PER
(
   MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
   LAGERORT_ID,
	STIMMIG_ID,
	DAT,
	WRG_ID,
	GP_ID,
	POSTEN_ID,
	DS_VZ_BESTAND_MENGE_FREI,
	DS_VZ_BESTAND_MENGE_QUAL,
	DS_VZ_BESTAND_MENGE_GES,
	DS_VZ_BESTAND_EKN2_FREI,
	DS_VZ_BESTAND_EKN2_QUAL,
	DS_VZ_BESTAND_EKN2_GES,
	DS_VZ_BESTAND_EKN4_FREI,
	DS_VZ_BESTAND_EKN4_QUAL,
	DS_VZ_BESTAND_EKN4_GES,
	DS_VZ_BESTAND_VKN_FREI,
	DS_VZ_BESTAND_VKN_QUAL,
	DS_VZ_BESTAND_VKN_GES
)
AS
-- 2023-10-06, AP0163311, SPEC0207778 staeblern - neues Aggregat verwenden 
-- 2023-10-25, staeblern - Filterung auf die Lagerplaetze wieder entfenren
-- 2024-04-29, steablern - Lagerort mit aufnehmen & Group by & SUM entfernen 
-- 2024-07-03, prescherad, SPEC0247099, Filterung auf dat < CURRENT_DATE()
SELECT
   t01.mandant_id,
   t01.wup_id,
   t01.nb_id,
   t01.art_id,
   t01.lagerort_id,
   0 AS stimmig_id, -- da fuer Lagerbestand rein fachlich keine Rolle spielt 
   t01.dat,
   CASE WHEN t02.wrg_typ_id = 1
   THEN t01.wrg_id
   ELSE 'EUR'
   END AS _wrg_id,
   t01.gp_id,
   t01.posten_id,
   t01.menge_lgbest_erp_frei_bme                     AS ds_vz_bestand_menge_frei,
   t01.menge_lgbest_erp_qual_bme                     AS ds_vz_bestand_menge_qual,
   t01.menge_lgbest_erp_gesamt_bme                   AS ds_vz_bestand_menge_ges,
    -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CASE WHEN t02.wrg_typ_id = 1 THEN t01.BETRAG_EK_NETTONETTO_LGBEST_ERP_FREI
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 0 THEN t01.BETRAG_EK_NETTONETTO_LGBEST_ERP_FREI_KONZ
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 1 THEN t01.BETRAG_EK_NETTONETTO_LGBEST_ERP_FREI * t01.umrechnungskurs_hist
	    END AS ds_vz_bestand_ekn2_frei,
   CASE WHEN t02.wrg_typ_id = 1 THEN t01.BETRAG_EK_NETTONETTO_LGBEST_ERP_QUAL
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 0 THEN t01.BETRAG_EK_NETTONETTO_LGBEST_ERP_QUAL_KONZ
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 1 THEN t01.BETRAG_EK_NETTONETTO_LGBEST_ERP_QUAL * t01.umrechnungskurs_hist
        END AS ds_vz_bestand_ekn2_qual,
   CASE WHEN t02.wrg_typ_id = 1 THEN t01.menge_lgbest_erp_gesamt_bme * t01.EK_NETTONETTO
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 0 THEN t01.menge_lgbest_erp_gesamt_bme *t01.EK_NETTONETTO_KONZ
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 1 THEN (t01.menge_lgbest_erp_gesamt_bme *t01.EK_NETTONETTO) * t01.umrechnungskurs_hist
	    END AS ds_vz_bestand_ekn2_ges,
   CASE WHEN t02.wrg_typ_id = 1 THEN t01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 0 THEN t01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI_KONZ
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 1 THEN t01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI * t01.umrechnungskurs_hist
	    END AS DS_VZ_BESTAND_EKN4_FREI,
   CASE WHEN t02.wrg_typ_id = 1 THEN t01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_QUAL
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 0 THEN t01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_QUAL_KONZ
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 1 THEN t01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_QUAL * t01.umrechnungskurs_hist
        END AS DS_VZ_BESTAND_EKN4_QUAL,
   CASE WHEN t02.wrg_typ_id = 1 THEN t01.menge_lgbest_erp_gesamt_bme * t01.EK_EINSTANDSPREIS
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 0 THEN t01.menge_lgbest_erp_gesamt_bme *t01.EK_EINSTANDSPREIS_KONZ
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 1 THEN (t01.menge_lgbest_erp_gesamt_bme *t01.EK_EINSTANDSPREIS) * t01.umrechnungskurs_hist
	    END AS DS_VZ_BESTAND_EKN4_GES,
   CASE WHEN t02.wrg_typ_id = 1 THEN t01.BETRAG_VK_NETTO_LGBEST_ERP_FREI
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 0 THEN t01.BETRAG_VK_NETTO_LGBEST_ERP_FREI_KONZ
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 1 THEN t01.BETRAG_VK_NETTO_LGBEST_ERP_FREI * t01.umrechnungskurs_hist
	    END AS ds_vz_bestand_vkn_frei,
   CASE WHEN t02.wrg_typ_id = 1 THEN t01.BETRAG_VK_NETTO_LGBEST_ERP_QUAL
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 0 THEN t01.BETRAG_VK_NETTO_LGBEST_ERP_QUAL_KONZ
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 1 THEN t01.BETRAG_VK_NETTO_LGBEST_ERP_QUAL * t01.umrechnungskurs_hist
	    END AS ds_vz_bestand_vkn_qual,
   CASE WHEN t02.wrg_typ_id = 1 THEN t01.BETRAG_VK_NETTO_LGBEST_ERP_GESAMT
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 0 THEN t01.BETRAG_VK_NETTO_LGBEST_ERP_GESAMT_KONZ
        WHEN t02.wrg_typ_id = 0 AND t02.berichtskurs_typ_id = 1 THEN t01.BETRAG_VK_NETTO_LGBEST_ERP_GESAMT * t01.umrechnungskurs_hist
	    END AS ds_vz_bestand_vkn_ges
       
   FROM DBP_MSI_V_VIEW.v_lagerbestand_erp_tag_sum  t01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu t02
   WHERE t01.mandant_id <> 1
   AND t01.nb_id = -111
   AND t01.dat < CURRENT_DATE();