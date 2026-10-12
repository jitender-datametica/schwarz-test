CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_ADV_WEEK_RANGES_2

AS
SELECT
awk.client_id
,CAST(1 AS SMALLINT)                                                     AS range_id
,CAST(range_id * 100::INTEGER +  awk.client_id AS INTEGER)                         AS range_sid
,rng.range_seq
--'Letzte ' || CAST(-1 * rng.range_seq AS VARCHAR(10)) || ' Werbewochen'     AS range_desc
,'Letzte ' || TO_CHAR(-1 * rng.range_seq) || ' Werbewochen'                 AS range_desc
,awk.adv_week_seq
FROM p_lew_mart_pit_onprem.v_pit_adv_week_2 AS awk
INNER JOIN
(SELECT
client_id
,MIN(adv_week_seq) AS range_seq
FROM p_lew_mart_pit_onprem.v_pit_adv_week_2
   GROUP BY 1
) AS rng
ON  awk.client_id = rng.client_id

UNION ALL
SELECT
client_id
,CAST(2 AS SMALLINT)                                                     AS range_id
,CAST(range_id * 100::INTEGER +  client_id AS INTEGER)                             AS range_sid
,-104 AS range_seq
,'Letzte 104 Werbewochen'                                                 AS range_desc
,adv_week_seq
FROM p_lew_mart_pit_onprem.v_pit_adv_week_2
WHERE adv_week_seq BETWEEN -104 AND 0

UNION ALL
SELECT
client_id
,CAST(3 AS SMALLINT)                                                     AS range_id
,CAST(range_id * 100::INTEGER +  client_id AS INTEGER)                             AS range_sid
,-52 AS range_seq
,'Letzte 52 Werbewochen'                                                 AS range_desc
,adv_week_seq
FROM p_lew_mart_pit_onprem.v_pit_adv_week_2
WHERE adv_week_seq BETWEEN -52 AND 0

UNION ALL
SELECT
client_id
,CAST(4 AS SMALLINT)                                                     AS range_id
,CAST(range_id * 100::INTEGER +  client_id AS INTEGER)                             AS range_sid
,-36 AS range_seq
,'Letzte 36 Werbewochen'                                                 AS range_desc
,adv_week_seq
FROM p_lew_mart_pit_onprem.v_pit_adv_week_2
WHERE adv_week_seq BETWEEN -36 AND 0

UNION ALL
SELECT
client_id
,CAST(5 AS SMALLINT)                                                     AS range_id
,CAST(range_id * 100::INTEGER +  client_id AS INTEGER)                             AS range_sid
,-24 AS range_seq
,'Letzte 24 Werbewochen'                                                 AS range_desc
,adv_week_seq
FROM p_lew_mart_pit_onprem.v_pit_adv_week_2
WHERE adv_week_seq BETWEEN -24 AND 0

UNION ALL
SELECT
client_id
,CAST(6 AS SMALLINT)                                                     AS range_id
,CAST(range_id * 100::INTEGER +  client_id AS INTEGER)                             AS range_sid
,-12 AS range_seq
,'Letzte 12 Werbewochen'                                                 AS range_desc
,adv_week_seq
FROM p_lew_mart_pit_onprem.v_pit_adv_week_2
WHERE adv_week_seq BETWEEN -12 AND 0

UNION ALL
SELECT
client_id
,CAST(7 AS SMALLINT)                                                     AS range_id
,CAST(range_id * 100::INTEGER +  client_id AS INTEGER)                             AS range_sid
,-4 AS range_seq
,'Letzte 4 Werbewochen'                                                     AS range_desc
,adv_week_seq
FROM p_lew_mart_pit_onprem.v_pit_adv_week_2
WHERE adv_week_seq BETWEEN -4 AND 0;