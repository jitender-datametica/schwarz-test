--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.art_pm_vw_zu_per_2
WHERE vk_brutto IS NULL;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


DELETE FROM dbp_data.art_pm_vw_zu_per_2 AS T2
WHERE EXISTS (
    SELECT *
    FROM (
        SELECT
            mandant_id,
            art_id,
            vw_id,
            dat_von,
            pm_id,
            preistyp_id
        FROM ${TEMP_TABLE} AS T1_2
        GROUP BY
            art_id,
            pm_id,
            vw_id,
            mandant_id,
            preistyp_id,
            dat_von
    ) AS t0
    WHERE
        mandant_id = T2.mandant_id
        AND art_id = T2.art_id
        AND vw_id = T2.vw_id
        AND pm_id = T2.pm_id
        AND preistyp_id = T2.preistyp_id
        AND dat_von <= T2.dat_von
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_data.art_pm_vw_zu_per_2 SET
    dat_bis = DATE_SUB(t1.dat_von_, INTERVAL 1 DAY) FROM (
    SELECT
        mandant_id AS mandant_id_,
        art_id AS art_id_,
        vw_id AS vw_id_,
        MIN(dat_von) AS dat_von_,
        pm_id AS pm_id_,
        preistyp_id AS preistyp_id_
    FROM ${TEMP_TABLE} AS T1_2
    GROUP BY
        mandant_id_,
        art_id_,
        vw_id_,
        pm_id_,
        preistyp_id_
) AS t1_2
WHERE
    art_pm_vw_zu_per.mandant_id = t1.mandant_id_ AND art_pm_vw_zu_per.art_id = t1.art_id_ AND art_pm_vw_zu_per.vw_id =
    t1.vw_id_ AND art_pm_vw_zu_per.pm_id = t1.pm_id_ AND art_pm_vw_zu_per.preistyp_id = t1.preistyp_id_ AND
    art_pm_vw_zu_per.dat_bis >= t1.dat_von_;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* DBP_ETL.art_pm_vw_zu_per_temp */ INSERT INTO dbp_data.art_pm_vw_zu_per_2 (
    art_id, pm_id, vw_id,
    mandant_id, preistyp_id, dat_bis, wrg_id, dat_von, vk_brutto
)
(SELECT
    art_id,
    pm_id,
    vw_id,
    mandant_id,
    preistyp_id,
    dat_bis,
    wrg_id,
    dat_von,
    vk_brutto
FROM ${TEMP_TABLE} AS T1_2);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_DATA.art_pm_vw_zu_per_2 (art_id
--	                              ,pm_id
--	                              ,vw_id
--	                              ,mandant_id
--	                              ,preistyp_id
--	                              ,dat_bis
--	                              ,dat_von
--	                              ,vk_brutto)
--SELECT a.art_id
--      ,c.wtag_id AS pm_id
--      ,6 AS vw_id
--      ,1 AS mandant_id
--      ,0 AS preistyp_id
--      ,CAST(80991231 AS DATE) AS dat_bis
--      ,CAST(1160925 AS DATE) AS dat_von
--      ,NULL AS vk_brutto
--FROM DBX_DATA.art_2 a
--JOIN DBX_DATA.art_wg_zu_per_2 b
--  ON a.mandant_id = b.mandant_id AND
--     a.art_id = b.art_id AND
--     b.arthiertyp_id = 2 AND
--     b.dat_bis = 80991231 AND
--     b.wg_id NOT IN (1,2,3,5,9,10,12,13,19)
--JOIN (SELECT wtag_id
--      FROM DBX_DATA.tag_2
--      WHERE wtag_id BETWEEN 1 AND 4
--      GROUP BY 1) c
--  ON 1 = 1
--WHERE a.mandant_id = 1 AND
--      a.art_id NOT IN (SELECT art_id
--                       FROM DBX_DATA.art_pm_vw_zu_per_2
--                       WHERE dat_bis >= 1160925 AND
--                             mandant_id = 1 AND
--                             preistyp_id = 0 AND
--                             vw_id = 6) AND
--      a.dat_bis = 80991231
--;
--
--Comment from validation checker
--MESSAGE: SQL compilation error:
--Can not convert parameter '1160925' of type [INTEGER] into expected type [DATE]
--translated statement


-- mfialkiewicz
-- ,CAST(1160925 AS DATE) AS dat_von
INSERT INTO dbp_data.art_pm_vw_zu_per_2 (
    art_id,
    pm_id, vw_id, mandant_id, preistyp_id, dat_bis, wrg_id, dat_von, vk_brutto
)
(
    SELECT
        A.art_id,
        c.wtag_id AS pm_id,
        6 AS vw_id,
        1 AS mandant_id,
        0 AS preistyp_id,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        CAST(NULL AS STRING) AS wrg_id,
        PARSE_DATE('%F', '2016-09-25') AS dat_von,
        NULL AS vk_brutto
    FROM dbp_data.art_2 AS A
    INNER JOIN dbp_data.art_wg_zu_per_2 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = PARSE_DATE('%F', '9999-12-31') AND B.wg_id NOT IN (1, 2, 3, 5, 9, 10, 12, 13, 19)
    INNER JOIN (
        SELECT wtag_id
        FROM dbp_data.tag_2
        WHERE wtag_id BETWEEN 1 AND 4
        GROUP BY wtag_id
    ) AS c
        ON TRUE
    WHERE
        A.mandant_id = 1
        AND A.dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND A.art_id NOT IN (
            SELECT art_id
            FROM dbp_data.art_pm_vw_zu_per_2
            WHERE
                dat_bis >= PARSE_DATE('%F', '2016-09-25')
                AND mandant_id = 1
                AND preistyp_id = 0
                AND vw_id = 6
        )
);


--original statement
--INSERT INTO DBX_DATA.art_pm_vw_zu_per_2
--(
--	art_id
--	,pm_id
--	,vw_id
--	,mandant_id
--	,preistyp_id
--	,dat_bis
--	,dat_von
--	,vk_brutto
--)
--SELECT
--	art_id
--	,pm_id
--	,vw_id
--	,mandant_id
--	,preistyp_id
--	,dat_bis_fehlend as dat_bis
--	,dat_von_fehlend as dat_von
--	,NULL AS vk_brutto
--FROM
--	(
--	
--	SELECT
--			t1.*
--			,CASE WHEN (MSUM (CAST(t1.dat_von AS INTEGER), 2, t1.dat_von DESC ) - CAST(t1.dat_von AS INTEGER)) = 0
--			THEN CAST('99991231' AS DATE FORMAT 'YYYYMMDD')
--			ELSE CAST((MSUM (CAST(t1.dat_von AS INTEGER), 2, t1.dat_von DESC ) - CAST(t1.dat_von AS INTEGER)) AS DATE) -1
--			END AS dat_bis_fehlend
--			,CASE WHEN dat_bis=80991231 THEN NULL ELSE  dat_bis+1 END AS dat_von_fehlend
--	
--	FROM
--			DBX_DATA.art_pm_vw_zu_per_2 t1_2
--	WHERE
--		 	preistyp_id=0 AND
--                        mandant_id <> 1
--	GROUP BY
--		t1.art_id
--		,t1.pm_id
--		,t1.vw_id
--		,t1.mandant_id
--		,preistyp_id
--	)dt1
--WHERE
--	 dat_bis < dat_bis_fehlend  
--; 

--translated statement


/* ,CASE WHEN (MSUM (CAST(t1.dat_von AS INTEGER), 2, t1.dat_von DESC ) - CAST(t1.dat_von AS INTEGER)) = 0
			THEN CAST('99991231' AS DATE FORMAT 'YYYYMMDD')
			ELSE CAST((MSUM (CAST(t1.dat_von AS INTEGER), 2, t1.dat_von DESC ) - CAST(t1.dat_von AS INTEGER)) AS DATE) -1
			END AS dat_bis_fehlend */
INSERT INTO dbp_data.art_pm_vw_zu_per_2 (
    art_id, pm_id, vw_id, mandant_id, preistyp_id, dat_bis, wrg_id,
    dat_von, vk_brutto
)
(SELECT
    art_id,
    pm_id,
    vw_id,
    mandant_id,
    preistyp_id,
    CASE
        WHEN (SUM(ROUND(CAST(
            FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            art_id, pm_id, vw_id,
            mandant_id, preistyp_id
        ORDER BY dat_von IS NULL, dat_von
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC),
        0) = 0
            THEN PARSE_DATE('%Y%m%d', '99991231')
        ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(
            FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            art_id,
            pm_id, vw_id, mandant_id, preistyp_id
        ORDER BY dat_von IS NULL, dat_von
        ROWS BETWEEN 1 PRECEDING AND
        CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) AS STRING)), INTERVAL -1 DAY)
    END AS dat_bis,
    wrg_id,
    CASE
        WHEN dat_bis = PARSE_DATE('%F', '9999-12-31')
            THEN NULL
        ELSE DATE_ADD(dat_bis, INTERVAL 1 DAY)
    END AS dat_von,
    NULL AS vk_brutto
FROM dbp_data.art_pm_vw_zu_per_2 AS T1_2
WHERE
    preistyp_id = 0
    AND mandant_id <> 1 /* GROUP BY
		t1.art_id
		,t1.pm_id
		,t1.vw_id
		,t1.mandant_id
		,preistyp_id */
QUALIFY dat_bis < CASE
    WHEN (SUM(ROUND(CAST(
        FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
        art_id, pm_id, vw_id,
        mandant_id, preistyp_id
    ORDER BY dat_von IS NULL, dat_von
    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC),
    0) = 0
        THEN PARSE_DATE('%Y%m%d', '99991231')
    ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(
        FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
        art_id,
        pm_id, vw_id, mandant_id, preistyp_id
    ORDER BY dat_von IS NULL, dat_von
    ROWS BETWEEN 1 PRECEDING AND
    CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) AS STRING)), INTERVAL -1 DAY)
END);


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Modulo operator does not exist in Snowflake. Use MOD function instead.


/* fuer die betr. WG-en in DE sollen lediglich die pm_id 1,10 und preistyp 0 geladen werden */
/* fuer die betr. wg-en in de sollen lediglich die pm_id 1,10 un dpreistyp 0 geladen werden */ INSERT INTO
dbp_data.art_pm_vw_zu_per_2 (
    art_id, pm_id, vw_id, mandant_id, preistyp_id, dat_bis, wrg_id, dat_von,
    vk_brutto
)
(
    SELECT
        T1.art_id,
        T4.pm_id,
        T2.vw_id,
        1 AS mandant_id,
        T3.preistyp_id,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        CAST(NULL AS STRING) AS wrg_id,
        PARSE_DATE('%F', '1900-01-01') AS dat_von,
        NULL AS vk_brutto
    FROM dbp_data.art_2 AS T1_2
    INNER JOIN dbp_data.l_vw_2 AS T2 ON T1.mandant_id = T2.mandant_id AND T2.vw_id IN (6)
    /* momentan sind in DE fuer die WG_ID not in (1,2,3,5,9,10,12,13,19) die Vertriebswege 1,2,3 relevant */
    INNER JOIN dbp_data.l_preistyp_2 AS T3 ON T1.mandant_id = T3.mandant_id AND T3.preistyp_id IN (0)
    /* momentan sind in DE fuer die WG_ID not in (1,2,3,5,9,10,12,13,19) die Preistypen 0 reelevant */
    INNER JOIN dbp_data.pm_2 AS T4
        ON T1.mandant_id = T4.mandant_id AND T4.pm_id IN (
            1, 2, 3, 4, 5, 6, 7, 8,
            9, 10
        ) /* momentan sind in DE fuer die WG_ID not in (1,2,3,5,9,10,12,13,19) die Preismodule 1,10 relevant */
    INNER JOIN dbp_data.art_wg_zu_per_2 AS T5
        ON
            T1.mandant_id = T5.mandant_id AND T1.art_id = T5.art_id AND
            T5.dat_bis = PARSE_DATE('%F', '9999-12-31') AND T5.arthiertyp_id = 2
    INNER JOIN dbp_data.wg_per_2 AS T6
        ON
            T5.mandant_id = T6.mandant_id AND T5.wg_id = T6.wg_id AND T6.dat_bis
            = PARSE_DATE('%F', '9999-12-31') AND T6.arthiertyp_id = 2
    WHERE
        T1.mandant_id = 1
        AND T1.wg_art_fg = 0
        AND T6.wg_id NOT IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                mandant_id = 1
                AND wg_filter_id = 18
                AND arthiertyp_id = 2
        )
        AND (T1.mandant_id, T1.art_id, T2.vw_id, T4.pm_id, T3.preistyp_id) NOT IN (
            SELECT (
                T10.mandant_id, T10.art_id, T10.vw_id,
                T10.pm_id, T10.preistyp_id
            )
            FROM dbp_data.art_pm_vw_zu_per_2 AS T10
            INNER JOIN dbp_data.art_wg_zu_per_2 AS T50
                ON
                    T10.mandant_id = T50.mandant_id AND T10.art_id = T50.art_id
                    AND T50.dat_bis = PARSE_DATE('%F', '9999-12-31') AND T50.arthiertyp_id = 2
            INNER JOIN dbp_data.wg_per_2 AS T60
                ON
                    T50.mandant_id = T60.mandant_id AND T50.wg_id = T60.wg_id AND
                    T60.dat_bis = PARSE_DATE('%F', '9999-12-31') AND T60.arthiertyp_id = 2
            WHERE
                T10.mandant_id = 1
                AND T10.pm_id IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10) /* fuer die betr. WG-en in DE sind Preismodule 1,10 relevant */
                AND T10.vw_id IN (6) /* fuer die betr. WG-en in DE sind nur die Vertriebswege 1,2,3 */
                AND T10.preistyp_id IN (0) /* fuer die betr. WG-en in DE sind nur die preistypen 0 reelevant */
                AND T60.wg_id NOT IN (
                    SELECT wg_id
                    FROM dbp_data.wg_filter_zu_2
                    WHERE
                        mandant_id = 1
                        AND wg_filter_id = 18
                        AND arthiertyp_id = 2
                )
        )
);


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Modulo operator does not exist in Snowflake. Use MOD function instead.


/* fuer die betr. WG-en in DE sollen die pm_id 1,1,2,3,4,5,6,7,8,9,10 und preistyp 0,1,2 geladen werden */
/* alle Preisklassen und -arten sollen nur fuer die FLW - Warengruppen geladen werden */ INSERT INTO
dbp_data.art_pm_vw_zu_per_2 (
    art_id, pm_id, vw_id, mandant_id, preistyp_id, dat_bis, wrg_id, dat_von,
    vk_brutto
)
(
    SELECT
        T1.art_id,
        T4.pm_id,
        T2.vw_id,
        1 AS mandant_id,
        T3.preistyp_id,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        CAST(NULL AS STRING) AS wrg_id,
        PARSE_DATE('%F', '1900-01-01') AS dat_von,
        NULL AS vk_brutto
    FROM dbp_data.art_2 AS T1_2
    INNER JOIN dbp_data.l_vw_2 AS T2 ON T1.mandant_id = T2.mandant_id AND T2.vw_id IN (6)
    /* momentan sind in DE fuer die WG_ID: 1,2,3,5,9,10,12,13,19 die Vertriebswege 1,2,3 relevant */
    INNER JOIN dbp_data.l_preistyp_2 AS T3 ON T1.mandant_id = T3.mandant_id AND T3.preistyp_id IN (0, 1, 2)
    /* momentan sind in DE fuer die WG_ID: 1,2,3,5,9,10,12,13,19 die Preistypen 0,1,2 vorhanden und reelevant */
    INNER JOIN dbp_data.pm_2 AS T4
        ON T1.mandant_id = T4.mandant_id AND T4.pm_id IN (
            1, 2, 3, 4, 5, 6, 7, 8,
            9, 10
        ) /* momentan sind in DE fuer die WG_ID: 1,2,3,5,9,10,12,13,19 die Preismodule 1-10 relevant */
    INNER JOIN dbp_data.art_wg_zu_per_2 AS T5
        ON
            T1.mandant_id = T5.mandant_id AND T1.art_id = T5.art_id AND
            T5.dat_bis = PARSE_DATE('%F', '9999-12-31') AND T5.arthiertyp_id = 2
    INNER JOIN dbp_data.wg_per_2 AS T6
        ON
            T5.mandant_id = T6.mandant_id AND T5.wg_id = T6.wg_id AND T6.dat_bis
            = PARSE_DATE('%F', '9999-12-31') AND T6.arthiertyp_id = 2
    WHERE
        T1.mandant_id = 1
        AND T6.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                mandant_id = 1
                AND wg_filter_id = 18
                AND arthiertyp_id = 2
        )
        AND T1.wg_art_fg = 0
        AND (T1.mandant_id, T1.art_id, T2.vw_id, T4.pm_id, T3.preistyp_id) NOT IN (
            SELECT (
                T10.mandant_id, T10.art_id, T10.vw_id,
                T10.pm_id, T10.preistyp_id
            )
            FROM dbp_data.art_pm_vw_zu_per_2 AS T10
            INNER JOIN dbp_data.art_wg_zu_per_2 AS T50
                ON
                    T10.mandant_id = T50.mandant_id AND T10.art_id = T50.art_id
                    AND T50.dat_bis = PARSE_DATE('%F', '9999-12-31') AND T50.arthiertyp_id = 2
            INNER JOIN dbp_data.wg_per_2 AS T60
                ON
                    T50.mandant_id = T60.mandant_id AND T50.wg_id = T60.wg_id AND
                    T60.dat_bis = PARSE_DATE('%F', '9999-12-31') AND T60.arthiertyp_id = 2
            WHERE
                T10.mandant_id = 1
                AND T60.wg_id IN (
                    SELECT wg_id
                    FROM dbp_data.wg_filter_zu_2
                    WHERE
                        mandant_id = 1
                        AND wg_filter_id = 18
                        AND arthiertyp_id = 2
                )
                AND T10.pm_id IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
                /* fuer die betr. WG-en in DE sind Preismodule 1,1,2,3,4,5,6,7,8,9,10 relevant */
                AND T10.vw_id IN (6) /* fuer die betr. WG-en in DE sind nur die Vertriebswege 1,2,3 relevant */
                AND T10.preistyp_id IN (0, 1, 2) /* fuer die betr. WG-en in DE sind nur die preistypen 0,1,2 reelevant */
        )
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.art_pm_vw_zu_per_2 (
    art_id, pm_id, vw_id, mandant_id, preistyp_id, dat_bis, wrg_id,
    dat_von, vk_brutto
)
(SELECT
    art_id,
    pm_id,
    vw_id,
    mandant_id,
    preistyp_id,
    dat_bis,
    SUBSTR(CAST(wrg_id AS STRING), 1, 3) AS wrg_id,
    dat_von,
    vk_brutto
FROM ((((
    SELECT
        art_id,
        10 AS vw_id,
        1 AS pm_id,
        mandant_id,
        0 AS preistyp_id,
        PARSE_DATE('%F', '1900-01-01') AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        NULL AS vk_brutto,
        NULL AS wrg_id
    FROM dbp_data.art_2 AS T1_2
    WHERE
        mandant_id <> 1
        AND wg_art_fg = 0
        AND art_id NOT IN (
            SELECT art_id
            FROM dbp_data.art_pm_vw_zu_per_2
            WHERE
                mandant_id <> 1
                AND pm_id = 1
                AND vw_id = 10
                AND preistyp_id = 0
        )
    UNION DISTINCT
    SELECT
        art_id,
        10 AS vw_id,
        2 AS pm_id,
        mandant_id,
        0 AS preistyp_id,
        PARSE_DATE('%F', '1900-01-01') AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        NULL AS vk_brutto,
        NULL AS wrg_id
    FROM dbp_data.art_2 AS T1_2
    WHERE
        mandant_id <> 1
        AND wg_art_fg = 0
        AND art_id NOT IN (
            SELECT art_id
            FROM dbp_data.art_pm_vw_zu_per_2
            WHERE
                mandant_id <> 1
                AND pm_id = 2
                AND vw_id = 10
                AND preistyp_id = 0
        )
)
UNION DISTINCT
SELECT
    art_id,
    10 AS vw_id,
    3 AS pm_id,
    mandant_id,
    0 AS preistyp_id,
    PARSE_DATE('%F', '1900-01-01') AS dat_von,
    PARSE_DATE('%F', '9999-12-31') AS dat_bis,
    NULL AS vk_brutto,
    NULL AS wrg_id
FROM dbp_data.art_2 AS T1_2
WHERE
    mandant_id <> 1
    AND wg_art_fg = 0
    AND art_id NOT IN (
        SELECT art_id
        FROM dbp_data.art_pm_vw_zu_per_2
        WHERE
            mandant_id <> 1
            AND pm_id = 3
            AND vw_id = 10
            AND preistyp_id = 0
    )
)
UNION DISTINCT
SELECT
    art_id,
    10 AS vw_id,
    4 AS pm_id,
    mandant_id,
    0 AS preistyp_id,
    PARSE_DATE('%F', '1900-01-01') AS dat_von,
    PARSE_DATE('%F', '9999-12-31') AS dat_bis,
    NULL AS vk_brutto,
    NULL AS wrg_id
FROM dbp_data.art_2 AS T1_2
WHERE
    mandant_id <> 1
    AND wg_art_fg = 0
    AND art_id NOT IN (
        SELECT art_id
        FROM dbp_data.art_pm_vw_zu_per_2
        WHERE
            mandant_id <> 1
            AND pm_id = 4
            AND vw_id = 10
            AND preistyp_id = 0
    )
)
UNION DISTINCT
SELECT
    art_id,
    10 AS vw_id,
    5 AS pm_id,
    mandant_id,
    0 AS preistyp_id,
    PARSE_DATE('%F', '1900-01-01') AS dat_von,
    PARSE_DATE('%F', '9999-12-31') AS dat_bis,
    NULL AS vk_brutto,
    NULL AS wrg_id
FROM dbp_data.art_2 AS T1_2
WHERE
    mandant_id <> 1
    AND wg_art_fg = 0
    AND art_id NOT IN (
        SELECT art_id
        FROM dbp_data.art_pm_vw_zu_per_2
        WHERE
            mandant_id <> 1
            AND pm_id = 5
            AND vw_id = 10
            AND preistyp_id = 0
    )
) AS t20);


-- 12.02.2026, -dbay-
--
-- Etwaige Duplikate killen. Scheint irgendwie erforderlich zu sein,
-- nach gut 15 Jahren? Strange!

-- 1. Erst einmal aufs Attribut DAT_BIS.


CREATE OR REPLACE TEMPORARY TABLE _dups_2 AS
SELECT
    mandant_id,
    art_id,
    pm_id,
    vw_id,
    preistyp_id,
    dat_bis,
    MIN(vk_brutto) AS min_vk_brutto,
    MAX(vk_brutto) AS max_vk_brutto,
    COUNT(*) AS anz
FROM dbp_data.art_pm_vw_zu_per_2
GROUP BY
    art_id,
    pm_id,
    vw_id,
    mandant_id,
    preistyp_id,
    dat_bis
HAVING anz > 1;


CREATE OR REPLACE TEMPORARY TABLE _fix_art_pm AS
SELECT
    A.art_id,
    A.pm_id,
    A.vw_id,
    A.mandant_id,
    A.preistyp_id,
    A.dat_bis,
    MIN(A.dat_von) AS dat_von,
    MAX(A.vk_brutto) AS vk_brutto,
    MAX(A.td_insert) AS td_insert,
    MAX(A.td_update) AS td_update,
    MAX(A.wrg_id) AS wrg_id
FROM dbp_data.art_pm_vw_zu_per_2 AS A
INNER JOIN `_dups_2` AS B
    ON
        A.mandant_id = B.mandant_id AND A.pm_id = B.pm_id AND A.vw_id = B.vw_id AND A.art_id = B.art_id
        AND A.preistyp_id = B.preistyp_id AND A.dat_bis = B.dat_bis AND A.vk_brutto = B.max_vk_brutto
GROUP BY
    A.art_id,
    A.pm_id,
    A.vw_id,
    A.mandant_id,
    A.preistyp_id,
    A.dat_bis;


DELETE FROM dbp_data.art_pm_vw_zu_per_2
WHERE (mandant_id, art_id, pm_id, preistyp_id, vw_id, dat_bis) IN (SELECT (
    mandant_id, art_id, pm_id, preistyp_id, vw_id,
    dat_bis
)
FROM `_dups_2`);


INSERT INTO dbp_data.art_pm_vw_zu_per_2
(
    SELECT
        art_id,
        pm_id,
        vw_id,
        mandant_id,
        preistyp_id,
        dat_bis,
        wrg_id,
        dat_von,
        vk_brutto,
        td_insert,
        td_update
    FROM `_fix_art_pm`
    GROUP BY
        art_id,
        pm_id,
        vw_id,
        mandant_id,
        preistyp_id,
        dat_bis,
        wrg_id,
        dat_von,
        vk_brutto,
        td_insert,
        td_update
);


-- 2. Dann aufs Attribut DAT_BIS.


CREATE OR REPLACE TEMPORARY TABLE _dups_2 AS
SELECT
    mandant_id,
    art_id,
    pm_id,
    vw_id,
    preistyp_id,
    dat_von,
    MAX(dat_bis) AS max_dat_bis,
    MIN(vk_brutto) AS min_vk_brutto,
    MAX(vk_brutto) AS max_vk_brutto,
    COUNT(*) AS anz
FROM dbp_data.art_pm_vw_zu_per_2
GROUP BY
    art_id,
    pm_id,
    vw_id,
    mandant_id,
    preistyp_id,
    dat_von
HAVING anz > 1;


CREATE OR REPLACE TEMPORARY TABLE _fix_art_pm AS
SELECT
    A.art_id,
    A.pm_id,
    A.vw_id,
    A.mandant_id,
    A.preistyp_id,
    A.dat_bis,
    MIN(A.dat_von) AS dat_von,
    MAX(A.vk_brutto) AS vk_brutto,
    MAX(A.td_insert) AS td_insert,
    MAX(A.td_update) AS td_update,
    MAX(A.wrg_id) AS wrg_id
FROM dbp_data.art_pm_vw_zu_per_2 AS A
INNER JOIN `_dups_2` AS B
    ON
        A.mandant_id = B.mandant_id AND A.pm_id = B.pm_id AND A.vw_id = B.vw_id AND A.art_id = B.art_id
        AND A.preistyp_id = B.preistyp_id AND A.dat_von = B.dat_von AND
        A.dat_bis = B.max_dat_bis
GROUP BY
    A.art_id,
    A.pm_id,
    A.vw_id,
    A.mandant_id,
    A.preistyp_id,
    A.dat_bis;


DELETE FROM dbp_data.art_pm_vw_zu_per_2
WHERE (
    mandant_id, art_id, pm_id, preistyp_id, vw_id, dat_von) IN (
    SELECT (mandant_id, art_id, pm_id, preistyp_id, vw_id, dat_von)
    FROM `_dups_2`
);


INSERT INTO dbp_data.art_pm_vw_zu_per_2
(
    SELECT
        art_id,
        pm_id,
        vw_id,
        mandant_id,
        preistyp_id,
        dat_bis,
        wrg_id,
        dat_von,
        vk_brutto,
        td_insert,
        td_update
    FROM `_fix_art_pm`
    GROUP BY
        art_id,
        pm_id,
        vw_id,
        mandant_id,
        preistyp_id,
        dat_bis,
        wrg_id,
        dat_von,
        vk_brutto,
        td_insert,
        td_update
);


-- 3. Zum Abschluss die Pruefung auf Zeitreihen.
-- 
-- Erster Lauf.


CREATE OR REPLACE TEMPORARY TABLE _days AS
SELECT dat
FROM dbp_data.tag_2
WHERE dat BETWEEN (
    SELECT MIN(dat)
    FROM dbp_data.tag_2
    WHERE akt_kj = -1
) AND (CURRENT_DATE("Europe/Berlin")
);


CREATE OR REPLACE TEMPORARY TABLE _dups_2 AS
SELECT
    mandant_id,
    vw_id,
    art_id,
    preistyp_id,
    pm_id,
    min_dat_von,
    max_dat_von,
    min_dat_bis,
    max_dat_bis
FROM (
    SELECT
        A.art_id,
        A.pm_id,
        A.vw_id,
        A.mandant_id,
        A.preistyp_id,
        MIN(A.dat_von) AS min_dat_von,
        MAX(A.dat_von) AS max_dat_von,
        MIN(A.dat_bis) AS min_dat_bis,
        MAX(A.dat_bis) AS max_dat_bis
    FROM dbp_data.art_pm_vw_zu_per_2 AS A
    INNER JOIN `_days` AS B ON B.dat BETWEEN A.dat_von AND A.dat_bis
    GROUP BY
        A.art_id,
        A.pm_id,
        A.vw_id,
        A.mandant_id,
        A.preistyp_id,
        B.dat
    HAVING COUNT(*) > 1
) AS x
GROUP BY
    art_id,
    pm_id,
    vw_id,
    mandant_id,
    preistyp_id,
    min_dat_von,
    max_dat_von,
    min_dat_bis,
    max_dat_bis;


CREATE OR REPLACE TEMPORARY TABLE _fix_art_pm AS
SELECT
    A.art_id,
    A.pm_id,
    A.vw_id,
    A.mandant_id,
    A.preistyp_id,
    MAX(A.dat_bis) AS dat_bis,
    MIN(A.dat_von) AS dat_von,
    MAX(A.vk_brutto) AS vk_brutto,
    MAX(A.td_insert) AS td_insert,
    MAX(A.td_update) AS td_update,
    MAX(A.wrg_id) AS wrg_id
FROM dbp_data.art_pm_vw_zu_per_2 AS A
INNER JOIN `_dups_2` AS B
    ON
        A.mandant_id = B.mandant_id AND A.pm_id = B.pm_id AND A.vw_id = B.vw_id AND A.art_id = B.art_id
        AND A.preistyp_id = B.preistyp_id AND A.dat_bis = B.max_dat_bis
GROUP BY
    A.art_id,
    A.pm_id,
    A.vw_id,
    A.mandant_id,
    A.preistyp_id;


DELETE FROM dbp_data.art_pm_vw_zu_per_2
WHERE (mandant_id, vw_id, art_id, preistyp_id, pm_id, dat_bis) IN (SELECT (
    mandant_id, vw_id, art_id, preistyp_id, pm_id,
    min_dat_bis
)
FROM `_dups_2`);


INSERT INTO dbp_data.art_pm_vw_zu_per_2
(
    SELECT
        art_id,
        pm_id,
        vw_id,
        mandant_id,
        preistyp_id,
        dat_bis,
        wrg_id,
        dat_von,
        vk_brutto,
        td_insert,
        td_update
    FROM `_fix_art_pm`
    GROUP BY
        art_id,
        pm_id,
        vw_id,
        mandant_id,
        preistyp_id,
        dat_bis,
        wrg_id,
        dat_von,
        vk_brutto,
        td_insert,
        td_update
);


-- 3. Zum Abschluss die Pruefung auf Zeitreihen.
-- 
-- Zweiter Lauf.


CREATE OR REPLACE TEMPORARY TABLE _days AS
SELECT dat
FROM dbp_data.tag_2
WHERE dat BETWEEN (
    SELECT MIN(dat)
    FROM dbp_data.tag_2
    WHERE akt_kj = -1
) AND (CURRENT_DATE("Europe/Berlin")
);


CREATE OR REPLACE TEMPORARY TABLE _dups_2 AS
SELECT
    mandant_id,
    vw_id,
    art_id,
    preistyp_id,
    pm_id,
    min_dat_von,
    max_dat_von,
    min_dat_bis,
    max_dat_bis
FROM (
    SELECT
        A.art_id,
        A.pm_id,
        A.vw_id,
        A.mandant_id,
        A.preistyp_id,
        MIN(A.dat_von) AS min_dat_von,
        MAX(A.dat_von) AS max_dat_von,
        MIN(A.dat_bis) AS min_dat_bis,
        MAX(A.dat_bis) AS max_dat_bis
    FROM dbp_data.art_pm_vw_zu_per_2 AS A
    INNER JOIN `_days` AS B ON B.dat BETWEEN A.dat_von AND A.dat_bis
    GROUP BY
        A.art_id,
        A.pm_id,
        A.vw_id,
        A.mandant_id,
        A.preistyp_id,
        B.dat
    HAVING COUNT(*) > 1
) AS x
GROUP BY
    art_id,
    pm_id,
    vw_id,
    mandant_id,
    preistyp_id,
    min_dat_von,
    max_dat_von,
    min_dat_bis,
    max_dat_bis;


CREATE OR REPLACE TEMPORARY TABLE _fix_art_pm AS
SELECT
    A.art_id,
    A.pm_id,
    A.vw_id,
    A.mandant_id,
    A.preistyp_id,
    MAX(A.dat_bis) AS dat_bis,
    MIN(A.dat_von) AS dat_von,
    MAX(A.vk_brutto) AS vk_brutto,
    MAX(A.td_insert) AS td_insert,
    MAX(A.td_update) AS td_update,
    MAX(A.wrg_id) AS wrg_id
FROM dbp_data.art_pm_vw_zu_per_2 AS A
INNER JOIN `_dups_2` AS B
    ON
        A.mandant_id = B.mandant_id AND A.pm_id = B.pm_id AND A.vw_id = B.vw_id AND A.art_id = B.art_id
        AND A.preistyp_id = B.preistyp_id AND A.dat_bis = B.max_dat_bis
GROUP BY
    A.art_id,
    A.pm_id,
    A.vw_id,
    A.mandant_id,
    A.preistyp_id;


DELETE FROM dbp_data.art_pm_vw_zu_per_2
WHERE (mandant_id, vw_id, art_id, preistyp_id, pm_id, dat_bis) IN (SELECT (
    mandant_id, vw_id, art_id, preistyp_id, pm_id,
    min_dat_bis
)
FROM `_dups_2`);


INSERT INTO dbp_data.art_pm_vw_zu_per_2
(
    SELECT
        art_id,
        pm_id,
        vw_id,
        mandant_id,
        preistyp_id,
        dat_bis,
        wrg_id,
        dat_von,
        vk_brutto,
        td_insert,
        td_update
    FROM `_fix_art_pm`
    GROUP BY
        art_id,
        pm_id,
        vw_id,
        mandant_id,
        preistyp_id,
        dat_bis,
        wrg_id,
        dat_von,
        vk_brutto,
        td_insert,
        td_update
);
