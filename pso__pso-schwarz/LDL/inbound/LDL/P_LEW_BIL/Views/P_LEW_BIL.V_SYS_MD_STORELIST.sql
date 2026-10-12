CREATE OR REPLACE VIEW P_LEW_BIL.V_SYS_MD_STORELIST
/*	
#DescStart#	
#$Revision: 10789 $, $LastChangedBy: stoberl $	
#SubjectAreas#:
Store Opening-Dates according to OSO /MD-Storelist/ KPGES
 #DescEnd#	
*/	
(	
  client_id	
 ,loc_sid_wh	
 ,loc_sid_store	
 ,dat_open	
 ,kpges_fg	
)	
AS	
   SELECT	
     dt1.client_id	
   ,dt1.wh_loc_sid AS loc_sid_wh	
   ,dt1.st_loc_sid AS loc_sid_store	
   ,dt1.dat_open	
   ,Max(dt1.kpges_fg) AS kpges_fg	
   FROM	
   (	
       -- Source MD StoreList (common source)	
       SELECT	
         md1.client_id	
   ,md1.wh_loc_sid	
   ,md1.st_loc_sid	
   ,md1.dat_open	
   ,CAST(1 AS DECIMAL(18,4)) AS val_indicator	
   ,CAST(0 AS BYTEINT) AS kpges_fg	
         FROM
        (
        --Source OSO and MD-Storelist(legacy)
        SELECT  
         oso_md.client_id
        ,oso_md.wh_loc_sid
        ,oso_md.st_loc_sid
        ,oso_md.dat_open
        FROM
        (
        SELECT 
        oso.client_id
        ,wh.wh_loc_sid
        ,oso.store_loc_sid AS st_loc_sid
        ,oso.cal_dt AS dat_open
        FROM
        (
        SELECT
        hist.client_id
        ,hist.store_loc_sid
        ,hist.cal_dt
        FROM p_lew_core.t_location_opening_hour_hist hist
        INNER JOIN
        (
        SELECT 
        DISTINCT 
        loc_sid
        FROM
        p_lew_load.t_tcache_oso_orgaunits orga
        INNER JOIN p_lew_core.t_country c
        ON orga.bic_zmlila=c.src_country_lidl_cd
        INNER JOIN
        p_lew_core.t_location loc
        ON c.country_sid=loc.client_id
        AND orga.organumber=loc.src_orig_store_nr
        WHERE orga.testorgaunit = 'FALSE' 
        ) AS
        temp
        
        ON temp.loc_sid=hist.store_loc_sid
        AND hist.store_open_fg = 1 --OSO sends entries for a date even when a store is not open so a filter is needed
        ) AS 
        oso
        
        INNER JOIN p_lew_core_ac.v_wawi_org_store_skey_act wh
        ON oso.client_id = wh.client_id
        AND oso.store_loc_sid = wh.st_loc_sid
                  
        UNION ALL
        SELECT 
        client_id
        ,wh_loc_sid
        ,st_loc_sid
        ,dat_open
        FROM p_lew_process_ac.v_wawi_sys_md_storelist st
        ) AS oso_md
        
        GROUP BY 1,2,3,4
        ) AS
         md1	
	
   UNION ALL	
   -- Source KPGES (for special cases)	
   SELECT	
     iday.client_id	
   ,osk.wh_loc_sid	
   ,osk.st_loc_sid	
   ,iday.dat_formdate AS dat_open	
   ,iday.val_indicator	
   ,CAST(1 AS BYTEINT) AS kpges_fg	
       FROM p_lew_bil_ac.v_kpi_day AS iday	
   INNER JOIN p_lew_core_ac.v_wawi_org_store_skey_act AS osk	
   ON  osk.client_id = iday.client_id	
   AND osk.orig_store_nr = iday.org_unit_nr	
   AND iday.indicator_type_id = 1	
   AND iday.indicator_id = 400	
   -- By definition, only the values 0 (closed store) and 1 (open store) are valid	
   AND iday.val_indicator IN (0,1)	
) AS dt1	
GROUP BY 1,2,3,4	
-- The following condition defines if the store is displayed as open for that day. Rule:	
--  - If no value exists in KPGES -> the value is used from the OSO / MD StoreList (normal case)	
--  - KPGES value available with value = 1 -> take the dat_formdate and return it in the view as dat_open.	
--  - KPGES value available with value = 0 -> any existing entries from the OSO/ MD StoreList shall not be valid and will not be displayed in the view	
HAVING MIN(dt1.val_indicator) = 1	
;