CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_F_MARKT_BESTAND_ERP_PER_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
   WRG_ID,
	GJMO,
	VK_ZVKP,
	VKNT_ZVKP
	) AS
--19.10.2023, prescherad, SPEC0216613, Neuanlage
--12.04.2024, prescherad, SPEC0243592, Umbau auf Monatsaggregat für Bestand und Einschränkung auf Mandant_1 1
--14.05.2024, prescherad, SPEC0216613, Mengen für Leergut aus MARCH dazujoinen
   SELECT 
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.art_id,
   v01.wrg_id,
   v01.gjmo,
   CAST ((v01.menge_lgbest_erp_frei_bme + v01.menge_lgbest_erp_umlag_bme + v01.menge_lgbest_erp_qual_bme + v01.menge_lgbest_erp_nf_charge_bme + v01.menge_lgbest_erp_gesp_bme+v01.menge_lgbest_erp_ret_gesp_bme+ZEROIFNULL(v09.Menge_Leergut)) * v02.vk_brutto AS DECIMAL(18,4)) AS VK_ZVKP,
   CASE 
   WHEN v01.nb_id = 0 THEN 
   CAST ((v01.menge_lgbest_erp_frei_bme + v01.menge_lgbest_erp_umlag_bme + v01.menge_lgbest_erp_qual_bme + v01.menge_lgbest_erp_nf_charge_bme + v01.menge_lgbest_erp_gesp_bme+v01.menge_lgbest_erp_ret_gesp_bme+ZEROIFNULL(v09.Menge_Leergut)) * (v02.vk_brutto - v02.vk_brutto*v06.mwst/100) AS DECIMAL(18,4))
   WHEN v01.nb_id = -111 THEN 
   CAST ((v01.menge_lgbest_erp_frei_bme + v01.menge_lgbest_erp_umlag_bme + v01.menge_lgbest_erp_qual_bme + v01.menge_lgbest_erp_nf_charge_bme + v01.menge_lgbest_erp_gesp_bme+v01.menge_lgbest_erp_ret_gesp_bme+ZEROIFNULL(v09.Menge_Leergut)) * v07.betrag_vk_netto_vz AS DECIMAL(18,4))
   ELSE 0
   END AS VKNT_ZVKP,
   
   FROM DBP_VIEW.V_BESTAND_ERP_MONAT_1 v01
   JOIN DBP_VIEW.V_MONAT_1 v12
   ON v01.gjmo=v12.gjmo
   
   --ERmittlung VK_1 Brutto
   LEFT JOIN dbp_view.v_art_wup_vk_per_1 v02
   ON  v01.mandant_id = V02.mandant_id
   AND v01.art_id = v02.art_id   
   AND v01.wup_id = v02.wup_id  
   AND v01.nb_id = v02.nb_id
   AND v12.max_dat BETWEEN v02.dat_von AND v02.dat_bis

   --Filialebene NB_ID=0 VK_1 NETTO
   JOIN DBP_VIEW.V_ART_PER_1 v05
   ON v01.mandant_id = v05.mandant_id
   AND v01.art_id = v05.art_id 
   AND v12.max_dat BETWEEN v05.dat_von AND v05.dat_bis
  
   -- ermittlung des MWST Schlüssels   
   JOIN DBP_VIEW.V_MWST_PER_1 V06
   ON v05.Mandant_ID=v06.Mandant_ID
   AND v05.MWST_ID=v06.MWST_ID
   AND v06.dat_bis = '9999-12-31'
 
   --Lagerebene NB_ID=111 VK_1 NETTO
   LEFT JOIN DBP_VIEW.V_LAGERBEW_DET_1 v07
   ON v01.mandant_id = v07.mandant_id
   AND v01.wup_id=v07.wup_id
   AND v01.NB_ID=v07.nb_id
   AND v01.art_id = v07.art_id 
   AND v12.max_dat = v07.dat_buch
   AND v07.NB_ID='-111'

   -- Mengen für Leergut aus MARCH dazujoinen
   LEFT JOIN (
   SELECT v10.mandant_id, v10.wup_id, v10.art_id,v10.gjmo, v11.wg_id,SUM(menge_bestand_geb_leergut) AS Menge_Leergut
   FROM dbp_data.art_wup_status_periode_1 v10
   JOIN dbp_data.art_wg_zu_per_1 v11
   ON v10.mandant_id=v11.mandant_id AND
   v10.art_id=v11.art_id AND
   v11.arthiertyp_id=2 AND
   v11.dat_bis='9999-12-31'
   WHERE v10.mandant_id=1 
   AND (menge_bestand_geb_leergut)<>0
   GROUP BY 1,2,3,4,5
   ) v09
  
   ON v01.mandant_id=v09.mandant_id
   AND v01.art_id=v09.art_id
   AND v01.wup_id=v09.wup_id
   AND v01.gjmo=v09.gjmo;
  
   --WHERE v01.Mandant_id=1 ;