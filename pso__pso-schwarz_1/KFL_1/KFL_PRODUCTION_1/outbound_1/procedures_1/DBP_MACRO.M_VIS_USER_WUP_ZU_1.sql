CREATE OR REPLACE PROCEDURE dbp_macro.m_vis_user_wup_zu(OUT out_param STRING)
BEGIN
DECLARE str_result STRING;
DECLARE sql_stmt STRING;
-- VERSION_2022_02_02
SET str_result  =  'DONE';
-- DELETE_TABLE
SET sql_stmt  =  '''TRUNCATE TABLE dbp_msi_data.user_wup_zu_1 ''';

EXECUTE IMMEDIATE (sql_stmt);
-- INSERT_TABLE
SET sql_stmt  =  '''INSERT INTO dbp_msi_data.user_wup_zu_1 (user_id, mandant_id, wup_id) (SELECT v.user_id,   v.mandant_id,   v.wup_id  FROM ((((SELECT HL_BM.user_id,         HL_BM.mandant_id,         W.wup_id        FROM dbp_msi_data.user_vis_benchmark_zu_1 AS HL_BM         INNER JOIN dbp_data.wup_1 AS W ON LOWER(HL_BM.hierarchie_ebene_id) = "hl_1" AND HL_BM.hierarchie_element_id             = W.wup_id AND HL_BM.mandant_id = W.mandant_id        UNION DISTINCT        SELECT VKL_BM.user_id,         VKL_BM.mandant_id,         W.wup_id        FROM dbp_msi_data.user_vis_benchmark_zu_1 AS VKL_BM         INNER JOIN dbp_msi_data.wup_denorm_1 AS W ON LOWER(VKL_BM.hierarchie_ebene_id) = "vkl_1" AND VKL_BM.hierarchie_element_id             = W.vkl_id AND VKL_BM.mandant_id = W.mandant_id)       UNION DISTINCT       SELECT GF_BM.user_id,        GF_BM.mandant_id,        W.wup_id       FROM dbp_msi_data.user_vis_benchmark_zu_1 AS GF_BM        INNER JOIN dbp_msi_data.wup_denorm_1 AS W ON LOWER(GF_BM.hierarchie_ebene_id) = "gf_1" AND GF_BM.hierarchie_element_id            = W.gf_gbl_vertrieb_id AND GF_BM.mandant_id = W.mandant_id)      UNION DISTINCT      SELECT VS_BM.user_id,       VS_BM.mandant_id,       W.wup_id      FROM dbp_msi_data.user_vis_benchmark_zu_1 AS VS_BM       INNER JOIN dbp_data.wup_1 AS W ON LOWER(VS_BM.hierarchie_ebene_id) = "vs_1" AND VS_BM.hierarchie_element_id           = W.vs_id AND VS_BM.mandant_id = W.mandant_id)     UNION DISTINCT     SELECT NAT_BM.user_id,      NAT_BM.mandant_id,      W.wup_id     FROM dbp_msi_data.user_vis_benchmark_zu_1 AS NAT_BM      INNER JOIN dbp_data.wup_1 AS W ON LOWER(NAT_BM.hierarchie_ebene_id) = "land_1" AND NAT_BM.hierarchie_element_id         = W.mandant_id) AS v   INNER JOIN dbp_data.wup_1 AS W0 ON v.mandant_id = W0.mandant_id AND v.wup_id = W0.wup_id  WHERE W0.dat_eroeffnung IS NOT NULL   AND DATE(CAST(EXTRACT(YEAR FROM CURRENT_DATE("Europe/Berlin")) - CASE         WHEN EXTRACT(MONTH FROM CURRENT_DATE("Europe/Berlin")) IN (1, 2, 3)         THEN 3         ELSE 2         END AS STRING) || "-03-01") <= W0.dat_bis   AND W0.nb_id IN (0, -1)   AND W0.dat_von IS NOT NULL  GROUP BY v.user_id,   v.mandant_id,   v.wup_id) ''';

EXECUTE IMMEDIATE (sql_stmt);
SET out_param  =  str_result;
SELECT out_param;
RETURN;
END;