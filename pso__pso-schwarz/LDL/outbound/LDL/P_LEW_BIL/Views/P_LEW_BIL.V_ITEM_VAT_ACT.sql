/* #DescStart#	
   #$Revision: 13459 $, $LastChangedBy: mueding $	
   #SubjectAreas#: Artikelstamm	
   #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_vat_act AS SELECT client_id,
 item_sid,
 country_pol_cd,
 vat_id,
 vat_value,
 vat_descr
FROM (SELECT *
  FROM (SELECT S.client_id,
      S.item_sid,
      S.country_pol_cd,
      S.vat_id,
      S.vat_value,
      S.vat_descr,
      S.dwh_valid_from,
      S.dwh_valid_to,
       CASE
       WHEN CURRENT_DATE BETWEEN C.migration_dat_valid_from AND C.migration_dat_valid_to
       THEN 'SAP  ' /* Aktuelles Elwis Land */
       ELSE 'X_SAP' /* Wawi Land oder Ex Elwis Land */
       END AS vat_source
     FROM ldl_p_lew_bil.v_item_vat_hist_sap AS S
      INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS C ON S.client_id = C.client_id
     WHERE CURRENT_DATE BETWEEN S.dwh_valid_from AND S.dwh_valid_to
     UNION ALL
     SELECT client_id,
      item_sid,
      country_pol_cd,
      vat_id,
      vat_value,
      vat_descr,
      dwh_valid_from,
      dwh_valid_to,
      'WAWI ' AS vat_source
     FROM ldl_p_lew_bil.v_item_vat_hist_wawi
     WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING) ORDER BY vat_source
        IS NULL, vat_source, dwh_valid_from IS NULL, dwh_valid_from, vat_value IS NULL, vat_value, vat_id IS NULL,
        vat_id)) = 1) AS t4;