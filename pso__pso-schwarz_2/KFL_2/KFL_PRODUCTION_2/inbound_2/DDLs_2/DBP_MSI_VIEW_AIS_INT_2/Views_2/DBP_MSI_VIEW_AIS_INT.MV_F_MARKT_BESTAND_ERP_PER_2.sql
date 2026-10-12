CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_F_MARKT_BESTAND_ERP_PER_2
(
    MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	DAT,
	GP_ID,
     LAGERORT_ID,
	DS_MARKT_BESTAND_MENGE_FREI,
	DS_MARKT_BESTAND_MENGE_QUAL,
	DS_MARKT_BESTAND_MENGE_GESPERRT,
	DS_MARKT_BESTAND_MENGE_GES,
	DS_MARKT_BESTAND_EKN_FREI,
	DS_MARKT_BESTAND_EKN_QUAL,
     DS_MARKT_BESTAND_EKN_GESPERRT,
	DS_MARKT_BESTAND_EKN_GES,
	DS_MARKT_BESTAND_KLEP_FREI,
	DS_MARKT_BESTAND_KLEP_QUAL,
     DS_MARKT_BESTAND_KLEP_GESPERRT,
	DS_MARKT_BESTAND_KLEP_GES,
	DS_MARKT_BESTAND_MEP_OLK_FREI,
	DS_MARKT_BESTAND_MEP_OLK_QUAL,
	DS_MARKT_BESTAND_MEP_OLK_GESPERRT,
	DS_MARKT_BESTAND_MEP_OLK_GES,
	DS_MARKT_BESTAND_VKN_FREI,
	DS_MARKT_BESTAND_VKN_QUAL,
     DS_MARKT_BESTAND_VKN_GESPERRT,
	DS_MARKT_BESTAND_VKN_GES
)
AS
-- 20240416 staeblern: Neuerstellung der View (analog zu AIS KMO/DE)
--                     Zusatz DS_* bei den Kennzahlen bedeutet Distribution Service (da dies aus LIS kommt) 
-- AP0262165/SPEC0305742: Erweiterung um Lagerort_id
-- AP0288519/SPEC0328316 Erweiterung diverser Spalten / sschuecke 27.11.2025
SELECT
v01.mandant_id,
v01.wup_id,
v01.nb_id,
v01.art_id,
v01.dat,
v01.gp_id,
'0001' AS lagerort_id,
v01.menge_lgbest_erp_frei_bme AS ds_markt_bestand_menge_frei,
v01.menge_lgbest_erp_qual_bme AS ds_markt_bestand_menge_qual,
v01.menge_lgbest_erp_gesp_bme AS ds_markt_bestand_menge_gesperrt,
COALESCE(ds_markt_bestand_menge_frei,0) + COALESCE(ds_markt_bestand_menge_qual,0) AS ds_markt_bestand_menge_ges,

-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
CASE WHEN v02.wrg_typ_id = 1 THEN v01.BETRAG_EK_NETTO_LGBEST_ERP_FREI 
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.BETRAG_EK_NETTO_LGBEST_ERP_FREI_KONZ
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.BETRAG_EK_NETTO_LGBEST_ERP_FREI * v01.umrechnungskurs_hist
     END AS ds_markt_bestand_ekn_frei,
CASE WHEN v02.wrg_typ_id = 1 THEN v01.BETRAG_EK_NETTO_LGBEST_ERP_QUAL 
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.BETRAG_EK_NETTO_LGBEST_ERP_QUAL_KONZ
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.BETRAG_EK_NETTO_LGBEST_ERP_QUAL * v01.umrechnungskurs_hist
     END AS ds_markt_bestand_ekn_qual,
CASE WHEN v02.wrg_typ_id = 1 THEN (v01.menge_lgbest_erp_gesp_bme *  v01.EK_NETTO)
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN (v01.menge_lgbest_erp_gesp_bme *  v01.EK_NETTO_KONZ)
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN (v01.menge_lgbest_erp_gesp_bme *  (v01.EK_NETTO*v01.umrechnungskurs_hist))
     END AS ds_markt_bestand_ekn_gesperrt,

COALESCE(ds_markt_bestand_ekn_frei,0) + COALESCE(ds_markt_bestand_ekn_qual,0) + COALESCE(ds_markt_bestand_menge_gesperrt,0) AS ds_markt_bestand_ekn_ges,

CASE WHEN v02.wrg_typ_id = 1 THEN v01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI 
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI_KONZ
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI * v01.umrechnungskurs_hist
     END AS ds_markt_bestand_klep_frei,
CASE WHEN v02.wrg_typ_id = 1 THEN v01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_QUAL 
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_QUAL_KONZ
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_QUAL * v01.umrechnungskurs_hist
     END AS ds_markt_bestand_klep_qual,
 CASE WHEN v02.wrg_typ_id = 1 THEN (v01.menge_lgbest_erp_gesp_bme *  v01.EK_EINSTANDSPREIS)
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN (v01.menge_lgbest_erp_gesp_bme *  v01.EK_EINSTANDSPREIS_KONZ)
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN (v01.menge_lgbest_erp_gesp_bme *  (v01.EK_EINSTANDSPREIS*v01.umrechnungskurs_hist))
     END AS ds_markt_bestand_klep_gesperrt,

COALESCE(ds_markt_bestand_klep_frei,0) + COALESCE(ds_markt_bestand_klep_qual,0) + COALESCE(ds_markt_bestand_ekn_gesperrt,0) AS ds_markt_bestand_klep_ges,

CASE WHEN v02.wrg_typ_id = 1 THEN v01.BETRAG_EK_MEP_OLK_LGBEST_ERP_FREI 
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.BETRAG_EK_MEP_OLK_LGBEST_ERP_FREI_KONZ
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.BETRAG_EK_MEP_OLK_LGBEST_ERP_FREI * v01.umrechnungskurs_hist
     END AS ds_markt_bestand_mep_olk_frei,
CASE WHEN v02.wrg_typ_id = 1 THEN v01.BETRAG_EK_MEP_OLK_LGBEST_ERP_QUAL 
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.BETRAG_EK_MEP_OLK_LGBEST_ERP_QUAL_KONZ
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.BETRAG_EK_MEP_OLK_LGBEST_ERP_QUAL * v01.umrechnungskurs_hist
     END AS ds_markt_bestand_mep_olk_qual,
CASE WHEN v02.wrg_typ_id = 1 THEN (v01.menge_lgbest_erp_gesp_bme *  v01.EK_MEP_OLK)
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN (v01.menge_lgbest_erp_gesp_bme *  v01.EK_MEP_OLK_KONZ)
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN (v01.menge_lgbest_erp_gesp_bme *  (v01.EK_MEP_OLK*v01.umrechnungskurs_hist))
     END AS ds_markt_bestand_mep_olk_gesperrt,

COALESCE(ds_markt_bestand_mep_olk_frei,0) + COALESCE(ds_markt_bestand_mep_olk_qual,0) + COALESCE(ds_markt_bestand_mep_olk_gesperrt,0) AS ds_markt_bestand_mep_olk_ges,

CASE WHEN v02.wrg_typ_id = 1 THEN v01.BETRAG_VK_NETTO_LGBEST_ERP_FREI 
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.BETRAG_VK_NETTO_LGBEST_ERP_FREI_KONZ
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.BETRAG_VK_NETTO_LGBEST_ERP_FREI * v01.umrechnungskurs_hist
     END AS ds_markt_bestand_vkn_frei,
CASE WHEN v02.wrg_typ_id = 1 THEN v01.BETRAG_VK_NETTO_LGBEST_ERP_QUAL 
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN v01.BETRAG_VK_NETTO_LGBEST_ERP_QUAL_KONZ
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN v01.BETRAG_VK_NETTO_LGBEST_ERP_QUAL * v01.umrechnungskurs_hist
     END AS ds_markt_bestand_vkn_qual,
CASE WHEN v02.wrg_typ_id = 1 THEN (v01.menge_lgbest_erp_gesp_bme *  v01.VK_NETTO) 
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN (v01.menge_lgbest_erp_gesp_bme *  v01.VK_NETTO_KONZ)
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN (v01.menge_lgbest_erp_gesp_bme *  (v01.VK_NETTO*v01.umrechnungskurs_hist))
     END AS ds_markt_bestand_vkn_gesperrt,

COALESCE(ds_markt_bestand_vkn_frei,0) + COALESCE(ds_markt_bestand_vkn_qual,0) + COALESCE(ds_markt_bestand_vkn_gesperrt,0) AS ds_markt_bestand_vkn_ges

FROM DBP_MSI_DATA.MARKTBESTAND_ERP_TAG_SUM_2 v01
CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v02
WHERE v01.nb_id = 0 AND v01.dat < CURRENT_DATE();