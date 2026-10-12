create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW2.MV_F_VZ_BESTAND_ERP_PER(
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
	DS_VZ_BESTAND_EKN_FREI,
	DS_VZ_BESTAND_EKN_QUAL,
	DS_VZ_BESTAND_EKN_GES,
	DS_VZ_BESTAND_EKN_BNK_FREI,
	DS_VZ_BESTAND_EKN_BNK_QUAL,
	DS_VZ_BESTAND_EKN_BNK_GES,
	DS_VZ_BESTAND_KLEP_FREI,
	DS_VZ_BESTAND_KLEP_QUAL,
	DS_VZ_BESTAND_KLEP_GES,
	DS_VZ_BESTAND_MEP_FREI,
	DS_VZ_BESTAND_MEP_QUAL,
	DS_VZ_BESTAND_MEP_GES,
	DS_VZ_BESTAND_VKN_FREI,
	DS_VZ_BESTAND_VKN_QUAL,
	DS_VZ_BESTAND_VKN_GES
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_AIS_DE
 as
-- 2022-07-18, AP0125093, SPEC0161886, dknop, replacing join to art_wup_ek_zu_per
-- 2023-10-06, AP0163311, SPEC0207778 staeblern - neues Aggregat verwenden & Filterung auf bestimmte Lagerplaetze 
-- 2023-10-25, staeblern - Filterung auf die Lagerplaetze wieder entfenren
-- 2024-04-29, steablern - Lagerort mit aufnehmen & Group by & SUM entfernen
-- 2024-07-03, prescherad, SPEC0247099, Filterung auf dat < CURRENT_DATE()
 SELECT
    t1.mandant_id
   ,t1.wup_id
   ,t1.nb_id
   ,t1.art_id
   ,t1.lagerort_id
   ,0 AS stimming_id -- da fuer Lagerbestand rein fachlich keine Rolle spielt 
   ,t1.dat
   ,t1.wrg_id
   ,t1.gp_id
   ,t1.posten_id
   ,t1.menge_lgbest_erp_frei_bme AS ds_vz_bestand_menge_frei
   ,t1.menge_lgbest_erp_qual_bme AS ds_vz_bestand_menge_qual
   ,t1.menge_lgbest_erp_gesamt_bme AS ds_vz_bestand_menge_ges
   ,t1.BETRAG_EK_NETTO_LGBEST_ERP_FREI AS ds_vz_bestand_ekn_frei
   ,t1.BETRAG_EK_NETTO_LGBEST_ERP_QUAL AS ds_vz_bestand_ekn_qual
   ,t1.BETRAG_EK_NETTO_LGBEST_ERP_FREI + t1.BETRAG_EK_NETTO_LGBEST_ERP_QUAL  AS ds_vz_bestand_ekn_ges
   ,t1.BETRAG_EK_NETTO_BNK_LGBEST_ERP_FREI AS ds_vz_bestand_ekn_bnk_frei
   ,t1.BETRAG_EK_NETTO_BNK_LGBEST_ERP_QUAL AS ds_vz_bestand_ekn_bnk_qual
   ,t1.BETRAG_EK_NETTO_BNK_LGBEST_ERP_FREI + t1.BETRAG_EK_NETTO_BNK_LGBEST_ERP_QUAL  AS ds_vz_bestand_ekn_bnk_ges
   ,t1.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI AS ds_vz_bestand_klep_frei
   ,t1.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_QUAL AS ds_vz_bestand_klep_qual
   ,t1.BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI + t1.BETRAG_EK_NETTO_LGBEST_ERP_QUAL  AS ds_vz_bestand_klep_ges
   ,t1.BETRAG_EK_MEP_OLK_LGBEST_ERP_FREI AS ds_vz_bestand_mep_frei
   ,t1.BETRAG_EK_MEP_OLK_LGBEST_ERP_QUAL AS ds_vz_bestand_mep_qual
   ,t1.BETRAG_EK_MEP_OLK_LGBEST_ERP_FREI + t1.BETRAG_EK_MEP_OLK_LGBEST_ERP_QUAL  AS ds_vz_bestand_mep_ges
   ,t1.BETRAG_VK_NETTO_LGBEST_ERP_FREI AS ds_vz_bestand_vkn_frei
   ,t1.BETRAG_VK_NETTO_LGBEST_ERP_QUAL AS ds_vz_bestand_vkn_qual
   ,t1.BETRAG_VK_NETTO_LGBEST_ERP_GESAMT AS ds_vz_bestand_vkn_ges
   FROM DBP_MSI_V_VIEW.v_lagerbestand_erp_tag_SUM t1
   WHERE
   t1.mandant_id =1 AND t1.nb_id = -111
   AND t1.dat < CURRENT_DATE();
