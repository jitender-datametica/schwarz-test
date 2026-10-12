CREATE OR REPLACE VIEW dbp_msi_view3.mv_l_belos_auftrag
-- 14.05.2013 srom, 589416, belos_adresse_num_id
-- 15.02.2021 nwag, INC2763120, tour_id kann EWM-TU-Nummer enthalten -> typecast auf INT nur wenn LVS-tour
-- 27.02.2025 nwag, limit bis WANKO golive + union für danach
(
mandant_id
,belos_adresse_absender_num_id
,tour_id
,tour_id_auftrag
,tms
)
AS
SELECT
bv.mandant_id,
bv.belos_adresse_absender_num_id,
bv.tour_id,
MAX(CASE
WHEN bv.tour_id < 0 THEN bv.transportauftrag_id
-- VARCHAR Anpassung für Snowflake
ELSE CAST(bv.tour_id AS INTEGER)::VARCHAR END) AS tour_id_auftrag
,MAX('BELOS') AS TMS
FROM dbp_view.v_belos_vorgang bv
LEFT JOIN  ( SELECT mandant_id, wup_id, MIN(dat_tms_wanko) AS dat_tms_wanko 
            FROM DBP_MSI_V_VIEW.V_TS_LAGERNUMMER_SORTIERUNG_SCM WHERE dat_tms_wanko IS NOT NULL
            GROUP BY mandant_id, wup_id ) dw
ON dw.mandant_id = bv.mandant_id
AND dw.wup_id = bv.belos_adresse_absender_num_id
WHERE bv.belosart_fg  = 1 AND tour_id <= 2147483646
AND bv.dat_leistung < COALESCE(dat_tms_wanko,DATE'9999-12-31')
GROUP BY bv.mandant_id
,bv.belos_adresse_absender_num_id
,bv.tour_id
UNION
SELECT
tms_tour.mandant_id,
TRY_CAST( tms_tour.startlager_tms_gp_id AS NUMBER) AS belos_adresse_absender_num_id,
TRY_CAST( RIGHT(tms_tour.transportation_unit_id_ext, LENGTH(TRIM(tms_tour.transportation_unit_id_ext) ) -6 ) AS NUMBER) AS tour_id,
MAX(CASE WHEN tms_tour.tms_tourart_detail_id IN (4,5) THEN tms_tour.tms_tour_bez
-- VARCHAR Anpassung für Snowflake
ELSE TRY_CAST( RIGHT(tms_tour.transportation_unit_id_ext, LENGTH(TRIM(tms_tour.transportation_unit_id_ext) ) -6 )  AS NUMBER )::VARCHAR END) AS tour_id_auftrag
,MAX('WANKO') AS TMS
FROM dbp_view.v_tms_tour tms_tour
LEFT JOIN  ( SELECT mandant_id, wup_id, MIN(dat_tms_wanko) AS dat_tms_wanko 
            FROM DBP_MSI_V_VIEW.V_TS_LAGERNUMMER_SORTIERUNG_SCM WHERE dat_tms_wanko IS NOT NULL
            GROUP BY mandant_id, wup_id ) dw
ON dw.mandant_id = tms_tour.mandant_id
AND dw.wup_id = TRY_CAST( tms_tour.startlager_tms_gp_id AS NUMBER)
LEFT JOIN ( SELECT mandant_id, wup_id, MIN(dat) AS dat FROM dbp_msi_data.ts_lagerort_ewm_dat GROUP BY mandant_id, wup_id ) ewm
ON ewm.mandant_id = tms_tour.mandant_id
AND ewm.wup_id = TRY_CAST( tms_tour.startlager_tms_gp_id AS NUMBER)
WHERE tms_tour.dat_tour >= COALESCE(dat_tms_wanko,DATE'9999-12-31')
AND tms_tour.dat_tour < COALESCE(ewm.dat,DATE'9999-12-31')
GROUP BY 1,2,3
;