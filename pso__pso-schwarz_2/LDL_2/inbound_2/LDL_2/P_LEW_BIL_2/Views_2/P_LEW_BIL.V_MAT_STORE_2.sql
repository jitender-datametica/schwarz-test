
CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT_STORE_2
AS
-- Alle Filialen (inkl. Testfilialen)
SELECT
   lctn.client_id
  ,lctn.loc_sid                           AS loc_sid_store
  ,lctn.src_werks
  ,lctn.src_orig_store_nr
  ,lctn.src_store_id
  ,lctn.src_wh_id
  ,lctn.loc_name
  ,lctn.loc_name2
  ,lctn.global_loc_id
  ,lctn.country_pol_sid
  ,lctn.country_pol_cd
  ,lctn.storetype_mark
  ,lctn.closing_dt
  ,lctn.opening_dt
  ,COALESCE(lctn.real_opening_dt, lctn.sap_creation_wrf1_dt) AS real_opening_dt
  ,lctn.global_loc_type_cd
  ,lctn_h.addr_sid
  ,COALESCE(lctn_h.test_store_fg,0)       AS test_store_fg
  ,lctn_h.deleted_fg
  ,lctn_h.dwh_valid_from
  ,lctn_h.dwh_valid_to
  ,lctn_h.region_cd
  ,CAST(w_st.mde_lang_cd AS VARCHAR(20)) AS mde_lang_cd
  ,CAST(CASE WHEN w_st.qty_min_dflt = '' 
             THEN 0 
			 ELSE w_st.qty_min_dflt 
        END AS BYTEINT) AS qty_min_dflt
  ,w_st.dat_opening_ovis
  ,w_st.dat_closing_ovis
  ,CASE WHEN CONTAINS(UPPER(lctn.loc_name), 'DUMMY_2') = TRUE 
       THEN 1 
       ELSE 0 
   END AS dummy_store_fg
  ,CASE WHEN lctn.country_pol_cd IS NULL 
        THEN 1 
		ELSE 0 
   END AS pseudo_store_fg
  ,CASE WHEN CURRENT_DATE BETWEEN lctn_h.dwh_valid_from AND lctn_h.dwh_valid_to 
        THEN 1
        ELSE 0
   END AS dwh_actual_fg
  ,CASE WHEN lctn_h.deleted_fg = 0 AND CURRENT_DATE BETWEEN COALESCE(lctn.real_opening_dt, lctn.opening_dt, lctn_h.dwh_valid_from) AND COALESCE(lctn.closing_dt, TO_DATE('31.12.9999', 'dd.mm.yyyy'))
        THEN 1
        ELSE 0
   END AS active_fg
  ,CASE WHEN COALESCE(lctn.real_opening_dt, lctn.opening_dt) > CURRENT_DATE -- Prüfung ob das Eröffungsdatum in der Zukunft liegt
             AND (lctn.closing_dt > COALESCE(lctn.real_opening_dt, lctn.opening_dt) OR lctn.closing_dt IS NULL) -- Ausschließen von Filialen, deren Eröffungsdatum nach dem Schließungsdatum liegt
        THEN 1
        ELSE 0
   END AS active_future_fg
FROM p_lew_core_ac.v_location_2 AS lctn

INNER JOIN p_lew_core_ac.v_location_hist_2 AS lctn_h
ON lctn.client_id = lctn_h.client_id
  AND lctn.loc_sid = lctn_h.loc_sid

-- Join zur WaWI Filialen um nicht SAP Felder mit Inhalten aus der WaWi zu befülllen
LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_store_2 AS w_st
ON lctn.client_id = w_st.client_id
  AND lctn.loc_sid = w_st.st_loc_sid
  AND CURRENT_DATE BETWEEN w_st.dat_rec_start AND w_st.dat_rec_end

-- Optionaler LKP, ob es sich um einen Pseudo-Store handelt. Diese werden im folgenden UNION ALL separat behandelt
LEFT OUTER JOIN p_lew_core_ac.v_location_2 AS lctn_wh
ON lctn.client_id = lctn_wh.client_id
  AND TRY_CAST(SUBSTR(lctn.global_loc_id, 4) AS INTEGER) = TRY_CAST(SUBSTR(lctn_wh.global_loc_id, 4) AS INTEGER)
  AND UPPER(lctn_wh.wh_store_mark) = 'B'

WHERE UPPER(lctn.wh_store_mark) = 'A'
  AND lctn_wh.client_id IS NULL

UNION ALL

-- Pseudo Stores hinter denen ein WH steht. Diese werden für die WAWI-Seite simuliert, da WAWI manche Buchungen nur durchführen kann, wenn eine_2 ORIG_STORE_NR besteht. Daher werden aus Koexistenzgründen die Pseudo Stores aufgenommen.
-- Für eLWIS alleine ist dies nicht notwendig.
-- Damit dies nur für eLWIS-Clients simuliert wird, wird bewusst über GLOBAL_LOC_ID anstatt von SRC_ORIG_STORE_NR = SRC_ORIG_WH_NR gejoint.
SELECT
   lctn.client_id
  ,lctn.loc_sid AS loc_sid_store
  ,lctn_wh.src_werks
  ,lctn.src_orig_store_nr
  ,lctn.src_store_id
  ,lctn_wh.src_wh_id
  ,lctn_wh.loc_name
  ,lctn_wh.loc_name2
  ,lctn_wh.global_loc_id
  ,lctn_wh.country_pol_sid
  ,lctn_wh.country_pol_cd
  ,lctn_wh.storetype_mark
  ,lctn_wh.closing_dt
  ,lctn_wh.opening_dt
  ,COALESCE(lctn_wh.real_opening_dt, lctn_wh.sap_creation_wrf1_dt) AS real_opening_dt
  ,lctn_wh.global_loc_type_cd
  ,lctn_wh_h.addr_sid
  ,COALESCE(lctn_wh_h.test_store_fg,0) AS test_store_fg
  ,lctn_wh_h.deleted_fg
  ,lctn_wh_h.dwh_valid_from
  ,lctn_wh_h.dwh_valid_to
  ,lctn_wh_h.region_cd
  ,CAST(w_st.mde_lang_cd AS VARCHAR(20)) AS mde_lang_cd
  ,CAST(w_st.qty_min_dflt AS BYTEINT) AS qty_min_dflt
  ,w_st.dat_opening_ovis
  ,w_st.dat_closing_ovis
  ,CASE WHEN CONTAINS(UPPER(lctn.loc_name), 'DUMMY_2') = TRUE THEN 1 ELSE 0 END AS dummy_store_fg
  ,CASE WHEN lctn_wh.country_pol_cd IS NULL
        THEN 1
        ELSE 0
   END AS pseudo_store_fg
  ,CASE WHEN CURRENT_DATE BETWEEN lctn_wh_h.dwh_valid_from AND lctn_wh_h.dwh_valid_to
        THEN 1
        ELSE 0
   END AS dwh_actual_fg
  ,CASE WHEN lctn_wh_h.deleted_fg = 0 AND CURRENT_DATE BETWEEN COALESCE(lctn_wh.real_opening_dt, lctn_wh.opening_dt, lctn_wh_h.dwh_valid_from) AND COALESCE(lctn_wh.closing_dt, TO_DATE('31.12.9999', 'dd.mm.yyyy'))
        THEN 1
        ELSE 0
   END AS active_fg
  ,CASE WHEN COALESCE(lctn_wh.real_opening_dt, lctn_wh.opening_dt) > CURRENT_DATE -- Prüfung ob das Eröffungsdatum in der Zukunft liegt
             AND (lctn_wh.closing_dt > COALESCE(lctn_wh.real_opening_dt, lctn_wh.opening_dt) OR lctn_wh.closing_dt IS NULL) -- Ausschließen von Filialen, deren Eröffungsdatum nach dem Schließungsdatum liegt
        THEN 1
        ELSE 0
   END AS active_future_fg
FROM p_lew_core_ac.v_location_2 AS lctn

LEFT OUTER JOIN p_lew_core_ac.v_location_2 AS lctn_wh
ON lctn.client_id = lctn_wh.client_id
  AND TRY_CAST(SUBSTR(lctn.global_loc_id, 4) AS INTEGER) = TRY_CAST(SUBSTR(lctn_wh.global_loc_id, 4) AS INTEGER)
  AND UPPER(lctn_wh.wh_store_mark) = 'B'

LEFT OUTER JOIN p_lew_core_ac.v_location_hist_2 AS lctn_wh_h
ON lctn_wh.client_id = lctn_wh_h.client_id
  AND lctn_wh.loc_sid = lctn_wh_h.loc_sid

-- Join zur WaWI Filialen um nicht SAP Felder mit Inhalten aus der WaWi zu befülllen
LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_store_2 AS w_st
ON lctn_wh.client_id = w_st.client_id
  AND lctn_wh.loc_sid = w_st.st_loc_sid
  AND CURRENT_DATE BETWEEN w_st.dat_rec_start AND w_st.dat_rec_end

WHERE Upper(lctn.wh_store_mark) = 'A'
  AND lctn_wh.client_id IS NOT NULL
;