CREATE OR REPLACE PROCEDURE dbp_macro.m_insert_user_wup_zu(OUT out_param STRING)
BEGIN
DECLARE resultSetCounter NUMERIC;
DECLARE tablelist ARRAY<STRING(16777216)>;
DECLARE procname STRING;
DECLARE sql_command STRING;
DECLARE stmt STRING;
DECLARE res ARRAY<JSON>;
DECLARE sessionid STRING;
DECLARE setname STRING;
DECLARE tablename STRING;
DECLARE sql_stmt STRING;
DECLARE RESULTSET STRING;
DECLARE iterator_res INT64 DEFAULT -1;
SET resultSetCounter  =  0;



SET procname  =  'dbp_macro.m_insert_user_wup_zu_';
SET sql_command  =  '''SELECT CAST(ABS(FARM_FINGERPRINT(SESSION_USER())) AS STRING) || "_" || FORMAT_TIMESTAMP("%Y%m%d%I24%M4S",    CURRENT_TIMESTAMP()) ''';
SET stmt  =  sql_command;

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'CAST(ABS(FARM_FINGERPRINT(SESSION_USER())) AS STRING) || "_" || FORMAT_TIMESTAMP("%Y%m%d%I24%M4S",    CURRENT_TIMESTAMP())',  stmt)
INTO res ;
SET iterator_res  =  iterator_res  + 1;
SET sessionid  =  procname || JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]');
SET setname  =  '''SELECT COUNT(*) AS `einträge vorher` FROM dbp_msi_data.user_wup_zu ''';
SET tablename  =  sessionid || '_' || CAST(resultSetCounter AS STRING);
SET sql_stmt  =  'CREATE TEMPORARY TABLE ${tablename} AS ${setname}';
SET tablelist  =  ARRAY_CONCAT(tablelist, ARRAY[tablename]);

EXECUTE IMMEDIATE (sql_stmt);
--Löschen der Ziel-Tabelle
SET sql_stmt  =  '''TRUNCATE TABLE dbp_msi_data.user_wup_zu ''';

EXECUTE IMMEDIATE (sql_stmt);
SET sql_stmt  =  '''INSERT INTO dbp_msi_data.user_wup_zu (user_id, mandant_id, wup_id) (SELECT v.user_id,   v.mandant_id,   v.wup_id  FROM ((SELECT HL_BM.user_id,       HL_BM.mandant_id,       W.wup_id      FROM dbp_msi_data.user_vis_benchmark_zu AS HL_BM       INNER JOIN dbp_data.wup AS W ON LOWER(HL_BM.hierarchie_ebene_id) = "hl" AND HL_BM.hierarchie_element_id           = W.wup_id AND HL_BM.mandant_id = W.mandant_id      UNION DISTINCT      (SELECT VKL_BM.user_id,        VKL_BM.mandant_id,        W0.wup_id       FROM dbp_msi_data.user_vis_benchmark_zu AS VKL_BM        INNER JOIN dbp_msi_data.wup_denorm AS W0 ON LOWER(VKL_BM.hierarchie_ebene_id) = "vkl" AND VKL_BM.hierarchie_element_id            = W0.vkl_id AND VKL_BM.mandant_id = W0.mandant_id       UNION DISTINCT       SELECT VS_BM.user_id,        VS_BM.mandant_id,        W1.wup_id       FROM dbp_msi_data.user_vis_benchmark_zu AS VS_BM        INNER JOIN dbp_data.wup AS W1 ON LOWER(VS_BM.hierarchie_ebene_id) = "vs" AND VS_BM.hierarchie_element_id            = W1.vs_id AND VS_BM.mandant_id = W1.mandant_id))     UNION DISTINCT     ((SELECT GF_BM.user_id,        GF_BM.mandant_id,        W2.wup_id       FROM dbp_msi_data.user_vis_benchmark_zu AS GF_BM        INNER JOIN dbp_msi_data.wup_denorm AS W2 ON LOWER(GF_BM.hierarchie_ebene_id) = "gf" AND GF_BM.hierarchie_element_id            = W2.gf_gbl_vertrieb_id AND GF_BM.mandant_id = W2.mandant_id       UNION DISTINCT       SELECT VST_BM.user_id,        VST_BM.mandant_id,        W3.wup_id       FROM dbp_msi_data.user_vis_benchmark_zu AS VST_BM        INNER JOIN dbp_data.wup AS W3 ON LOWER(VST_BM.hierarchie_ebene_id) = "land" AND VST_BM.hierarchie_element_id           = W3.mandant_id)      UNION DISTINCT      (SELECT VST_BM0.user_id,        W4.mandant_id,        W4.wup_id       FROM dbp_msi_data.user_vis_benchmark_zu AS VST_BM0        INNER JOIN dbp_data.wup AS W4 ON TRUE       WHERE VST_BM0.hierarchie_element_id = -1        AND LOWER(VST_BM0.hierarchie_ebene_id) = "land"       UNION DISTINCT       SELECT VST_BM1.user_id,        W5.mandant_id,        W5.wup_id       FROM dbp_msi_data.user_vis_benchmark_zu AS VST_BM1        INNER JOIN dbp_data.wup AS W5 ON TRUE       WHERE W5.mandant_id <> 1        AND VST_BM1.hierarchie_element_id = -2        AND LOWER(VST_BM1.hierarchie_ebene_id) = "land"))) AS v   INNER JOIN dbp_data.wup AS W6 ON v.mandant_id = W6.mandant_id AND v.wup_id = W6.wup_id  WHERE W6.dat_eroeffnung IS NOT NULL   AND PARSE_DATE("%Y/%m/%d", CAST(EXTRACT(YEAR FROM CURRENT_DATE("Europe/Berlin")) - CASE         WHEN EXTRACT(MONTH FROM CURRENT_DATE("Europe/Berlin")) IN (1, 2, 3)         THEN 3         ELSE 2         END AS STRING) || "-03-01") <= W6.dat_bis   AND W6.nb_id IN (0, -1) -- Märkte und Zentralfilialen  
 GROUP BY v.user_id,   v.mandant_id,   v.wup_id) ''';

EXECUTE IMMEDIATE (sql_stmt);
SET setname  =  '''SELECT COUNT(*) AS `einträge nachher` FROM dbp_msi_data.user_wup_zu ''';
SET tablename  =  sessionid || '_' || CAST(resultSetCounter AS STRING);
SET sql_stmt  =  'CREATE TEMPORARY TABLE ${tablename} AS ${setname}';
SET tablelist  =  ARRAY_CONCAT(tablelist, ARRAY[tablename]);

EXECUTE IMMEDIATE (sql_stmt);
SET out_param  =  ARRAY_TO_STRING(tablelist,',') ;
SELECT out_param;
RETURN;
END;
