CREATE OR REPLACE VIEW p_lew_mart_cs.v_store_masterdata_exp AS
SELECT c.country_name         AS lidl_country_name
     , c.src_country_lidl_cd  AS lidl_country_cd
     , s.loc_sid              AS store_sid
     , s.src_orig_store_nr    AS store_nr
     , s.loc_name             AS store_name
     , a.street_name          AS street_name
     , a.house_nr             AS house_nr
     , a.city_name            AS city_name
     , a.zip                  AS zip
     , a.phone_nr             AS phone_nr
     , a.longitude            AS longitude
     , a.latitude             AS latitude
     , bh.opening_dt          AS real_open_dt
     , bh.closing_dt          AS close_dt
     , COALESCE(TO_NUMBER(TRIM(delivery_gl_region.client_id)|| TRIM(delivery_gl_region.gl_region_id)), -1*s.client_id )  AS delivery_region_sid
     , COALESCE(wosa.mis_store_active_fg,1) AS store_active_fg
     , sh.test_store_fg       AS test_store_fg

FROM p_lew_core.t_location  AS s

INNER JOIN p_lew_core.t_location_hist  AS sh
        ON sh.client_id = s.client_id
       AND  sh.loc_sid = s.loc_sid
       AND CURRENT_DATE BETWEEN sh.dwh_valid_from AND sh.dwh_valid_to
       AND sh.deleted_fg = 0
 
INNER JOIN p_lew_core.t_client  AS l
        ON l.client_id = s.client_id

INNER JOIN p_lew_core.t_country  AS c
        ON c.src_country_lidl_cd = l.src_country_lidl_cd

-- Dumitru Camerzan 16.08.2021:
-- Get the GEO coordinates from this table instead of T_ADDRESS.
-- The coordinates are written here by the IMS interface from T_ADDRESS (at 1:30am and 7am), but also updated by 98 REFDATA at 10pm.
-- T_ADDRESS is also loaded by the IMS interface (before loading this table), based on coordinates received from GIS via ESB.
-- As IMS interface will be decomissioned soon and new system LISY does not have/provide these coordinates,
-- for the moment this t_wawi table is reflect the final situation regarding GEO coordinates.
-- In far future the GEO-Coordinates Load and Data Model must be redesigned:
--    - The information should be contained only in T_ADDRESS, to avoid duplicating information in CORE, and v_wawi_ref_store_geo must be decommisioned.
--    - Data should be provided by LISY as part of the new Immo Interface or by GIS directly into T_ADDRESS.
--    - 98 Sharepoint Load should be challenged / questioned, if at all needed, as the idea is to get those coordinates automatically from
--      the master system GIS and not corrected manually via Tickets or Emails (which is sometimes the case today).

INNER JOIN p_lew_core_ac.v_location_building_hist AS lbh
        ON lbh.client_id = s.client_id
       AND lbh.loc_sid = s.loc_sid
       AND CURRENT_DATE BETWEEN lbh.dwh_valid_from AND lbh.dwh_valid_to
       AND lbh.deleted_fg = 0

INNER JOIN p_lew_core_ac.v_building_hist AS bh
        ON bh.client_id = lbh.client_id
       AND bh.building_sid = lbh.building_sid
       AND CURRENT_DATE BETWEEN bh.dwh_valid_from AND bh.dwh_valid_to
       AND bh.deleted_fg = 0
       AND ((CURRENT_DATE BETWEEN bh.opening_dt AND bh.closing_dt) OR     -- Export only open stores
            (CURRENT_DATE >= bh.opening_dt AND bh.closing_dt IS NULL) OR
            (CURRENT_DATE <= bh.closing_dt AND bh.opening_dt IS NULL))

LEFT OUTER JOIN p_lew_core_ac.v_address AS a
             ON a.client_id = bh.client_id
            AND a.addr_sid = bh.addr_sid

LEFT OUTER JOIN P_lew_core_ac.v_wawi_org_store_act AS wosa
        ON s.loc_sid = wosa.st_loc_sid
       AND s.client_id = wosa.client_id           

LEFT OUTER JOIN (SELECT owsk.client_id
                       ,owsk.wh_loc_sid
                       ,rgr.gl_region_id
                       ,rgr.gl_region_desc AS delivery_region_manager_name
                  FROM p_lew_core_ac.v_wawi_org_wh_skey AS owsk
                INNER JOIN p_lew_core_ac.v_wawi_ref_gl_region AS rgr
                        ON owsk.client_id = rgr.client_id
                       AND owsk.gl_region_id = rgr.gl_region_id
                WHERE owsk.aspect_id = 1
                ) AS delivery_gl_region
        ON wosa.wh_loc_sid = delivery_gl_region.wh_loc_sid
       AND wosa.client_id = delivery_gl_region.client_id


WHERE a.longitude IS NOT NULL AND a.latitude IS NOT NULL
;