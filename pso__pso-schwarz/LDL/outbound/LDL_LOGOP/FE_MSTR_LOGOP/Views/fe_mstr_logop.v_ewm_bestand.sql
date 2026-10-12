/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_ewm_bestand
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


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_ewm_bestand (client_id
OPTIONS(description='Client id - calculated based on the country code'), wh_id OPTIONS(description='Warehouse ID'),
storage_type OPTIONS(description='Storage Type'), article_nr OPTIONS(description='Product ID'), article_description
OPTIONS(description='Product Short Description'), quan OPTIONS(description='Quantity'), unit
OPTIONS(description='Base Unit of Measure'), inhalt_karton OPTIONS(description='The content of the carton'), karton_euro
OPTIONS(description='Karton Euro'), quan_cases OPTIONS(description='Quantity Cases'), dwh_updated
OPTIONS(description='Latest update time')) AS WITH EWM_BESTAND AS (SELECT A.client_id,
   A.wh_id,
   A.lgtyp,
   A.matnr,
   A.maktx,
   A.quan,
   A.unit,
   B.inhalt_karton,
   B.karton_euro,
   A.dwh_updated
  FROM ldl_logop_data.t_sapewm_physicalstock AS A
   LEFT JOIN ldl_logop_data.t_wawi_artikel AS B ON A.client_id = B.client_id AND A.matnr = B.artikelnr
  WHERE CURRENT_DATE BETWEEN A.dwh_valid_from AND A.dwh_valid_to
   AND NOT A.deleted_fg) (SELECT client_id,
   wh_id,
   lgtyp,
   matnr,
   maktx,
   quan,
   unit,
   inhalt_karton,
   karton_euro,
    CASE
    WHEN unit = 'PC'
    THEN quan / CAST(inhalt_karton AS FLOAT64)
    ELSE NULL
    END AS quan_cases,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dwh_updated
  FROM EWM_BESTAND);