CREATE OR REPLACE PROCEDURE dbp_macro.m_upd_preisklasse_wg_sortiment_ek_sort(IN S_MANDANT_ID FLOAT64, IN S_OWG_ID FLOAT64, IN S_WRG_ID STRING, IN S_PL_1 FLOAT64, IN S_PL_2 FLOAT64, IN S_PL_3 FLOAT64, IN S_PL_4 FLOAT64, IN S_PL_5 FLOAT64, IN S_PL_6 FLOAT64, IN S_PL_7 FLOAT64, IN S_PL_8 FLOAT64, IN S_PL_9 FLOAT64, IN S_PL_10 FLOAT64)
BEGIN

DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_stmt  =  '''MERGE INTO dbp_data.ts_sortiment_preisklasse_wug_2 AS T01 USING (SELECT DISTINCT V01.mandant_id,   V01.default_wrg AS wrg_id,   V02.wg_id,   V03.wug_id  FROM dbp_msi_view_ek_sort.mv_mandant_2 AS V01   INNER JOIN dbp_msi_view_ek_sort.mv_wg_per_2 AS V02 ON V01.mandant_id = V02.mandant_id   INNER JOIN dbp_msi_view_ek_sort.mv_wug_2 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.wg_id = V03.wg_id       WHERE V01.mandant_id = @S_MANDANT_ID   AND V01.default_wrg = @S_WRG_ID   AND V02.owg_id = @S_OWG_ID) AS s01 ON T01.mandant_id = s01.mandant_id AND T01.wrg_id = s01.wrg_id AND T01.arthiertyp_id = 0 AND T01.wg_id = s01.wg_id AND   T01.wug_id = s01.wug_id WHEN MATCHED THEN UPDATE SET  preislage_1 = CAST(@S_PL_1  AS NUMERIC),  preislage_2 = CAST(@S_PL_2  AS NUMERIC),  preislage_3 = CAST(@S_PL_3  AS NUMERIC),  preislage_4 = CAST(@S_PL_4  AS NUMERIC),  preislage_5 = CAST(@S_PL_5  AS NUMERIC),  preislage_6 = CAST(@S_PL_6  AS NUMERIC),  preislage_7 = CAST(@S_PL_7  AS NUMERIC),  preislage_8 = CAST(@S_PL_8  AS NUMERIC),  preislage_9 = CAST(@S_PL_9  AS NUMERIC),  preislage_10 = CAST(@S_PL_1  AS NUMERIC) WHEN NOT MATCHED THEN INSERT (mandant_id, arthiertyp_id, wg_id, wug_id, wrg_id, preislage_1, preislage_2, preislage_3,  preislage_4, preislage_5, preislage_6, preislage_7, preislage_8, preislage_9, preislage_10) VALUES(CAST(@S_MANDANT_ID_1 AS INTEGER)  , 0, CAST(s01.wg_id AS INTEGER), CAST(s01.wug_id AS INTEGER), s01.wrg_id, CAST(@S_PL_1_1    AS NUMERIC), CAST(@S_PL_2_1  AS NUMERIC), CAST(@S_PL_3_1  AS   NUMERIC), CAST(@S_PL_4_1  AS NUMERIC), CAST(@S_PL_5_1  AS   NUMERIC), CAST(@S_PL_6_1  AS NUMERIC), CAST(@S_PL_7_1  AS   NUMERIC), CAST(@S_PL_8_1  AS NUMERIC), CAST(@S_PL_9_1  AS   NUMERIC), CAST(@S_PL_10_1  AS NUMERIC)) ''';

EXECUTE IMMEDIATE (sql_stmt) USING S_MANDANT_ID AS S_MANDANT_ID,  S_WRG_ID AS S_WRG_ID,  S_OWG_ID AS S_OWG_ID,  S_PL_1 AS S_PL_1,  S_PL_2 AS S_PL_2,  S_PL_3 AS S_PL_3,  S_PL_4 AS S_PL_4,  S_PL_5 AS S_PL_5,  S_PL_6 AS S_PL_6,  S_PL_7 AS S_PL_7,  S_PL_8 AS S_PL_8,  S_PL_9 AS S_PL_9,  S_PL_10 AS S_PL_10,  S_MANDANT_ID AS S_MANDANT_ID_1,  S_PL_1 AS S_PL_1_1,  S_PL_2 AS S_PL_2_1,  S_PL_3 AS S_PL_3_1,  S_PL_4 AS S_PL_4_1,  S_PL_5 AS S_PL_5_1,  S_PL_6 AS S_PL_6_1,  S_PL_7 AS S_PL_7_1,  S_PL_8 AS S_PL_8_1,  S_PL_9 AS S_PL_9_1,  S_PL_10 AS S_PL_10_1;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
