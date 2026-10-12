CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_IN_SYSTEMSTATUS_SPR_ZU_1 as
   -- LOOKUP/SPRACHE : Industrie Systemstatus (Ausschnitt PSP-Element auf PS-Projekt)
   -- 20160414 ssch0611: initial
   --20180307 nfis0811: Erweiterung für (Spalten)-Internationalisierung

   SELECT
   issz.mandant_id, issz.systemstatus_id       AS in_systemstus_id, MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez_kurz ELSE NULL END) AS in_systemstatus_kbez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN issz.systemstatus_bez_kurz ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez_kurz ELSE NULL END)) AS in_systemstatus_kbez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN issz.systemstatus_bez_kurz ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez_kurz ELSE NULL END)) AS in_systemstatus_kbez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN issz.systemstatus_bez_kurz ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez_kurz ELSE NULL END)) AS in_systemstatus_kbez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN issz.systemstatus_bez_kurz ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez_kurz ELSE NULL END)) AS in_systemstatus_kbez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN issz.systemstatus_bez_kurz ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez_kurz ELSE NULL END)) AS in_systemstatus_kbez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN issz.systemstatus_bez_kurz ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez_kurz ELSE NULL END)) AS in_systemstatus_kbez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN issz.systemstatus_bez_kurz ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez_kurz ELSE NULL END)) AS in_systemstatus_kbez_bg    -- BG
   , MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez   ELSE NULL END) AS in_systemstatus_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN issz.systemstatus_bez   ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez   ELSE NULL END)) AS in_systemstatus_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN issz.systemstatus_bez   ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez   ELSE NULL END)) AS in_systemstatus_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN issz.systemstatus_bez   ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez   ELSE NULL END)) AS in_systemstatus_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN issz.systemstatus_bez   ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez   ELSE NULL END)) AS in_systemstatus_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN issz.systemstatus_bez   ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez   ELSE NULL END)) AS in_systemstatus_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN issz.systemstatus_bez   ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez   ELSE NULL END)) AS in_systemstatus_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN issz.systemstatus_bez   ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN issz.systemstatus_bez   ELSE NULL END)) AS in_systemstatus_bez_bg    -- BG


   FROM dbp_view.v_ims_systemstatus_spr_zu_1 issz

   WHERE
   --issz.spr_id = 22 AND
   (issz.mandant_id, issz.systemstatus_id) IN
   (
   SELECT ipes.mandant_id, ipes.systemstatus_id
   FROM dbp_view.v_ims_psp_ele_sysstat_zu_1  ipes
   JOIN dbp_view.v_in_psp_element_1   ipsp
   ON ipes.mandant_id = ipsp.mandant_id AND ipes.psp_id = ipsp.psp_id
   )
   GROUP BY
   issz.mandant_id
   , issz.systemstatus_id;