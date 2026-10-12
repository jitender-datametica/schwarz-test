BEGIN TRANSACTION;

DELETE FROM CORE.${TST_PREFIX}T_DIM_REAL_ESTATE;

INSERT INTO CORE.${TST_PREFIX}T_DIM_REAL_ESTATE (RESOURCE_ITEM_SID, DWH_VALID_FROM_TMSP, DWH_VALID_TO_TMSP, DWH_VALID_FG, DIVISION_PARTY_SID, DIVISION_CD, DIVISION_NAME, COUNTRY_LOCATION_SID, COUNTRY_CD, COUNTRY_NAME, REAL_ESTATE_NR, ZIP, CITY, STREET, LATITUDE, LONGITUDE, DWH_CREATED_TMSP, DWH_UPDATED_TMSP, DWH_SRC_FILE_NAME, DWH_SRC_1_TMSP)
SELECT RESOURCE_ITEM_SID,
       DWH_VALID_FROM_TMSP,
       DWH_VALID_TO_TMSP,
       CURRENT_TIMESTAMP BETWEEN DWH_VALID_FROM_TMSP AND DWH_VALID_TO_TMSP AS DWH_VALID_FG,
       DIVISION_PARTY_SID,
       DIVISION_CD,
       DIVISION_NAME,
       COUNTRY_LOCATION_SID,
       ISO_COUNTRY_CD,
       COUNTRY_NAME,
       REAL_ESTATE_NR,
       ZIP,
       CITY_NAME,
       STREET,
       LATITUDE,
       LONGITUDE,
       DWH_CREATED_TMSP,
       DWH_UPDATED_TMSP,
       DWH_SRC_FILE_NAME AS DWH_SRC_FILE_NAME,
       DWH_SRC_1_TMSP
  FROM(SELECT RESOURCE_ITEM_SID,
              DWH_VALID_FROM_TMSP,
              DATEADD(MILLISECOND, -1, LEAD(DWH_VALID_FROM_TMSP, 1, '9999-12-31 23:59:59.999') OVER (PARTITION BY RESOURCE_ITEM_SID ORDER BY DWH_VALID_FROM_TMSP)) AS DWH_VALID_TO_TMSP,
              DIVISION_PARTY_SID,
              DIVISION_CD,
              DIVISION_NAME,
              COUNTRY_LOCATION_SID,
              ISO_COUNTRY_CD,
              COUNTRY_NAME,
              REAL_ESTATE_NR,
              ZIP,
              CITY_NAME,
              STREET,
              LATITUDE,
              LONGITUDE,
			  DWH_CREATED_TMSP,
			  DWH_UPDATED_TMSP,
			  DWH_SRC_FILE_NAME,
			  DWH_SRC_1_TMSP
         FROM(SELECT RESOURCE_ITEM_SID,
                     DWH_VALID_FROM_TMSP,
                     DIVISION_PARTY_SID,
                     DIVISION_CD,
                     DIVISION_NAME,
                     COUNTRY_LOCATION_SID,
                     ISO_COUNTRY_CD,
                     COUNTRY_NAME,
                     REAL_ESTATE_NR,
                     ZIP,
                     CITY_NAME,
                     STREET,
                     LATITUDE,
                     LONGITUDE,
					 DWH_CREATED_TMSP,
					 DWH_UPDATED_TMSP,
					 DWH_SRC_FILE_NAME,
					 DWH_SRC_1_TMSP,
                     LAG(HASH_NR, 1, '#') OVER (PARTITION BY RESOURCE_ITEM_SID ORDER BY DWH_VALID_FROM_TMSP) != HASH_NR AS CHANGE_FG
                FROM(SELECT RE.RESOURCE_ITEM_SID,
                            RE.DWH_VALID_FROM_TMSP,
                            RE.DIVISION_PARTY_SID,
                            DV.DIVISION_CD,
                            DV.DIVISION_NAME,
                            RE.COUNTRY_LOCATION_SID,
                            COALESCE(CO.ISO_COUNTRY_CD, '-1') AS ISO_COUNTRY_CD,
                            COALESCE(CO.COUNTRY_NAME, 'Unbekannt') AS COUNTRY_NAME,
                            RE.REAL_ESTATE_NR,
                            DECODE(PC.ZIP, '-1', 'UNBEKANNT', PC.ZIP) AS ZIP,
                            CT.CITY_NAME,
                            TRIM(SA.STREET_NAME || ' ' || COALESCE(SA.HOUSE_NR, '')) AS STREET,
                            SA.LATITUDE,
                            SA.LONGITUDE,
                            MD5(COALESCE(RE.DIVISION_PARTY_SID, -1) || '^'
                                || COALESCE(DV.DIVISION_CD, '-1') || '^'
                                || COALESCE(DV.DIVISION_NAME, '-1') || '^'
                                || COALESCE(RE.COUNTRY_LOCATION_SID, -1) || '^'
                                || COALESCE(CO.ISO_COUNTRY_CD, '-1') || '^'
                                || COALESCE(CO.COUNTRY_NAME, '#') || '^'
                                || COALESCE(RE.REAL_ESTATE_NR, '#') || '^'
                                || COALESCE(PC.ZIP, '#') || '^'
                                || COALESCE(CT.CITY_NAME, '#') || '^'
                                || COALESCE(SA.STREET_NAME, '#') || '^'
                                || COALESCE(SA.HOUSE_NR, '#') || '^'
                                || COALESCE(SA.LATITUDE, -1) || '^'
                                || COALESCE(SA.LONGITUDE, -1)) AS HASH_NR,
								RE.DWH_CREATED_TMSP,
								RE.DWH_UPDATED_TMSP,
								RE.DWH_SRC_FILE_NAME,
								RE.DWH_SRC_1_TMSP
                       FROM CORE_REL.T_REAL_ESTATE RE
                       JOIN CORE_REL.T_DIVISION DV
                         ON RE.DIVISION_PARTY_SID = DV.PARTY_SID
                       LEFT   
                       JOIN CORE_REL.T_COUNTRY_POLITICAL CO
                         ON RE.COUNTRY_LOCATION_SID = CO.LOCATION_SID
                        AND CO.LANG_CD = 'DE'
                        AND CO.DWH_VALID_FG
                       JOIN CORE_REL.T_STREET_ADDRESS SA
                         ON RE.STREET_ADDRESS_LOCATION_SID = SA.LOCATION_SID
                         AND SA.DWH_VALID_FG
                       JOIN CORE_REL.T_POSTAL_CODE_AREA PC
                         ON SA.POSTAL_CODE_AREA_LOCATION_SID = PC.LOCATION_SID
                        AND PC.DWH_VALID_FG
                       JOIN CORE_REL.T_CITY CT
                         ON SA.CITY_LOCATION_SID = CT.LOCATION_SID
                         AND CT.DWH_VALID_FG
                    )
             )
        WHERE CHANGE_FG = TRUE
      )
;

COMMIT;
