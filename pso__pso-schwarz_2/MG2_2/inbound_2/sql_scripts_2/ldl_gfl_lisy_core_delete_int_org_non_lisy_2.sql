BEGIN TRANSACTION;

DELETE FROM core_rel.T_INTERNAL_ORGANIZATION_2
WHERE  INT_ORG_TYPE_CD = 'STORE'
	-- for which we have old information that is NOT from LISY
	and upper(DWH_NODE_CD) <> 'LISY'
	-- and for which we have new information coming from LISY
	AND INT_ORG_SID IN (
                                SELECT K.PARTY_SID
                                FROM META.T_PARTY_KEY_2 K
                                        JOIN ETL_PROCESS.T_TCACHE_LISY_CDS_ACCOUNT_SNAP_2 S
                                        ON (SUBSTR(S.IGL_NUMBER, 1, 2)) ||'|'||TO_NUMBER(SUBSTR(S.IGL_NUMBER,3,5)) = UPPER(K.PARTY_NAT_KEY_NR)
                                WHERE S.IGL_ACCOUNTTYPECODE IN (285540000, 285540009)
                                                        AND S.IGL_NUMBER IS NOT NULL
                                                        AND (S.IGL_NEODATE IS NOT NULL OR S.IGL_CLOSINGDATE IS NOT NULL ) 
                           )
;

COMMIT;
