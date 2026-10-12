CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EINH_SPR_ZU as
   -- Lookup-View für Mengeneinheit
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   v01.mandant_id, v01.einh_id, MAX(CASE WHEN spr_id =  22 THEN einh_bez END) AS einh_bez                -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN einh_bez END) AS einh_bez_de                         -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN einh_bez END), einh_bez_de) AS einh_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN einh_bez END), einh_bez_de) AS einh_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN einh_bez END), einh_bez_de) AS einh_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN einh_bez END), einh_bez_de) AS einh_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN einh_bez END), einh_bez_de) AS einh_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN einh_bez END), einh_bez_de) AS einh_bez_bg    -- BG

   FROM dbp_view.v_einh_spr_zu  v01

   GROUP BY 1,2

   UNION ALL
   SELECT
   mandant_id, 'LGB'::CHAR(3)      AS einh_id, 'Leergutbon'::VARCHAR(40)  AS einh_bez, 'Leergutbon'::VARCHAR(40)  AS einh_bez_de, 'Leergutbon'::VARCHAR(40)  AS einh_bez_cz, 'Leergutbon'::VARCHAR(40)  AS einh_bez_pl, 'Leergutbon'::VARCHAR(40)  AS einh_bez_sk, 'Leergutbon'::VARCHAR(40)  AS einh_bez_hr, 'Leergutbon'::VARCHAR(40)  AS einh_bez_ro, 'Leergutbon'::VARCHAR(40)  AS einh_bez_bg
   FROM dbp_view.v_mandant
   WHERE (mandant_id, einh_id) NOT IN
   (
   SELECT mandant_id, einh_id
   FROM dbp_view.v_einh_spr_zu
   );