CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_F_MARKT_BESTAND_ERP_PER_2
(

 MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	STIMMIG_ID,
	DAT,
	WRG_ID,
	GP_ID,
	POSTEN_ID,
	DS_MARKT_BESTAND_MENGE_FREI,
	DS_MARKT_BESTAND_MENGE_QUAL,
	DS_MARKT_BESTAND_MENGE_GESPERRT,
	DS_MARKT_BESTAND_MENGE_GES,
	DS_MARKT_BESTAND_EKN2_FREI,
	DS_MARKT_BESTAND_EKN2_QUAL,
    DS_MARKT_BESTAND_EKN2_GESPERRT,
	DS_MARKT_BESTAND_EKN2_GES,
	DS_MARKT_BESTAND_EKN4_FREI,
	DS_MARKT_BESTAND_EKN4_QUAL,
    DS_MARKT_BESTAND_EKN4_GESPERRT,
	DS_MARKT_BESTAND_EKN4_GES,
	DS_MARKT_BESTAND_VKN_FREI,
	DS_MARKT_BESTAND_VKN_QUAL,
    DS_MARKT_BESTAND_VKN_GESPERRT,
	DS_MARKT_BESTAND_VKN_GES
/* Folgende Spalten nicht in MSI referenzieren */

)
AS
--NSR3280102 Anpassung JOIN Bedingung um mandant_id, da Tabellen erweitert wurden / sschuecke 24.10.2022
--PRB0082220 Änderung des LEFT OUTER JOIN art_gp_nm_zu_per_2 auf INNER JOIN nach Rspr. Snowflake. Rowcount identisch / ssch1303 03.02.2023
--INC6091593 Filter auf nb_id = 0 hinzugefügt / sschuecke 13.03.2023 
-- 2023-10-06, AP0163311, SPEC0207778 staeblern - neues Aggregat verwenden 
-- 2024-01-10, NSR4194586 staeblern Filterung nur vortagesaktuelle Daten 
-- AP0288519/SPEC0328316 Erweiterung diverser Spalten / sschuecke 27.11.2025
    SELECT 
   
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.art_id,
   v01.relevant_fg AS stimmig_id,
   v01.dat,
   CASE WHEN v03.wrg_typ_id = 1 THEN v01.wrg_id ELSE 'EUR' END AS _wrg_id,
   v01.gp_id                                                       AS gp_id,
   v01.posten_id,
   v01.menge_lgbest_erp_frei_bme                                                AS ds_markt_bestand_menge_frei,
   v01.menge_lgbest_erp_qual_bme                                                AS ds_markt_bestand_menge_qual,
   v01.menge_lgbest_erp_gesp_bme                                                AS ds_markt_bestand_menge_gesperrt,
   CAST(v01.menge_lgbest_erp_frei_bme + v01.menge_lgbest_erp_qual_bme + v01.menge_lgbest_erp_gesp_bme AS NUMBER(38,5)) AS ds_markt_bestand_menge_ges,

   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CAST ( CASE WHEN v03.wrg_typ_id = 1 THEN v01.BETRAG_EK_NETTONETTO_LGBEST_ERP_FREI
               WHEN v03.wrg_typ_id = 1 AND v03.berichtskurs_typ_id = 0 THEN v01.BETRAG_EK_NETTONETTO_LGBEST_ERP_FREI_KONZ
               WHEN v03.wrg_typ_id = 1 AND v03.berichtskurs_typ_id = 1 THEN v01.BETRAG_EK_NETTONETTO_LGBEST_ERP_FREI * v01.umrechnungskurs_hist
			   END AS DECIMAL(18,4)) AS ds_markt_bestand_ekn2_frei,
   CAST ( CASE WHEN v03.wrg_typ_id = 1 THEN v01.BETRAG_EK_NETTONETTO_LGBEST_ERP_QUAL
               WHEN v03.wrg_typ_id = 1 AND v03.berichtskurs_typ_id = 0 THEN v01.BETRAG_EK_NETTONETTO_LGBEST_ERP_QUAL_KONZ
               WHEN v03.wrg_typ_id = 1 AND v03.berichtskurs_typ_id = 1 THEN v01.BETRAG_EK_NETTONETTO_LGBEST_ERP_QUAL * v01.umrechnungskurs_hist
			   END AS DECIMAL(18,4)) AS ds_markt_bestand_ekn2_qual,
   CAST ( CASE WHEN v03.wrg_typ_id = 1 THEN (v01.menge_lgbest_erp_gesp_bme * v01.EK_NETTONETTO)
               WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 0 THEN (v01.menge_lgbest_erp_gesp_bme * v01.EK_NETTONETTO_KONZ)
               WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 1 THEN (v01.menge_lgbest_erp_gesp_bme * (v01.EK_NETTONETTO*v01.umrechnungskurs_hist))
			   END AS DECIMAL(18,4)) AS ds_markt_bestand_ekn2_gesperrt,
               
   CAST ( ds_markt_bestand_ekn2_frei + ds_markt_bestand_ekn2_qual + ds_markt_bestand_ekn2_gesperrt AS DECIMAL(18,4)) AS ds_markt_bestand_ekn2_ges,
   
   CAST ( CASE WHEN v03.wrg_typ_id = 1 THEN v01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI
               WHEN v03.wrg_typ_id = 1 AND v03.berichtskurs_typ_id = 0 THEN v01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI_KONZ
               WHEN v03.wrg_typ_id = 1 AND v03.berichtskurs_typ_id = 1 THEN v01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI * v01.umrechnungskurs_hist
			   END AS DECIMAL(18,4)) AS DS_MARKT_BESTAND_EKN4_FREI,
   CAST ( CASE WHEN v03.wrg_typ_id = 1 THEN v01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_QUAL
               WHEN v03.wrg_typ_id = 1 AND v03.berichtskurs_typ_id = 0 THEN v01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_QUAL_KONZ
               WHEN v03.wrg_typ_id = 1 AND v03.berichtskurs_typ_id = 1 THEN v01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_QUAL * v01.umrechnungskurs_hist
			   END AS DECIMAL(18,4)) AS DS_MARKT_BESTAND_EKN4_QUAL,
   CAST ( CASE WHEN v03.wrg_typ_id = 1 THEN (v01.menge_lgbest_erp_gesp_bme * v01.EK_EINSTANDSPREIS)
               WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 0 THEN (v01.menge_lgbest_erp_gesp_bme * v01.EK_EINSTANDSPREIS_KONZ)
               WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 1 THEN (v01.menge_lgbest_erp_gesp_bme * (v01.EK_EINSTANDSPREIS*v01.umrechnungskurs_hist))
			   END AS DECIMAL(18,4)) AS DS_MARKT_BESTAND_EKN4_GESPERRT,
               
   CAST ( DS_MARKT_BESTAND_EKN4_FREI + DS_MARKT_BESTAND_EKN4_QUAL + DS_MARKT_BESTAND_EKN4_GESPERRT AS DECIMAL(18,4)) AS DS_MARKT_BESTAND_EKN4_GES,
   
   CAST ( CASE WHEN v03.wrg_typ_id = 1 THEN v01.BETRAG_VK_NETTO_LGBEST_ERP_FREI
               WHEN v03.wrg_typ_id = 1 AND v03.berichtskurs_typ_id = 0 THEN v01.BETRAG_VK_NETTO_LGBEST_ERP_FREI_KONZ
               WHEN v03.wrg_typ_id = 1 AND v03.berichtskurs_typ_id = 1 THEN v01.BETRAG_VK_NETTO_LGBEST_ERP_FREI * v01.umrechnungskurs_hist
			   END AS NUMBER(38,5))    AS ds_markt_bestand_vkn_frei,
   CAST ( CASE WHEN v03.wrg_typ_id = 1 THEN v01.BETRAG_VK_NETTO_LGBEST_ERP_QUAL
               WHEN v03.wrg_typ_id = 1 AND v03.berichtskurs_typ_id = 0 THEN v01.BETRAG_VK_NETTO_LGBEST_ERP_QUAL_KONZ
               WHEN v03.wrg_typ_id = 1 AND v03.berichtskurs_typ_id = 1 THEN v01.BETRAG_VK_NETTO_LGBEST_ERP_QUAL * v01.umrechnungskurs_hist
			   END AS NUMBER(38,5))    AS ds_markt_bestand_vkn_qual,
   CAST ( CASE WHEN v03.wrg_typ_id = 1 THEN (v01.menge_lgbest_erp_gesp_bme * v01.VK_NETTO)
               WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 0 THEN (v01.menge_lgbest_erp_gesp_bme * v01.VK_NETTO_KONZ)
               WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 1 THEN (v01.menge_lgbest_erp_gesp_bme * (v01.VK_NETTO*v01.umrechnungskurs_hist))
			   END AS NUMBER(38,5))    AS ds_markt_bestand_vkn_gesperrt,
               
   CAST(ds_markt_bestand_vkn_frei  + ds_markt_bestand_vkn_qual + ds_markt_bestand_vkn_gesperrt AS NUMBER(38,5))    AS ds_markt_bestand_vkn_ges 
   
   FROM DBP_MSI_DATA.MARKTBESTAND_ERP_TAG_SUM_2 v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v03
   WHERE v01.mandant_id <>1
   AND v01.nb_id = 0
   AND v01.dat < CURRENT_DATE();