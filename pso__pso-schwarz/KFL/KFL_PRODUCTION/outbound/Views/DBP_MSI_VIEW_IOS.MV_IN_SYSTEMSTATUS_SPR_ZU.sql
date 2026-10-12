CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_in_systemstatus_spr_zu AS SELECT mandant_id,
 systemstatus_id AS in_systemstus_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN systemstatus_bez_kurz
   ELSE NULL
   END) AS in_systemstatus_kbez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN systemstatus_bez_kurz
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN systemstatus_bez_kurz
    ELSE NULL
    END)) AS in_systemstatus_kbez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN systemstatus_bez_kurz
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN systemstatus_bez_kurz
    ELSE NULL
    END)) AS in_systemstatus_kbez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN systemstatus_bez_kurz
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN systemstatus_bez_kurz
    ELSE NULL
    END)) AS in_systemstatus_kbez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN systemstatus_bez_kurz
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN systemstatus_bez_kurz
    ELSE NULL
    END)) AS in_systemstatus_kbez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN systemstatus_bez_kurz
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN systemstatus_bez_kurz
    ELSE NULL
    END)) AS in_systemstatus_kbez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN systemstatus_bez_kurz
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN systemstatus_bez_kurz
    ELSE NULL
    END)) AS in_systemstatus_kbez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN systemstatus_bez_kurz
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN systemstatus_bez_kurz
    ELSE NULL
    END)) AS in_systemstatus_kbez_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN systemstatus_bez
   ELSE NULL
   END) AS in_systemstatus_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN systemstatus_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN systemstatus_bez
    ELSE NULL
    END)) AS in_systemstatus_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN systemstatus_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN systemstatus_bez
    ELSE NULL
    END)) AS in_systemstatus_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN systemstatus_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN systemstatus_bez
    ELSE NULL
    END)) AS in_systemstatus_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN systemstatus_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN systemstatus_bez
    ELSE NULL
    END)) AS in_systemstatus_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN systemstatus_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN systemstatus_bez
    ELSE NULL
    END)) AS in_systemstatus_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN systemstatus_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN systemstatus_bez
    ELSE NULL
    END)) AS in_systemstatus_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN systemstatus_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN systemstatus_bez
    ELSE NULL
    END)) AS in_systemstatus_bez_bg
FROM kfl_production_dbp_view.v_ims_systemstatus_spr_zu AS ISSZ
WHERE (mandant_id, systemstatus_id) IN (SELECT (IPES.mandant_id, IPES.systemstatus_id)
   FROM kfl_production_dbp_view.v_ims_psp_ele_sysstat_zu AS IPES
    INNER JOIN kfl_production_dbp_view.v_in_psp_element AS IPSP ON IPES.mandant_id = IPSP.mandant_id AND IPES.psp_id =
      IPSP.psp_id)
GROUP BY mandant_id,
 in_systemstus_id;