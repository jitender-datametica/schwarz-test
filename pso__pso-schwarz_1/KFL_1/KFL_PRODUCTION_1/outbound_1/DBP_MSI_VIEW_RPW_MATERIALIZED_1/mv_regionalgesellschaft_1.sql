-- 07.09.2023, prescherad, SPEC0211574, einfügen Gesellschaft 0 als Dummywert

CREATE OR REPLACE VIEW dbp_msi_view_rpw_materialized.mv_regionalgesellschaft_1 (vs_id, vs_bez, vsvt_bez) AS
SELECT V01.vs_id,
 V02.vs_bez,
 V02.vsvt_bez
FROM dbp_view.v_wup_1 AS V01
 INNER JOIN dbp_view.v_vs_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.vs_id = V02.vs_id AND V01.mandant_id
     = 1 AND V02.vk_id = 1
GROUP BY V01.vs_id,
 V02.vs_bez,
 V02.vsvt_bez
UNION ALL
SELECT ROUND(CAST('0' AS BIGNUMERIC), 0) AS vs_id,
 'Keine' AS vs_bez,
 'Keine Regionalgesellschaft' AS vsvt_bez
FROM dbp_view.v_vs_1 AS V1
WHERE mandant_id = 1
 AND vk_id = 0;