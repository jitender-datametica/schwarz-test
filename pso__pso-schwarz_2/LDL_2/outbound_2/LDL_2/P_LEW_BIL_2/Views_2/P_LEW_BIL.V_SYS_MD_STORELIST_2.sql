/* #DescStart#	
#$Revision: 10789 $, $LastChangedBy: stoberl $	
#SubjectAreas#:
Store Opening-Dates according to OSO /MD-Storelist/ KPGES
 #DescEnd# */
-- - KPGES value available with value = 0 -> any existing entries from the OSO/ MD StoreList shall not be valid and will not be displayed in the view

-- - KPGES value available with value = 1 -> take the dat_formdate and return it in the view as dat_open.

-- - If no value exists in KPGES -> the value is used from the OSO / MD StoreList (normal case)

-- The following condition defines if the store is displayed as open for that day. Rule:

CREATE OR REPLACE VIEW ldl_p_lew_bil.v_sys_md_storelist_2 (client_id, loc_sid_wh, loc_sid_store, dat_open, kpges_fg) AS
-- Source MD StoreList (common source)
 -- Source OSO and MD-Storelist(legacy)
 -- Source KPGES (for special cases)

SELECT client_id,
 loc_sid_wh,
 loc_sid_store,
 dat_open,
 kpges_fg
FROM (SELECT client_id,
   wh_loc_sid AS loc_sid_wh,
   st_loc_sid AS loc_sid_store,
   dat_open,
   MAX(kpges_fg) AS kpges_fg,
   MIN(val_indicator) AS a0
  FROM (SELECT client_id,
      wh_loc_sid,
      st_loc_sid,
      dat_open,
      1 AS val_indicator,
      0 AS kpges_fg
     FROM (SELECT oso.client_id,
         WH.wh_loc_sid,
         oso.store_loc_sid AS st_loc_sid,
         oso.cal_dt AS dat_open
        FROM (SELECT HIST.client_id,
           HIST.store_loc_sid,
           HIST.cal_dt
          FROM ldl_p_lew_core.t_location_opening_hour_hist_2 AS HIST
           INNER JOIN (SELECT DISTINCT LOC.loc_sid
            FROM ldl_p_lew_load.t_tcache_oso_orgaunits_2 AS ORGA
             INNER JOIN ldl_p_lew_core.t_country_2 AS C ON ORGA.bic_zmlila = C.src_country_lidl_cd
             INNER JOIN ldl_p_lew_core.t_location_2 AS LOC ON C.country_sid = LOC.client_id AND ORGA.organumber = LOC.src_orig_store_nr
               
            WHERE NOT ORGA.testorgaunit) AS temp ON HIST.store_loc_sid = temp.loc_sid AND HIST.store_open_fg = 1
             -- OSO sends entries for a date even when a store is not open so a filter is needed
) AS oso
         INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_skey_act_2 AS WH ON oso.client_id = WH.client_id AND oso.store_loc_sid
            = WH.st_loc_sid
        UNION ALL
        SELECT client_id,
         wh_loc_sid,
         st_loc_sid,
         dat_open
        FROM ldl_p_lew_process_ac.v_wawi_sys_md_storelist_2 AS ST) AS oso_md
     GROUP BY client_id,
      wh_loc_sid,
      st_loc_sid,
      dat_open
     UNION ALL
     SELECT IDAY.client_id,
      OSK.wh_loc_sid,
      OSK.st_loc_sid,
      IDAY.dat_formdate AS dat_open,
      IDAY.val_indicator,
      1 AS kpges_fg
     FROM ldl_p_lew_bil_ac.v_kpi_day_2 AS IDAY
      INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_skey_act_2 AS OSK ON IDAY.client_id = OSK.client_id AND IDAY.org_unit_nr
            = OSK.orig_store_nr AND IDAY.indicator_type_id = 1 AND IDAY.indicator_id = 400
         -- By definition, only the values 0 (closed store) and 1 (open store) are valid
 AND IDAY.val_indicator IN (0,
         1)) AS dt1
  GROUP BY client_id,
   loc_sid_wh,
   loc_sid_store,
   dat_open
  HAVING a0 = 1) AS t13;