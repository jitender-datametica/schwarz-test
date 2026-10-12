CREATE OR REPLACE VIEW P_LEW_BIL.V_20200129_WAREHOUSE
AS
/*
#DescStart#
#$Revision: 9162 $, $LastChangedBy: aarnold $
#SubjectAreas#  COEX  Organisationsstruktur
#DescEnd#
*/
SELECT
lctn.client_id,
lctn.loc_sid                 AS loc_sid_wh,
lctn.src_werks,
lctn.src_wh_id,
lctn.loc_name,
lctn.loc_name2,
lctn.loc_sid_successor_act,
lctn.country_pol_sid,
lctn.country_pol_cd,
lctn.customer_cd,
lctn.global_loc_ctry_cd,
lctn.global_loc_id,
lctn.global_loc_id_length,
lctn.global_loc_type_cd,
lctn.closing_dt,
lctn.opening_dt,
lctn.real_opening_dt,
lctn_h.sales_org_sid,
lctn_h.pur_org_sid,
lctn_h.addr_sid,
lctn_h.loc_sid_successor,
lctn_h.bus_cal_cd,
lctn_h.customer_district_cd,
lctn_h.region_cd,
lctn_h.archive_fg,
lctn_h.demand_plan_active_fg,
lctn_h.distribution_channel_cd,
lctn_h.assessment_area_cd,
lctn_h.division_cd,
lctn_h.deleted_fg,
lctn_h.dwh_valid_from,
lctn_h.dwh_valid_to,
CASE WHEN Current_Date BETWEEN lctn_h.dwh_valid_from AND lctn_h.dwh_valid_to
        THEN 1
        ELSE 0
   END AS dwh_actual_fg,
CASE WHEN lctn_h.deleted_fg = 0 AND Current_Date BETWEEN Coalesce(lctn.real_opening_dt, lctn.opening_dt, lctn.sap_creation_wrf1_dt)
             AND Coalesce(lctn.closing_dt, SNOWCONVERT.PUBLIC.INT_TO_DATE_UDF(80991231) /*** MSC-WARNING - MSCEWI2026 - CUSTOM UDF 'INT_TO_DATE_UDF' INSERTED. ***/)
THEN 1
ELSE 0
END AS active_fg,
CASE WHEN Coalesce(lctn.real_opening_dt, lctn.opening_dt, lctn.sap_creation_wrf1_dt) > Current_Date    -- Prüfung ob das Eröffungsdatum in der Zukunft liegt
             AND (lctn.closing_dt > Coalesce(lctn.real_opening_dt, lctn.opening_dt, lctn.sap_creation_wrf1_dt) OR lctn.closing_dt IS NULL) -- Ausschließen von Filialen, deren Eröffungsdatum nach dem Schließungsdatum liegt
        THEN 1
        ELSE 0
   END AS active_future_fg,
CASE WHEN -- BGES Identifikation für Elwis Daten
             (global_loc_id_length = 7 AND global_loc_ctry_cd IS NOT NULL AND country_pol_cd IS NOT NULL AND global_loc_type_cd = '9' AND global_loc_ctry_cd <>  'ZV' AND m.migration_dat_valid_from <= CURRENT_DATE)
             OR
             -- BGES Identifikation fuer WAWI Daten
             (wo.client_id IS NOT NULL AND m.migration_dat_valid_from > CURRENT_DATE)
        THEN 1
        ELSE 0
   END AS bges_active_fg
FROM p_lew_core_ac.v_location lctn

INNER JOIN p_lew_core_ac.v_location_hist lctn_h
ON lctn.loc_sid = lctn_h.loc_sid

-- Ermittlung ob Land bereits aufgeschaltet ist oder nicht
INNER JOIN p_lew_core_ac.v_client_migration_per m
ON lctn.client_id = m.client_id

-- Lookup auf WAWI WH fuer Ermittlung Bges
LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_wh wo
ON lctn.client_id = wo.client_id
  AND lctn.loc_sid = wo.wh_loc_sid
  AND CURRENT_DATE BETWEEN wo.dat_rec_start AND wo.dat_rec_end
AND wo.wawi_data_fg = 1
AND Coalesce(lctn.src_wh_id, -1) > 0

WHERE Upper(lctn.wh_store_mark) = 'B';



