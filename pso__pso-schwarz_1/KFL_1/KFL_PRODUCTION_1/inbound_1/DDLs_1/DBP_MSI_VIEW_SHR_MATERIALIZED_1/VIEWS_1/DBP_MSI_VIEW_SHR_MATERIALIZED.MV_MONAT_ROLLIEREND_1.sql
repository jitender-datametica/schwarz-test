create or replace view DBP_MSI_VIEW_SHR_MATERIALIZED.MV_MONAT_ROLLIEREND_1(
	KJMO,
	KJMO_ROLL
) as

SELECT DISTINCT
    t1.kjmo AS kjmo,
    
    
    (YEAR(DATEADD(
        MONTH, 
        -1 * offsets.c_offset, 
        TO_DATE(CAST(t1.kjmo AS VARCHAR), 'YYYYMM')
    )) * 100) + MONTH(DATEADD(
        MONTH, 
        -1 * OFFSETS.c_offset, 
        TO_DATE(CAST(t1.kjmo AS VARCHAR), 'YYYYMM')
    )) AS KJMO_12
FROM
    DBP_MSI_VIEW_SHR_MATERIALIZED.mv_monat_1 t1_1 
INNER JOIN 
    -- generating 12 months back
    (
        SELECT 
            ROW_NUMBER() OVER (ORDER BY 1) - 1 AS c_offset 
        FROM 
            TABLE(GENERATOR(ROWCOUNT => 12)) 
    ) AS OFFSETS
    -- joining rollierend months with base month
    ON TRUE
 
ORDER BY
    t1.kjmo DESC;