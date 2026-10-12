CREATE OR REPLACE VIEW P_LEW_BIL.V_ITEM_VAT_ACT_2 as
   /*	
   #DescStart#	
   #$Revision: 13459 $, $LastChangedBy: mueding $	
   #SubjectAreas#: Artikelstamm	
   #DescEnd#	
   */	
   SELECT	
      client_id,	
   item_sid,	
   country_pol_cd,	
   vat_id,	
   vat_value,	
   vat_descr	
   FROM	
   (	
     SELECT	
        s.client_id,	
   s.item_sid,	
   s.country_pol_cd,	
   s.vat_id,	
   s.vat_value,	
   s.vat_descr,	
   s.dwh_valid_from,	
   s.dwh_valid_to,	
   CASE WHEN Current_Date BETWEEN c.migration_dat_valid_from AND c.migration_dat_valid_to	
             THEN 'SAP  ' /* Aktuelles Elwis Land_2 */	
             ELSE 'X_SAP' /* Wawi Land_2 oder Ex Elwis Land_2 */	
        END AS vat_source	
     FROM p_lew_bil.v_item_vat_hist_sap_2 s	
   INNER JOIN p_lew_core_ac.v_client_migration_per_2 c	
   ON s.client_id = c.client_id	
	
   WHERE Current_Date BETWEEN s.dwh_valid_from AND s.dwh_valid_to	
	
   UNION ALL	
	
   SELECT	
      client_id,	
   item_sid,	
   country_pol_cd,	
   vat_id,	
   vat_value,	
   vat_descr,	
   dwh_valid_from,	
   dwh_valid_to,	
   'WAWI ' vat_source	
     FROM p_lew_bil.v_item_vat_hist_wawi_2	
	
     WHERE Current_Date BETWEEN dwh_valid_from AND dwh_valid_to	
   ) vat	
   QUALIFY Row_Number() Over (PARTITION BY client_id,item_sid ORDER BY vat_source ASC, dwh_valid_from DESC NULLS LAST, vat_value DESC NULLS LAST, vat_id DESC NULLS LAST)=1	

;