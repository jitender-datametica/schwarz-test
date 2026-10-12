/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_wawi_bestand_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2025-05-23      Michal Kubica           Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    View for WAWI Bestand report
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wawi_bestand_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), wh_id OPTIONS(description='Warehouse ID'), date
OPTIONS(description='Date'), article_nr OPTIONS(description='Article'), menge OPTIONS(description='Menge'),
inhalt_karton OPTIONS(description='The content of the carton'), karton_euro OPTIONS(description='Karton Euro')) AS
SELECT A.client_id,
 A.wh_nr AS wh_id,
 A.datum AS date,
 A.artikelnr AS article_nr,
  A.menge - A.moving_stock AS menge,
 B.inhalt_karton,
 B.karton_euro
FROM ldl_logop_data.t_wawi_bestandartikel_2 AS A
 LEFT JOIN ldl_logop_data.t_wawi_artikel_2 AS B ON A.client_id = B.client_id AND A.artikelnr = B.artikelnr
WHERE CURRENT_DATE BETWEEN A.dwh_valid_from AND A.dwh_valid_to
 AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to
 AND DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) = DATE(A.datum)
 AND NOT A.deleted_fg
 AND NOT B.deleted_fg;