CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_GP_WUP_NM_ZU_PER(
	MANDANT_ID,
	ART_ID,
	GP_ID,
	WUP_ID,
	NB_ID,
   WRG_ID,
	GJMO,
	EK_NETTO_BNK,
	EK_MEP,
	EINSTANDSPREIS,
	LOGISTIKKOSTENZUSCHLAG
	) AS  
    --19.10.2023, prescherad, SPEC0216613, Neuanlage
	 --14.03.2024, prescherad, SPEC0216613, Umbau auf EK Preise bewertet mit Bestand
    --12.04.2024, prescherad, SPEC0243592, Umbau auf Monatsaggregat für Bestand und Einschränkung auf Mandant 1
    --14.05.2024, prescherad, SPEC0216613, Mengen für Leergut aus MARCH dazujoinen
    --12-05.2025, prescherad, SPEC0306495, Umbau im Zuge von dynamic table und Performance
   SELECT
   v01.mandant_id, 
   v01.art_id, 
   v01.gp_id, 
   v01.wup_id,
   v01.nb_id,
   v03.wrg_id,
   v03.gjmo,
   CAST ((v03.menge_lgbest_erp_frei_bme + v03.menge_lgbest_erp_umlag_bme + v03.menge_lgbest_erp_qual_bme + v03.menge_lgbest_erp_nf_charge_bme + v03.menge_lgbest_erp_gesp_bme + v03.menge_lgbest_erp_ret_gesp_bme + ZEROIFNULL(v09.Menge_Leergut))* ek_netto_bnk AS DECIMAL(18,4)) AS ek_netto_bnk,
   CAST ((v03.menge_lgbest_erp_frei_bme + v03.menge_lgbest_erp_umlag_bme + v03.menge_lgbest_erp_qual_bme + v03.menge_lgbest_erp_nf_charge_bme + v03.menge_lgbest_erp_gesp_bme + v03.menge_lgbest_erp_ret_gesp_bme + ZEROIFNULL(v09.Menge_Leergut)) * ek_mep AS DECIMAL(18,4)) AS ek_mep,
   CAST ((v03.menge_lgbest_erp_frei_bme + v03.menge_lgbest_erp_umlag_bme + v03.menge_lgbest_erp_qual_bme + v03.menge_lgbest_erp_nf_charge_bme + v03.menge_lgbest_erp_gesp_bme + v03.menge_lgbest_erp_ret_gesp_bme + ZEROIFNULL(v09.Menge_Leergut)) * einstandspreis AS DECIMAL(18,4)) AS einstandspreis,
   CAST ((v03.menge_lgbest_erp_frei_bme + v03.menge_lgbest_erp_umlag_bme + v03.menge_lgbest_erp_qual_bme + v03.menge_lgbest_erp_nf_charge_bme + v03.menge_lgbest_erp_gesp_bme + v03.menge_lgbest_erp_ret_gesp_bme + ZEROIFNULL(v09.Menge_Leergut)) * logistikkostenzuschlag AS DECIMAL(18,4)) AS logistikkostenzuschlag,
   FROM DBP_MSI_VIEW_WWC.TBL_MV_ART_GP_WUP_NM_ZU_PER v01
  
   
   JOIN DBP_VIEW.V_BESTAND_ERP_MONAT v03  
   JOIN DBP_VIEW.V_MONAT v12
   ON v03.gjmo=v12.gjmo
   AND v03.mandant_id=v01.mandant_id
   AND v03.art_id=v01.art_id
   AND v03.wup_id=v01.wup_id
   AND v12.MAX_DAT BETWEEN v01.dat_von AND v01.dat_bis
   AND v12.akt_gj BETWEEN -2 AND 0
 
   -- Mengen für Leergut aus MARCH dazujoinen
   LEFT JOIN (
   SELECT v10.mandant_id, v10.wup_id, v10.art_id,v10.gjmo, v11.wg_id,SUM(menge_bestand_geb_leergut) AS Menge_Leergut
   FROM dbp_data.art_wup_status_periode v10
   JOIN dbp_data.art_wg_zu_per v11
   ON v10.mandant_id=v11.mandant_id AND
   v10.art_id=v11.art_id AND
   v11.arthiertyp_id=2 AND
   v11.dat_bis='9999-12-31'
   WHERE v10.mandant_id=1 
   AND (menge_bestand_geb_leergut)<>0
   GROUP BY 1,2,3,4,5
   ) v09
  
   ON v03.mandant_id=v09.mandant_id
   AND v03.art_id=v09.art_id
   AND v03.wup_id=v09.wup_id
   AND v03.gjmo=v09.gjmo;	
   
   --WHERE v03.Mandant_id=1;