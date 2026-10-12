CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.AUTDI_13_3_2(
	STORE_WH
	,COUNTRY_2
	,STORE_NR
	,STATUS_2
	,ENTRYDATE
) AS
	/* Version: 1.3
	** Author:	Dominik Pfarr
	** Date: 	2023-11-03
	** Changes:	adding join to v_specialday with subquery; removing join on dd_paramter
	*/
	WITH DAYS AS (
			SELECT (
					CURRENT_DATE - ROW_NUMBER() OVER (
						ORDER BY 1
						)
					) d_date
			FROM TABLE (generator(ROWCOUNT => 30))
			)
SELECT store_wh
, country_2
, store_nr
, STATUS_2
, entrydate 
FROM 
(
    SELECT s.store_wh
    	,s.country_2
    	,s.store_nr
    	,DECODE(NVL(TO_CHAR(vm.STORE), 'YYYY'), TO_CHAR(vm.STORE), 1, 0) STATUS_2
    	,DAYS.d_date entrydate
        ,sp.store sp_store
        ,sp.reports sp_reports
    FROM DAYS
    CROSS JOIN core.t_oracle_v_dim_store_2 s
    LEFT JOIN (
    	SELECT vmil.country_2
    		,STORE
    		,entrydate
    	FROM core.t_oracle_v_FK_MIL_2 vmil
    	WHERE vmil.entrydate >= (CURRENT_DATE - 30)
    	GROUP BY STORE
    		,entrydate
    		,vmil.country_2
    	) vm
    	ON s.store_nr = vm.store
    		AND s.country_2 = vm.country_2
    		AND vm.entrydate = DAYS.d_date
    LEFT JOIN core.t_oracle_v_fk_rebuilds_2 rb
    	ON s.store_nr = rb.rb_store_nr
    		AND s.country_2 = rb.country_2
    		AND DAYS.d_date BETWEEN DATEADD(DAY, rb.rb_datefrom - 365.25 * (4712) - 1, '0000-01-01')
    			AND DATEADD(DAY, rb.rb_dateto - 365.25 * (4712) - 3, '0000-01-01')
    LEFT JOIN CORE.T_ORACLE_V_SPECIALDAY_2 sp
    	ON s.store_nr = sp.store
    		AND s.country_2 = sp.country_2
    		AND DAYS.d_date = sp.sp_day
    WHERE rb_store_nr IS NULL
    	AND s.store_nr <> 0
    	AND s.deleted = 0
)
WHERE sp_store IS NULL OR sp_reports = 1
    ;