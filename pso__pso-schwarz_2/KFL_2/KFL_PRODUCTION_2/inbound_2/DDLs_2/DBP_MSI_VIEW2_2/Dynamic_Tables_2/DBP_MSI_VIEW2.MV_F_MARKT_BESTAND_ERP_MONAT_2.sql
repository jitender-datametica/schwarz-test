CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_F_MARKT_BESTAND_ERP_MONAT_2
(
	ART_ID,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	GJMO,
	LAGERORT_ID,
	MENGE_LGBEST_ERP_FREI_BME,
	MENGE_LGBEST_ERP_UMLAG_BME,
	MENGE_LGBEST_ERP_QUAL_BME,
	MENGE_LGBEST_ERP_NF_CHARGE_BME,
	MENGE_LGBEST_ERP_GESP_BME,
	MENGE_LGBEST_ERP_RET_GESP_BME
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
t1.art_id, 
t1.mandant_id, 
t1.wup_id, 
t1.nb_id, 
t1.gjmo, 
t1.lagerort_id, 
t1.menge_lgbest_erp_frei_bme AS menge_lgbest_erp_frei_bme, 
t1.menge_lgbest_erp_umlag_bme AS menge_lgbest_erp_umlag_bme, 
t1.menge_lgbest_erp_qual_bme AS menge_lgbest_erp_qual_bme, 
t1.menge_lgbest_erp_nf_charge_bme AS menge_lgbest_erp_nf_charge_bme, 
t1.menge_lgbest_erp_gesp_bme AS menge_lgbest_erp_gesp_bme, 
t1.menge_lgbest_erp_ret_gesp_bme AS menge_lgbest_erp_ret_gesp_bme

FROM dbp_view.v_bestand_erp_monat_2 t1_2
WHERE t1.nb_id NOT IN (-111,99) 
AND   t1.mandant_id = 1;