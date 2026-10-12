CREATE TABLE FE_SHS.T_refdata_NegativCheck_Datumsformat2 AS (

	WITH REFDATA AS (

		SELECT 
			CAST(COLL.Debitor AS INT) AS ID,
			SPLIT_PART(KNA.NAME1, ' ',  1) AS firstName,
			RIGHT(KNA.NAME1, LEN(KNA.NAME1) - CHARINDEX(' ', KNA.NAME1)) AS lastName,
			BUT.BIRTHDT AS DateOfBirth,
			ADRC.COUNTRY AS country,
			ADRC.POSTCODE1 AS zipCode,            
			ADRC.CITY1 AS city,           
			ADRC.STREET AS streetName,   
			ADRC.HOUSENUM1 AS streetNumber,      
			ADRC.STRSUPPL2 AS addressSuffix,
			'RA' AS Adresstyp
		FROM 
		(
			SELECT DISTINCT
				GPART AS Debitor  
			FROM 
				ETL.T_DFKKCOLL
			WHERE
				GPART != '1000940044'
				AND AGDAT > CURRENT_DATE()-365

			UNION ALL

			SELECT 
				* 
			FROM 
				(
					VALUES 
						('1040004469'),
						('1040002536'),
						('1040001484'),
						('1040004769'),
						('1040005216'),
						('1040002552'),
						('1040001801'),
						('1040003136'),
						('1040004260'),
						('1040003262'),
						('1040003000'),
						('1040004766'),
						('1040005019'),
						('1040003203'),
						('1040004248'),
						('1040001980'),
						('1040003594'),
						('1040002388'),
						('1040004528'),
						('1040004595'),
						('1040003208')
				) T1 (Debitor)
		) AS COLL

		LEFT JOIN ETL.T_KNA1 AS KNA
			ON coll.Debitor = KNA.KUNNR 

		LEFT JOIN ETL.T_BUT000 AS BUT
			ON KNA.KUNNR = BUT.PARTNER

		LEFT JOIN ETL.T_ADRC AS ADRC
			ON KNA.ADRNR = ADRC.ADDRNUMBER
      
        WHERE ADRC.COUNTRY = 'DE'
	)

    SELECT * FROM REFDATA
);