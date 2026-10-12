/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_lpv_area
Description		|	LPV - prepared view on source table
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lpv_area (client_id
OPTIONS(description='Client id - calculated based on the country code'), lidl_ctry
OPTIONS(description='Country code. Original field name bic_zmlila'), src_sys OPTIONS(description='source_system: LPV'),
wh_id OPTIONS(description='wh_nr as a digit Source warehouse number (datastore_data:lagernummer)'), area_nr
OPTIONS(description='area_number (datastore_data:area_number'), area_desc
OPTIONS(description='area_description (datastore_data:area_description)'), reserve_area_nr
OPTIONS(description='Location ID of the reserve area. FK: References LPV.BEREICH.NR. Original name - RESBEREICH'),
dwh_load_id OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `LPV - PREPARED VIEW ON BASE TABLE`) AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_id,
 area_nr,
  CASE
  WHEN client_id = 12 AND wh_id IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
          25, 26) AND area_nr = 700 OR client_id = 12 AND wh_id IN (5, 8) AND area_nr = 702 OR client_id = 12 AND wh_id
        IN (2, 4, 6, 7, 11, 16, 18, 20, 24, 26) AND area_nr = 703 OR client_id = 12 AND wh_id IN (3, 9, 10, 12, 13, 14,
        17, 19, 21, 22, 23, 25, 27) AND area_nr = 704 OR client_id = 12 AND wh_id = 15 AND area_nr = 709
  THEN 'Reserve DETAIL'
  WHEN client_id = 12 AND wh_id IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
      25, 26, 27) AND area_nr = 701
  THEN 'Reserve FRAIS'
  WHEN client_id = 12 AND wh_id IN (2, 3, 4, 6, 7, 9, 10, 11, 12, 13, 14, 15, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27)
       AND area_nr = 702 OR client_id = 12 AND wh_id = 2 AND area_nr = 704 OR client_id = 12 AND wh_id = 5 AND area_nr =
       707 OR client_id = 12 AND wh_id = 17 AND area_nr = 709 OR client_id = 12 AND wh_id IN (8, 16) AND area_nr = 706
  THEN 'Reserve SURGELE'
  WHEN client_id = 12 AND wh_id IN (3, 9, 10, 12, 14, 17, 19, 21, 23, 25, 27) AND area_nr = 703 OR client_id = 12 AND
         wh_id = 4 AND area_nr = 707 OR client_id = 12 AND wh_id = 24 AND area_nr = 704 OR client_id = 12 AND wh_id IN (8
        , 16) AND area_nr = 705 OR client_id = 12 AND wh_id = 11 AND area_nr = 706
  THEN 'Reserve CHOCO'
  WHEN client_id = 12 AND wh_id IN (2, 3, 6, 7, 8, 10, 13, 19, 24, 25, 27) AND area_nr = 708 OR client_id = 12 AND wh_id
             = 17 AND area_nr = 702 OR client_id = 12 AND wh_id = 22 AND area_nr = 703 OR client_id = 12 AND wh_id IN (15
           , 18) AND area_nr = 704 OR client_id = 12 AND wh_id IN (5, 26) AND area_nr = 705 OR client_id = 12 AND wh_id
        IN (4, 6, 9, 20) AND area_nr = 706 OR client_id = 12 AND wh_id IN (11, 12, 14, 22) AND area_nr = 707 OR
      client_id = 12 AND wh_id IN (21, 23, 24) AND area_nr = 709
  THEN 'Reserve NF'
  WHEN client_id = 12 AND wh_id = 13 AND area_nr = 703 OR client_id = 12 AND wh_id = 15 AND area_nr = 706 OR client_id =
      12 AND wh_id = 23 AND area_nr = 708
  THEN 'Reserve BLOCK'
  WHEN client_id = 12 AND wh_id IN (3, 6, 10, 13, 19, 25, 27) AND area_nr = 709 OR client_id = 12 AND wh_id = 24 AND
         area_nr = 710 OR client_id = 12 AND wh_id IN (4, 9, 11, 12, 14, 15, 21) AND area_nr = 708 OR client_id = 12 AND
        wh_id IN (17, 20) AND area_nr = 707 OR client_id = 12 AND wh_id IN (5, 18, 22, 23, 26) AND area_nr = 706 OR
      client_id = 12 AND wh_id = 7 AND area_nr = 704
  THEN 'Reserve ACTION'
  WHEN client_id = 12 AND wh_id = 19 AND area_nr = 710
  THEN 'Reserve ACTION FREEZER'
  WHEN client_id = 12 AND wh_id = 13 AND area_nr = 706
  THEN 'Reserve ACTION AMBIENT'
  WHEN client_id = 12 AND wh_id IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
         25, 26, 27) AND area_nr = 1 OR client_id = 12 AND wh_id IN (5, 8, 16) AND area_nr = 3 OR client_id = 12 AND
       wh_id IN (2, 4, 6, 7, 11, 18, 20, 24, 26) AND area_nr = 4 OR client_id = 12 AND wh_id IN (3, 9, 10, 12, 13, 14,
       17, 19, 21, 22, 23, 25, 27) AND area_nr = 5
  THEN 'Picking DETAIL'
  WHEN client_id = 12 AND wh_id IN (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
        25, 26, 27) AND area_nr = 2 OR client_id = 12 AND wh_id = 15 AND area_nr = 4 OR client_id = 12 AND wh_id IN (19
       , 24) AND area_nr = 7
  THEN 'Picking FRAIS'
  WHEN client_id = 12 AND wh_id = 2 AND area_nr = 5 OR client_id = 12 AND wh_id IN (5, 17) AND area_nr = 9 OR client_id
       = 12 AND wh_id IN (8, 16) AND area_nr = 6 OR client_id = 12 AND wh_id IN (2, 3, 4, 6, 7, 9, 10, 11, 12, 13, 14,
       15, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27) AND area_nr = 3
  THEN 'Picking SURGELE'
  WHEN client_id = 12 AND wh_id = 4 AND area_nr = 9 OR client_id = 12 AND wh_id IN (8, 11, 16, 24) AND area_nr = 5 OR
      client_id = 12 AND wh_id IN (3, 9, 10, 12, 14, 17, 19, 21, 23, 25, 27) AND area_nr = 4
  THEN 'Picking CHOCO'
  WHEN client_id = 12 AND wh_id IN (12, 21, 23, 24) AND area_nr = 9 OR client_id = 12 AND wh_id IN (2, 3, 6, 7, 8, 9, 10
            , 13, 14, 19, 24, 25, 27) AND area_nr = 8 OR client_id = 12 AND wh_id = 12 AND area_nr = 7 OR client_id = 12
          AND wh_id IN (4, 11, 20, 26) AND area_nr = 6 OR client_id = 12 AND wh_id IN (5, 15, 18) AND area_nr = 5 OR
       client_id = 12 AND wh_id = 22 AND area_nr = 4 OR client_id = 12 AND wh_id = 17 AND area_nr = 3
  THEN 'Picking NF'
  WHEN client_id = 12 AND wh_id = 23 AND area_nr = 8
  THEN 'Picking BLOCK'
  WHEN client_id = 12 AND wh_id = 24 AND area_nr = 10 OR client_id = 12 AND wh_id IN (3, 6, 8, 9, 10, 13, 14, 19, 25, 27
          ) AND area_nr = 9 OR client_id = 12 AND wh_id IN (4, 11, 12, 15, 17, 18, 20, 21, 22, 26) AND area_nr = 8 OR
       client_id = 12 AND wh_id IN (5, 23) AND area_nr = 6 OR client_id = 12 AND wh_id = 7 AND area_nr = 5
  THEN 'Picking ACTION'
  WHEN client_id = 12 AND wh_id = 19 AND area_nr = 10
  THEN 'Picking ACTION FREEZER'
  WHEN area_nr = 0 AND area_descr IS NULL
  THEN 'Nachschub GZ'
  ELSE area_descr
  END AS area_desc,
 reserve_area_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_lpv_area
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND NOT deleted_fg;