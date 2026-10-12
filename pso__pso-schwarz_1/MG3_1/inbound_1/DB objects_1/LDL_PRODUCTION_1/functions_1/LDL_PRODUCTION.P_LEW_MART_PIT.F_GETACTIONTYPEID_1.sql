CREATE OR REPLACE FUNCTION LDL_PRODUCTION.P_LEW_MART_PIT.F_GETACTIONTYPEID(""PBUYINGLISTTYPEID"" NUMBER(38,0), ""PITEMGRPINTSRCCD"" VARCHAR)
RETURNS NUMBER(38,0)
LANGUAGE SQL
STRICT
AS '
    iff(pBuyingListTypeID <= -1::INTEGER OR pBuyingListTypeID IS NULL OR Try_To_Number(pItemGrpIntSrcCD, 38, 0) IS NULL
		,-1::INTEGER
		,iff(pBuyingListTypeID IN (7, 8, 16)
			,iff(Try_To_Number(pItemGrpIntSrcCD, 38, 0) IN (7, 70)
				,2::INTEGER
				,3::INTEGER
               ),
               -- PV not present possible PV 
			   -- @2nd Increment need to be corrected 1 and than joined to SFO PV Info
               -1::INTEGER
           )
       )    
    ';