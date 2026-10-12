-- Temporäre staging Tabellen einrichten
	create or replace table etl.t_dim_store_hist_a like core.t_dim_store_hist;
	create or replace table etl.t_dim_store_hist_b like core.t_dim_store_hist;
	create or replace table etl.t_dim_store_hist_c like core.t_dim_store_hist;
	alter table etl.t_dim_store_hist_b alter (STORE_SID drop not null);
	create or replace table etl.t_dim_store_hist_temp like core.t_dim_store_hist;
	CREATE OR REPLACE TABLE ETL.store_keys_stage_a LIKE ETL.store_keys;

-- Lidl Store Daten aus Replikationsquelle holen	
	insert into etl.t_dim_store_hist_a (STORE_SID,DWH_VALID_FROM,DWH_VALID_TO,DWH_VALID_FG,LOB_CD,LOB_NAME,COMPANY_ID,COMPANY_NAME,STORE_NR,STORE_NAME,STORE_ACTIVE_FG,STREET_NAME,HOUSE_NR,CITY_NAME,ZIP,COUNTRY_POL_CD,COUNTRY_POL_NAME,DWH_CREATED_TMSP,DWH_UPDATED_TMSP)
		select DISTINCT
		1 AS STORE_SID
		,iff(st.REAL_OPEN_DT is not null, st.REAL_OPEN_DT, '1900-01-01') AS DWH_VALID_FROM
		,iff(st.CLOSE_DT is not null, st.CLOSE_DT, '9999-12-31')  AS DWH_VALID_TO
		,iff(st.CLOSE_DT < current_date, 0, 1) AS DWH_VALID_FG
		,'L' AS LOB_CD
		,'Lidl' AS LOB_NAME
        ,st.SALES_WH_NR as COMPANY_ID
		,wh.SALES_WH_NAME AS COMPANY_NAME
		,st.STORE_NR as STORE_NR
		,st.STORE_NAME as STORE_NAME
		,st.STORE_ACTIVE_FG As Store_Active_FG
		,st.STREET_NAME AS Street_NAME
		,st.HOUSE_NR AS HOUSE_NR
		,st.CITY_NAME AS CITY_NAME
		,st.ZIP AS ZIP
		,st.COUNTRY_POL_CD AS COUNTRY_POL_CD
		,st.COUNTRY_POL_NAME AS COUNTRY_POL_NAME
		,st.DWH_CREATED AS DWH_CREATED_TIMESTAMP
		,st.DWH_UPDATED AS DWH_updated_TIMESTAMP

		
	from core.t_dim_store st
	left JOIN core.t_dim_sales_warehouse wh
		on st.SALES_WH_NR = wh.SALES_WH_NR
		and st.COUNTRY_POL_CD = wh.LIDL_COUNTRY_CD
	where store_nr is not NULL
	and store_nr > 0
	;

-- KFL Store Daten aus Replikationsquelle holen
    insert into etl.t_dim_store_hist_a  (STORE_SID,DWH_VALID_FROM,DWH_VALID_TO,DWH_VALID_FG,LOB_CD,LOB_NAME,COMPANY_ID,COMPANY_NAME,STORE_NR,STORE_NAME,STORE_ACTIVE_FG,STREET_NAME,HOUSE_NR,CITY_NAME,ZIP,COUNTRY_POL_CD,COUNTRY_POL_NAME,DWH_CREATED_TMSP,DWH_UPDATED_TMSP)   
        select DISTINCT
        t1.WUP_ID AS STORE_SID
        ,iff(t1.DAT_VON is not null, t1.DAT_VON, '1900-01-01') AS DWH_VALID_FROM
        ,iff(t1.DAT_BIS is not null, t1.DAT_BIS, '9999-12-31') AS DWH_VALID_TO
        ,iff(DWH_VALID_TO < current_date, 0, 1) AS DWH_VALID_FG
        ,'K' AS LOB_CD
        ,'Kaufland' AS LOB_NAME
        ,t1.buchungskreis_id AS COMPANY_ID
        ,t3.buchungskreis_bez AS COMPANY_NAME
        ,t1.WUP_ID as STORE_NR
        ,t1.WUP_NAME_E as STORE_NAME
        ,DWH_VALID_FG As Store_Active_FG
        ,t1.WUP_STR AS Street_NAME
        ,NULL AS HOUSE_NR
        ,t1.WUP_STANDORT AS CITY_NAME
        ,t1.WUP_PLZ AS ZIP
        ,t1.LAND_ID AS COUNTRY_POL_CD
        ,t2.COUNTRY_POL_NAME AS COUNTRY_POL_NAME
        ,current_timestamp
        ,current_timestamp
        
    from core.wup t1  
    left join core.t_dim_country_political t2
        on t1.LAND_ID = t2.COUNTRY_POL_CD
    join etl.buchungskreis_spr_zu t3
        on t1.mandant_id = t3.mandant_id 
        and t1.buchungskreis_id = t3.buchungskreis_id 
        and dat_bis >= current_date 
        and spr_id = 22
   join etl.l_system t4
        on t3.system_id = t4.system_id 
        and system_gruppe ='SAP RET'     
    where NB_ID = 0
    ;    
      
-- SIDs von vorhandenen Stores holen
	insert into etl.t_dim_store_hist_b (STORE_SID,DWH_VALID_FROM,DWH_VALID_TO,DWH_VALID_FG,LOB_CD,LOB_NAME,COMPANY_ID,COMPANY_NAME,STORE_NR,STORE_NAME,STORE_ACTIVE_FG,STREET_NAME,HOUSE_NR,CITY_NAME,ZIP,COUNTRY_POL_CD,COUNTRY_POL_NAME,DWH_CREATED_TMSP,DWH_UPDATED_TMSP)
	select DISTINCT
		b.STORE_SID
		,a. DWH_VALID_FROM
		,a.DWH_VALID_TO
		,a.DWH_VALID_FG
		,a.LOB_CD
		,a.LOB_NAME
        ,a.COMPANY_ID
		,a.COMPANY_NAME
		,a.STORE_NR
		,a.STORE_NAME
		,a.STORE_ACTIVE_FG
		,a.STREET_NAME
		,a.HOUSE_NR
		,a.CITY_NAME
		,a.ZIP
		,a.COUNTRY_POL_CD
		,a.COUNTRY_POL_NAME
		,a.DWH_CREATED_TMSP
		,a.DWH_UPDATED_TMSP
		

	from etl.t_dim_store_hist_a a
	left join core.t_dim_store_hist b
		on a.store_nr = b.store_nr
		and a.country_pol_cd = b.country_pol_cd
		and a.LOB_CD = b.LOB_CD
	;
	
-- neue SIDs generieren
	INSERT INTO ETL.store_keys_stage_a
	SELECT
		src.STORE_SID_NEW
		,src.STORE_NR
		,src.LOB_CD
		,src.COUNTRY_POL_CD
	FROM 
		   (select temp.*, max_seq + row_number() over(order by 1) as STORE_SID_NEW
		from (select distinct * from etl.t_dim_store_hist_b) as temp
		cross join  (SELECT MAX(STORE_SID) as max_seq FROM ETL.store_keys)
		where temp.store_sid is null) as src;  
		
-- SIDs in Tabelle ablegen          
	MERGE INTO ETL.store_keys AS tgt
			USING (SELECT DISTINCT   STORE_SID 
									,STORE_NR
									,LOB_CD
									,COUNTRY_POL_CD

	FROM   ETL.store_keys_stage_a
	WHERE STORE_SID IS NOT NULL
				  ) AS src  
			  ON    tgt.STORE_NR = src.STORE_NR
					AND tgt.LOB_CD = src.LOB_CD
					AND tgt.COUNTRY_POL_CD = src.COUNTRY_POL_CD

			WHEN NOT MATCHED THEN INSERT
				   (                STORE_SID 
									,STORE_NR
									,LOB_CD
									,COUNTRY_POL_CD
				   )
			VALUES (                src.STORE_SID 
									,src.STORE_NR
									,src.LOB_CD
									,src.COUNTRY_POL_CD);

-- Lidl Store Daten mit SIDs anreichern									
	insert into etl.t_dim_store_hist_c (STORE_SID,DWH_VALID_FROM,DWH_VALID_TO,DWH_VALID_FG,LOB_CD,LOB_NAME,COMPANY_ID,COMPANY_NAME,STORE_NR,STORE_NAME,STORE_ACTIVE_FG,STREET_NAME,HOUSE_NR,CITY_NAME,ZIP,COUNTRY_POL_CD,COUNTRY_POL_NAME,DWH_CREATED_TMSP,DWH_UPDATED_TMSP)
	select DISTINCT
		b.STORE_SID
		,a. DWH_VALID_FROM
		,a.DWH_VALID_TO
		,a.DWH_VALID_FG
		,a.LOB_CD
		,a.LOB_NAME
        ,a.COMPANY_ID
		,a.COMPANY_NAME
		,a.STORE_NR
		,a.STORE_NAME
		,a.STORE_ACTIVE_FG
		,a.STREET_NAME
		,a.HOUSE_NR
		,a.CITY_NAME
		,a.ZIP
		,a.COUNTRY_POL_CD
		,a.COUNTRY_POL_NAME
		,a.DWH_CREATED_TMSP
		,a.DWH_UPDATED_TMSP
		

	from etl.t_dim_store_hist_a a
	left join ETL.store_keys b
		on a.store_nr = b.store_nr
		and a.country_pol_cd = b.country_pol_cd
		and a.LOB_CD = b.LOB_CD

	;

-- alte Lidl Store Informationen löschen, mit ausnahme der Stores, die nicht aus der Replikation kommen
	delete
	from core.t_dim_store_hist
	where store_sid not in (37,5237,5235,6578)
	;

--Store_hist Tabelle mit Lidl Stores befüllen
	insert into core.t_dim_store_hist (STORE_SID,DWH_VALID_FROM,DWH_VALID_TO,DWH_VALID_FG,LOB_CD,LOB_NAME,COMPANY_ID,COMPANY_NAME,STORE_NR,STORE_NAME,STORE_ACTIVE_FG,STREET_NAME,HOUSE_NR,CITY_NAME,ZIP,COUNTRY_POL_CD,COUNTRY_POL_NAME,DWH_CREATED_TMSP,DWH_UPDATED_TMSP)
	select 
		STORE_SID
		,DWH_VALID_FROM
		,DWH_VALID_TO
		,DWH_VALID_FG
		,LOB_CD
		,LOB_NAME
        ,COMPANY_ID
		,COMPANY_NAME
		,STORE_NR
		,STORE_NAME
		,STORE_ACTIVE_FG
		,STREET_NAME
		,HOUSE_NR
		,CITY_NAME
		,ZIP
		,COUNTRY_POL_CD
		,COUNTRY_POL_NAME
		,DWH_CREATED_TMSP
		,DWH_UPDATED_TMSP
		

	from etl.t_dim_store_hist_c
	;
