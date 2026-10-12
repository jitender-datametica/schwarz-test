/*
====================================================================================================
Division		    |	Lidl
Solution		    |	Operational Logistics (LOGOP)
DB schema			|	fe_mstr_logop.
DB table/view		|	v_wamas_dashboard_stapleranfragen_1
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wamas_dashboard_stapleranfragen_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), lagerzone_nr
OPTIONS(description='Lagerzone Nummer'), tanr OPTIONS(description='Transport number'), ksnr
OPTIONS(description='Commission number. PK/FK'), status_1 OPTIONS(description='status_1 of the transport'), start_date
OPTIONS(description='date when a transport is started'), end_date OPTIONS(description='date when a transport is over'),
lieferdatum OPTIONS(description='delivery date'), artikelnr OPTIONS(description='article number'), dwh_updated
OPTIONS(description='Last update of table'))
OPTIONS(DESCRIPTION = `THIS IS A VIEW FOR WAMAS DASHBOARD TO CALCULATE THE NUMBER OF THE DRIVER ORDER`) AS SELECT TPA.client_id
 ,
 TPA.wh_id,
 TPA.lagerzone_nr,
 TPA.tanr,
 TPA.ksnr,
 TPA.status_1,
 TPA.start_date,
 TPA.end_date,
 VPLK.lieferdatum,
 TPAP.artikelnr,
 TPA.dwh_updated
FROM ldl_logop_data.t_wamas_tpa_1 AS TPA
 LEFT JOIN ldl_logop_data.t_wamas_tpap_1 AS TPAP ON TPA.client_id = TPAP.client_id AND TPA.wh_id = TPAP.wh_id AND TPA.tanr
      = TPAP.tanr AND CURRENT_DATE BETWEEN TPAP.dwh_valid_from AND TPAP.dwh_valid_to AND NOT TPAP.deleted_fg
 LEFT JOIN ldl_logop_data.t_wamas_vplk_1 AS VPLK ON TPA.client_id = VPLK.client_id AND TPA.wh_id = VPLK.wh_id AND TPA.ksnr
       = VPLK.ksnr AND TPA.lagerzone_nr = VPLK.laznr AND CURRENT_DATE BETWEEN VPLK.dwh_valid_from AND VPLK.dwh_valid_to
  AND NOT VPLK.deleted_fg
WHERE TPA.status_1 IN ('SENDEN')
 AND CURRENT_DATE BETWEEN TPA.dwh_valid_from AND TPA.dwh_valid_to
 AND TPAP.artikelnr NOT IN ('00000000000000000000')
 AND NOT TPA.deleted_fg;