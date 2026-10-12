CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_ta_nachschubzeit (
    mandant_id, lagernummer_id, transport_beleg_id, transport_beleg_pos_id, global_von_lagertyp_id, 
    nach_lagertyp_id, von_lagertyp_id, dat_erstellung, nachschubzeit_sekunden, count_beleg, status_quittierung
) AS 
SELECT 
    T1.mandant_id,
    T1.lagernummer_id,
    T2.transport_beleg_id,
    T2.transport_beleg_pos_id,
    CASE
        WHEN SUBSTR(T2.von_lagertyp_id, 1, 2) = 'R0' THEN 'Regal Erdgeschoss'
        WHEN SUBSTR(T2.von_lagertyp_id, 1, 2) = 'R1' THEN 'Regal Obergeschoss'
        WHEN T2.von_lagertyp_id = 'H01' THEN 'Hochregal'
        WHEN T2.von_lagertyp_id IN ('RH1', 'RT1') THEN 'AKL-Hochregal'
        ELSE 'Sonstige'
    END AS global_von_lagertyp_id,
    T2.nach_lagertyp_id,
    T2.von_lagertyp_id,
    T1.dat_erstellung,
    
    CAST(
        CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(TIMESTAMP(DATETIME(T2.dat_quittierung, T2.zeit_quittierung)), TIMESTAMP(DATETIME(T1.dat_erstellung, T1.zeit_erstellung)), SECOND)),'$.DAY') AS INT64) * 86400 + 
        CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(TIMESTAMP(DATETIME(T2.dat_quittierung, T2.zeit_quittierung)), TIMESTAMP(DATETIME(T1.dat_erstellung, T1.zeit_erstellung)), SECOND)),'$.HOUR') AS INT64) * 3600 + 
        CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(TIMESTAMP(DATETIME(T2.dat_quittierung, T2.zeit_quittierung)), TIMESTAMP(DATETIME(T1.dat_erstellung, T1.zeit_erstellung)), SECOND)),'$.MINUTE') AS INT64) * 60 + 
        CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(TIMESTAMP(DATETIME(T2.dat_quittierung, T2.zeit_quittierung)), TIMESTAMP(DATETIME(T1.dat_erstellung, T1.zeit_erstellung)), SECOND)),'$.SECOND') AS INT64) 
    AS NUMERIC) AS nachschubzeit_sekunden,
    
    CAST(T1.mandant_id AS STRING) || T1.lagernummer_id || CAST(T1.transport_beleg_id AS STRING) AS count_beleg,
    
    CAST(
        CASE
            WHEN T2.quittierung_fg = 1 AND (T2.menge_soll_von = T2.menge_ist_nach OR T2.menge_soll_von = 0 AND T2.menge_ist_nach > 0) AND COALESCE(T2.transport_vorgang_id, '') NOT IN ('st', 'sl') THEN 'voll quittiert'
            WHEN T2.quittierung_fg = 1 AND T2.menge_soll_von > T2.menge_ist_nach AND COALESCE(T2.transport_vorgang_id, '') NOT IN ('st', 'sl') THEN 'teil quittiert'
            WHEN T2.quittierung_fg = 1 AND T2.transport_vorgang_id IN ('st', 'sl') THEN 'storniert'
            WHEN T2.quittierung_fg = 0 THEN 'offen'
            ELSE 'sonstiges'
        END 
    AS STRING) AS status_quittierung

FROM kfl_production_dbp_view.v_transportauftrag AS T1
INNER JOIN kfl_production_dbp_view.v_transportauftrag_det AS T2 
    ON T1.mandant_id = T2.mandant_id 
    AND T1.lagernummer_id = T2.lagernummer_id 
    AND T1.transport_beleg_id = T2.transport_beleg_id
WHERE EXTRACT(YEAR FROM T1.dat_erstellung) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;