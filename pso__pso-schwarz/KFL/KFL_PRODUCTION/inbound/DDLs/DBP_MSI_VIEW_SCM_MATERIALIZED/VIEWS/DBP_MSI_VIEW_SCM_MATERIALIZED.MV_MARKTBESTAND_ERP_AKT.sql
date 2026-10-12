create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_MARKTBESTAND_ERP_AKT(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	MENGE_LGBEST_ERP_FREI_BME
) as

   SELECT 
   v01.mandant_id, 
  
  
   v05.aktuell_wup_id wup_id, 
   v01.nb_id, art_id, menge_lgbest_erp_frei_bme
   FROM dbp_view.v_marktbestand_erp_delta v01
   INNER JOIN dbp_view.v_wup v05
   ON v05.mandant_id = v01.mandant_id
   
   AND v05.wup_id = v01.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0));