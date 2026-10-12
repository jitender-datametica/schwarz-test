/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_ewm_bestand_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2025-05-23      Michal Kubica           Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    View for EWM Bestand report
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_ewm_bestand_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id OPTIONS(description='Warehouse ID'),
storage_type OPTIONS(description='Storage Type'), article_nr OPTIONS(description='Product ID'), article_description
OPTIONS(description='Product Short Description'), quan OPTIONS(description='Quantity'), unit_1
OPTIONS(description='Base Unit_1 of Measure'), inhalt_karton OPTIONS(description='The content of the carton'), karton_euro
OPTIONS(description='Karton Euro'), quan_cases OPTIONS(description='Quantity Cases'), dwh_updated
OPTIONS(description='Latest update time')) AS WITH EWM_BESTAND AS (SELECT A.client_id,
   A.wh_id,
   A.lgtyp,
   A.matnr,
   A.maktx,
   A.quan,
   A.unit_1,
   B.inhalt_karton,
   B.karton_euro,
   A.dwh_updated
  FROM ldl_logop_data.t_sapewm_physicalstock_1 AS A
   LEFT JOIN ldl_logop_data.t_wawi_artikel_1 AS B ON A.client_id = B.client_id AND A.matnr = B.artikelnr
  WHERE CURRENT_DATE BETWEEN A.dwh_valid_from AND A.dwh_valid_to
   AND NOT A.deleted_fg) (SELECT client_id,
   wh_id,
   lgtyp,
   matnr,
   maktx,
   quan,
   unit_1,
   inhalt_karton,
   karton_euro,
    CASE
    WHEN unit_1 = 'PC'
    THEN quan / CAST(inhalt_karton AS FLOAT64)
    ELSE NULL
    END AS quan_cases,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dwh_updated
  FROM EWM_BESTAND);