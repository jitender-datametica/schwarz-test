CREATE OR REPLACE VIEW FE_SHS.V_refdata_Bestandskunden_Datumsformat2_1 AS (

	WITH DFKKOP_HOECHSTE_AKTUELLSTE_MAHNSTUFE AS (
		SELECT 
			CONCAT(GPART, SAP_CLIENT_ID, OPBEL, OPUPW, OPUPK, OPUPZ) AS GeschPartner_Belegnummer_Mandant,
		    CONCAT(GPART, SAP_CLIENT_ID) AS GeschPartner_Mandant,
		    BLART AS Belegart_BLART,
		    AUGST AS Ausgleichsstatus_AUGST,
		    FKKMAZE.Mahnstufe_MAHNS
		FROM 
            ETL.T_DFKKOP_1 AS DFKKOP

		INNER JOIN 
		(
			SELECT 
				CONCAT(GPART, SAP_CLIENT_ID, OPBEL, OPUPW, OPUPK, OPUPZ) AS GeschPartner_Belegnummer_Mandant,
			    MAX(MAHNS) AS Mahnstufe_MAHNS
			FROM 
				ETL.T_FKKMAZE_1
			WHERE 	
				LAUFD >= CURRENT_DATE() - 365
			GROUP BY 	
				CONCAT(GPART, SAP_CLIENT_ID, OPBEL, OPUPW, OPUPK, OPUPZ) 
		) AS FKKMAZE

		ON 
			CONCAT(GPART, SAP_CLIENT_ID, OPBEL, OPUPW, OPUPK, OPUPZ) = FKKMAZE.GeschPartner_Belegnummer_Mandant
		WHERE 
			BLDAT >= CURRENT_DATE() - 365
            AND AUGST <> '9'     -- only orders are taken into consideration which are not payed/cleared yet
		ORDER BY 
			GeschPartner_Mandant
	),
  

	Mahnpositionen AS (
		SELECT
			GeschPartner_Mandant,
		    MAX(Mahnstufe_MAHNS) AS aktuell_hoechste_Mahnstufe
		FROM 
			DFKKOP_HOECHSTE_AKTUELLSTE_MAHNSTUFE
		WHERE 
			Mahnstufe_MAHNS > 0
			AND Mahnstufe_MAHNS <> 0
			AND Mahnstufe_MAHNS IS NOT NULL 
		GROUP BY 
			GeschPartner_Mandant
	),
  
 	Kundenauftragspositionen_tmp AS (
 	SELECT 	 
		TO_VARCHAR(CONCAT(VBAK.VBELN, VBAK.SAP_CLIENT_ID)) AS Verkaufsbeleg_Mandant,  
		VBAK.AUDAT AS Kaufdatum_hist,
		TO_VARCHAR(CONCAT(VBAK.KUNNR, VBAP.SAP_CLIENT_ID)) AS GPID_Mandant,
		VBAP.MATNR AS Artikel_1,
		VBAP.KZWI1 AS Brutto_Artikelverkaufswert_KZWI1,
		VBAP.KZWI2 AS Brutto_Versandkostenpauschale_KZWI2,
		VBAP.KZWI3 AS Brutto_Art_spez_Versandkosten_KZWI3,
        TO_VARCHAR(LEFT(MVKE.PRODH, 2)) AS SHOPCAT_Ebene1,
		TVKBT.BEZEI AS Verkaufskanal_hist,
		VBKD.ZTERM AS Zahlweg_hist,
		CASE WHEN VBAK.AUGRU IS NULL OR VBAK.AUGRU = ''
		 	  THEN 0 
		 	  ELSE 1 END AS Flag_Storno,
		BUT0.ADDRCOMM AS billing_address_sid,
		BUT1.ADDRCOMM AS delivery_address_sid,
		CASE WHEN BUT0.ADDRCOMM != BUT1.ADDRCOMM 
			  THEN 1 
			  ELSE 0 END AS fl_abweichende_lieferadresse_hist
		FROM     
			ETL.T_VBAK_1 AS VBAK
  
		LEFT JOIN ETL.T_VBAP_1 AS VBAP
			ON TO_VARCHAR(CONCAT(VBAK.VBELN, VBAK.SAP_CLIENT_ID)) = TO_VARCHAR(CONCAT(VBAP.VBELN, VBAP.SAP_CLIENT_ID))
     
        LEFT JOIN ETL.T_MVKE_1 AS MVKE_1
            ON TO_VARCHAR(CONCAT(VBAP.MATNR, VBAK.VKORG)) = TO_VARCHAR(CONCAT(MVKE.MATNR, MVKE.VKORG))

		LEFT JOIN 
		(
			SELECT 
				COLUMN1 AS VKBUR,
			    COLUMN2 AS BEZEI  
			FROM 
			  (VALUES ('0001', 'Sales_1 Office South'),
					  ('1000', 'Web'),
					  ('2000', 'Android'),
					  ('3000', 'iOS'),
					  ('4000', 'CSA')) 
		) AS TVKBT
			ON VBAK.VKBUR = TVKBT.VKBUR

		LEFT JOIN ETL.T_VBKD_1 AS VBKD
			ON TO_VARCHAR(CONCAT(VBAK.VBELN, VBAK.SAP_CLIENT_ID, TO_VARCHAR(VBAP.POSNR))) 
			 = TO_VARCHAR(CONCAT(VBKD.VBELN, VBKD.SAP_CLIENT_ID, TO_VARCHAR(VBKD.POSNR)))

		LEFT JOIN ETL.T_BUT000_1 AS BUT0
			ON VBAK.KUNNR = BUT0.PARTNER

		LEFT JOIN 
		(
			SELECT 
				VBELN,
			    KUNNR, 
                POSNR
			FROM 
				ETL.T_VBPA_1
			WHERE 
				PARVW = 'WE' 	
		) AS VBPA
			ON TO_VARCHAR(CONCAT(VBAK.VBELN, VBAP.POSNR)) = TO_VARCHAR(CONCAT(VBPA.VBELN, VBPA.POSNR))  

		LEFT JOIN ETL.T_BUT000_1 AS BUT1
			ON VBPA.KUNNR  = BUT1.PARTNER

		WHERE 
			VBAK.AUDAT > CURRENT_DATE() - 365
            AND VBAK.VBTYP = 'C' 
	),
  
	Kundenhistorie AS (	
		SELECT 
			GPID_Mandant AS Debitor_ORG_Mandant,
		    SUM(DISTINCT Verkaufsbeleg_Mandant) AS anzahl_bestellungen_hist,
		    SUM(Brutto_Artikelverkaufswert_KZWI1 + Brutto_Versandkostenpauschale_KZWI2 + Brutto_Art_spez_Versandkosten_KZWI3) AS sum_Warenkorb_Wert_hist,
		    MAX(CASE WHEN Flag_Storno = 1 AND Brutto_Artikelverkaufswert_KZWI1 + Brutto_Versandkostenpauschale_KZWI2 + Brutto_Art_spez_Versandkosten_KZWI3 IS NOT NULL THEN 1 ELSE 0 END) AS fl_Stornoauftrag_hist,
		    MAX(CASE WHEN Zahlweg_hist = 'X' AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END) AS fl_zahlweg_raten_hist,
		    MAX(CASE WHEN Zahlweg_hist IN ('B', 'R') AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END) AS fl_zahlweg_rechnung_hist,
		    MAX(CASE WHEN Zahlweg_hist IN ('P', 'K', 'S', '', 'G', 'V') AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END) AS fl_zahlweg_sichere_za_hist,
            MAX(CASE WHEN SHOPCAT_Ebene1='55' AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END ) AS fl_Gesundheit_Warenkorb_hist, 	
		    MAX(CASE WHEN SHOPCAT_Ebene1='20' AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END ) AS fl_Haushalt_Warenkorb_hist,
		    MAX(CASE WHEN SHOPCAT_Ebene1='60' AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END ) AS fl_Hobby_Warenkorb_hist,	 
		    MAX(CASE WHEN SHOPCAT_Ebene1='36' AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END ) AS fl_Kinderwelt_Warenkorb_hist,	  	 
		    MAX(CASE WHEN SHOPCAT_Ebene1='46' AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END ) AS fl_Mode_Warenkorb_hist, 	  	      
		    MAX(CASE WHEN SHOPCAT_Ebene1='17' AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END ) AS fl_Multimedia_Warenkorb_hist, 	  	       	 
		    MAX(CASE WHEN SHOPCAT_Ebene1='27' AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END ) AS fl_Sport_Warenkorb_hist, 	 
		    MAX(CASE WHEN SHOPCAT_Ebene1='50' AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END ) AS fl_Weinwelt_Warenkorb_hist,	 	 
		    MAX(CASE WHEN SHOPCAT_Ebene1='41' AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END ) AS fl_Baumarkt_Warenkorb_hist, 	 	     
		    MAX(CASE WHEN SHOPCAT_Ebene1='31' AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END ) AS fl_Wohnen_Warenkorb_hist, 	 	           
		    MAX(CASE WHEN Verkaufskanal_hist = 'Web' AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END ) AS fl_kanal_web_hist, 	 	           
		    MAX(CASE WHEN Verkaufskanal_hist = 'CIC' AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END ) AS fl_kanal_CIC_hist,
		    MAX(CASE WHEN Verkaufskanal_hist = 'iPhone' AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END ) AS fl_kanal_iphone_hist,   
		    MAX(CASE WHEN Verkaufskanal_hist = 'Android' AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END ) AS fl_kanal_Android_hist,
		    MAX(CASE WHEN fl_abweichende_lieferadresse_hist = 1 AND Brutto_Artikelverkaufswert_KZWI1 > 0 THEN 1 ELSE 0 END ) AS fl_abweichende_lieferadresse_hist,
		    MAX(Kaufdatum_hist) AS letztkaufdatum
		FROM 
			Kundenauftragspositionen_tmp
		GROUP BY 
			GPID_Mandant
	),
	
 	R_SHS_Basis_Kennahlen AS (
		SELECT 
			CONCAT(GPART, DFKKOP.SAP_CLIENT_ID) AS GeschPartner_Mandant, 
		    CONCAT(DFKKOP.XBLNR, DFKKOP.SAP_CLIENT_ID) AS Verkaufsbeleg_Mandant,
		    BLART AS Text_BLART,
		    BLDAT AS Belegdatum_BLDAT,
		    CONCAT(OPBEL, DFKKOP.SAP_CLIENT_ID) AS CAX_Belegnummer_Mandant,
		    OPBEL AS Belegnummer_OPBEL,
		    AUGST AS Ausgleichsstatus_AUGST,
		    BETRH AS Hausw_BETRH,
		    PYMET AS Zahlweg_PYMET,
		    CONSTANT_I_TWO.ZLOW AS Zahlart_ZZSECPAYMENT,
		    CASE WHEN AUGST = '9' 
				  THEN 1 
				  ELSE 0 END AS Flag_Auftrag_Bezahlt
		FROM 
			ETL.T_DFKKOP_1 AS DFKKOP
	 
		-- The following INNER JOIN is needed to exclude the LIDL PLUS payments from the grocery stores that are part of our rji sap 	
		-- VBAK doesn't have LIDL PLUS payments, hence the inner join excludes them
		INNER JOIN ETL.T_VBAK_1 AS VBAK
   			ON REPLACE(LTRIM(REPLACE(DFKKOP.XBLNR, '0', ' ' ) ), ' ', '0') = VBAK.VBELN
            AND DFKKOP.SAP_CLIENT_ID = VBAK.SAP_CLIENT_ID
			
		LEFT JOIN
		(
			SELECT 
				FIELDNAME, 
			    ZLOW
			FROM 
				ETL.T_constant_i_1
			WHERE 
				CONKEY = 410
				AND NOT STARTSWITH(FIELDNAME, 'SEC_')
                AND NOT STARTSWITH(FIELDNAME, 'REF_')
		) AS CONSTANT_I
			ON 
				DFKKOP.PYMET = CONSTANT_I.ZLOW
	 
		LEFT JOIN
		(
			SELECT 
				LTRIM(FIELDNAME, 'SEC_') AS FIELDNAME,
			    ZLOW
			FROM 
				ETL.T_constant_i_1
			WHERE 
				CONKEY = 410
				AND STARTSWITH(FIELDNAME, 'SEC_' )
		) AS CONSTANT_I_TWO
			ON 
				CONSTANT_I.FIELDNAME = CONSTANT_I_TWO.FIELDNAME  
	  
		WHERE 
			DFKKOP.BLDAT > CURRENT_DATE() - 365
			AND DFKKOP.BLART IN ('RE_1', 'RP', 'RL')   
			AND Verkaufsbeleg_Mandant IS NOT NULL      
			AND GeschPartner_Mandant IS NOT NULL       
			AND CAX_Belegnummer_Mandant IS NOT NULL    
		ORDER BY GeschPartner_Mandant DESC
	),
	
	R_SHS_Kennzahlen_Faktura_final AS (  
		SELECT 
			GeschPartner_Mandant,
		    COUNT(DISTINCT CASE WHEN Zahlart_ZZSECPAYMENT = 'X' THEN Verkaufsbeleg_Mandant ELSE NULL END) AS GP_Anzahl_Best_SZA_12m,  
		    COUNT(DISTINCT CASE WHEN Zahlart_ZZSECPAYMENT = '' THEN Verkaufsbeleg_Mandant ELSE NULL END) AS GP_Anzahl_Best_NSZA_12m,  
		    SUM(CASE WHEN Zahlart_ZZSECPAYMENT = 'X' THEN Hausw_BETRH ELSE 0 END) AS GP_Volumen_Best_SZA_12m,
		    SUM(CASE WHEN Zahlart_ZZSECPAYMENT = '' THEN Hausw_BETRH ELSE 0 END) AS GP_Volumen_Best_NSZA_12m           
		FROM 
			R_SHS_Basis_Kennahlen 
		WHERE 
			Flag_Auftrag_Bezahlt = 1
		GROUP BY
			GeschPartner_Mandant
	),
	
	R_SHS_Kennzahlen_OP_FK_final AS (  
		SELECT 
			GeschPartner_Mandant,
		    SUM(CASE WHEN Zahlart_ZZSECPAYMENT = 'X' THEN Hausw_BETRH ELSE 0 END) AS GP_OP_Fakturiert_SZA,    
		    SUM(CASE WHEN Zahlart_ZZSECPAYMENT = '' THEN Hausw_BETRH ELSE 0 END) AS GP_OP_Fakturiert
		FROM 
			R_SHS_Basis_Kennahlen 
		WHERE 
			Ausgleichsstatus_AUGST = '' 
		GROUP BY
			GeschPartner_Mandant
	),
 
   --not invoiced records retrieval
   VBAP_VBKD AS 
    (SELECT
        VBAP.VBELN
        ,VBKD.ZTERM
        ,SUM(VBAP.KZWI1 + VBAP.KZWI3 + VBAP.KZWI2 + VBAP.KZWI6) AS PRICE_ORIG
        ,SUM(NETWR + MWSBP) AS PRICE_REAL   
    FROM
        ETL.T_VBAP_1 VBAP
    LEFT JOIN
        ETL.T_VBKD_1 VBKD
    ON 
            VBAP.VBELN = VBKD.VBELN
        AND VBAP.POSNR = VBKD.POSNR
    GROUP BY VBAP.VBELN,
             VBKD.ZTERM
    )
,DFKKOP AS
(SELECT 
    XBLNR
    ,GPART
    ,BLART
    ,SUM(BETRH) AS BETRH
 FROM
    ETL.T_DFKKOP_1
WHERE BLART IN ('RE_1', 'RP', 'RL')
GROUP BY XBLNR, GPART, BLART
)
,R_SHS_Kennzahlen_OP_NFK_final AS (
    SELECT 
		CONCAT(VBAK.KUNNR, VBAK.SAP_CLIENT_ID) AS GeschPartner_Mandant,
        SUM(CASE WHEN CONST.Zahlart_ZZSECPAYMENT = 'X' THEN (VBAP_VBKD.PRICE_REAL - IFNULL(DFKKOP.BETRH,0)) ELSE 0 END) AS GP_OP_nichtfakturiert_SZA,    
        SUM(CASE WHEN CONST.Zahlart_ZZSECPAYMENT = '' THEN (VBAP_VBKD.PRICE_REAL - IFNULL(DFKKOP.BETRH,0)) ELSE 0 END) AS GP_OP_nichtfakturiert  
    FROM 
        VBAP_VBKD  
    
    LEFT JOIN 
        ( 
        SELECT 
                * 
        FROM 
                ETL.T_VBAK_1 
        WHERE 
                AUDAT > CURRENT_DATE()-365 
                AND VBTYP = 'C' 
            
        ) AS VBAK    
            ON VBAP_VBKD.VBELN = VBAK.VBELN

        LEFT JOIN DFKKOP 
            ON VBAK.VBELN = REPLACE(LTRIM(REPLACE(DFKKOP.XBLNR, '0', ' ' ) ), ' ', '0')

		LEFT JOIN 
		(
			SELECT 
				ZLOW AS Zahlart_ZZSECPAYMENT,
			    LTRIM(FIELDNAME, 'SEC_') AS FIELDNAME
			FROM 
				ETL.T_CONSTANT_I_1
			WHERE 
				CONKEY = 410
				AND STARTSWITH(FIELDNAME, 'SEC_')
		) AS CONST
			ON VBAP_VBKD.ZTERM = CONST.FIELDNAME	 
		
		GROUP BY GeschPartner_Mandant
)
,    
  
	R_SHS_Kennzahlen_RetourenQuote_SD AS (
		SELECT 
			CONCAT(VBAK.KUNNR, VBAP.SAP_CLIENT_ID) AS GeschPartner_Mandant,
		    SUM(VBAP.KZWI1) AS Retourenwert
		FROM 
			ETL.T_VBAK_1 AS VBAK

-- Is the following join correct or do we need sap client id?
		LEFT JOIN ETL.T_VBAP_1 AS VBAP
			ON VBAK.VBELN = VBAP.VBELN    
		
		WHERE 
            VBAK.AUDAT > CURRENT_DATE()-365
            AND VBAK.VBTYP = 'H' 
            
		GROUP BY     
			CONCAT(VBAK.KUNNR, VBAP.SAP_CLIENT_ID) 
	),
	
	R_SHS_Kennzahlen_RetourenQuote_CAX AS (
		SELECT 
			GeschPartner_Mandant,
		    SUM(Hausw_BETRH) AS Gesamtfakturawert
		FROM 
			R_SHS_Basis_Kennahlen
		WHERE
			Ausgleichsstatus_AUGST = '9' 
			AND Text_BLART = 'RE_1'
			AND Belegdatum_BLDAT > CURRENT_DATE()-365
		GROUP BY     
			GeschPartner_Mandant
	),
 
    T_DFKKOP_LASTSCHRIFT02 AS (
		SELECT 
			GeschPartner_Mandant,
		    DATE(MAX(BelegdatumLastschrift),'YYYY-MM_1-DD') AS BelegdatumLetzteLastschrift 
		FROM 
		(
			SELECT 
				DISTINCT 
				TO_VARCHAR(CONCAT(GPART, SAP_CLIENT_ID)) AS GeschPartner_Mandant,
			    BLDAT AS BelegdatumLastschrift
			FROM 
				ETL.T_DFKKOP_1
			WHERE 
				PYMET IN ('L', 'B')
		) AS LASTSCHRIFT
		GROUP BY 
			GeschPartner_Mandant
	),
  
    H_Hauptkundenliste AS (
		SELECT 
			TO_VARCHAR(CONCAT(KNA1.KUNNR, KNA1.SAP_CLIENT_ID)) AS Debitor_ORG_Mandant,
	        ANRED AS Salutation,
		    SPLIT_PART(KNA1.NAME1, ' ',  1) AS firstName, 
		    RIGHT(KNA1.NAME1, LEN(KNA1.NAME1) - CHARINDEX(' ', KNA1.NAME1)) AS lastName,
		    KNA1.KUNNR AS DEBITOR,
		    KNA1.KUNNR AS GESCHPARTNER,
		    REPLACE(ADRC.NAMECO, ';', ' ') AS companyName,
		    BUT000.BIRTHDT AS DateOfBirth,
		    ADR2.TELNUMBER AS Phone,
		    ADR6.SMTPADDR AS Email,
		    ADRC.STREET AS streetName,     
		    ADRC.HOUSENUM1 AS streetNumber,       
		    ADRC.STRSUPPL2 AS addressSuffix,
		    ADRC.POSTCODE1 AS zipCode, 
		    ADRC.CITY1 AS city,
		    ADRC.COUNTRY_1 AS country_1, 
			CASE WHEN CONCAT(KNA1.KUNNR, KNA1.SAP_CLIENT_ID) IN ('1067363151100', '1072574974100') 
				 THEN '1' ELSE (CASE WHEN KNA1.AUFSD != '' THEN '1' ELSE '' END) 
				 END AS Sperrmerkmal,
			CASE WHEN CONCAT(KNA1.KUNNR, KNA1.SAP_CLIENT_ID) = '1000940044100' 
				 THEN 0 ELSE FKKMAZE.Mahnstufe
			     END AS Mahnstufe,
			VBAK.Datum_erste_Bestellung AS Datum_erste_Bestellung,
			VBAK.Datum_letzte_Bestellung AS Datum_letzte_Bestellung
		FROM 
			ETL.T_KNA1_1 AS KNA1_1
  
	    -- Removed the AUDAT > CURRENT_DATE()-365 condition to take care of older orders	
        INNER JOIN 
		(
			SELECT 
				CONCAT(KUNNR, SAP_CLIENT_ID) AS Debitor_ORG_Mandant,
				DATE(MIN(AUDAT)) AS Datum_erste_Bestellung,
				DATE(MAX(AUDAT)) AS Datum_letzte_Bestellung
			FROM 
				ETL.T_VBAK_1
            WHERE 
                VBTYP = 'C'
			GROUP BY 
				CONCAT(KUNNR, SAP_CLIENT_ID)   
		) AS VBAK
			ON CONCAT(KNA1.KUNNR, KNA1.SAP_CLIENT_ID) = VBAK.Debitor_ORG_Mandant	
        
		LEFT JOIN ETL.T_BUT000_1 AS BUT000
			ON CONCAT(KNA1.KUNNR, KNA1.SAP_CLIENT_ID) = CONCAT(BUT000.PARTNER, BUT000.SAP_CLIENT_ID)

		LEFT JOIN (SELECT * 
                   FROM (SELECT ADDRNUMBER, SAP_CLIENT_ID, TELNUMBER, 
                          	ROW_NUMBER() OVER (PARTITION BY ADDRNUMBER ORDER BY CONSNUMBER DESC) AS ROWN
                         FROM ETL.T_ADR2_1 
                         WHERE (validfrom = '' OR validto = '') AND FLGDEFAULT = 'X' 
                        ) AS A WHERE ROWN = 1 
                   ) AS ADR2 
            ON CONCAT(BUT000.ADDRCOMM, BUT000.SAP_CLIENT_ID) = CONCAT(ADR2.ADDRNUMBER, ADR2.SAP_CLIENT_ID)
        
        LEFT JOIN (SELECT * 
                   FROM (SELECT ADDRNUMBER, SAP_CLIENT_ID, SMTPADDR, 
                          	ROW_NUMBER() OVER (PARTITION BY ADDRNUMBER ORDER BY CONSNUMBER DESC) AS ROWN
                         FROM ETL.T_ADR6_1
                         WHERE (validfrom = '' OR validto = '') AND FLGDEFAULT = 'X' 
                        ) AS A WHERE ROWN = 1 
                   ) AS ADR6_1
            ON CONCAT(BUT000.ADDRCOMM, BUT000.SAP_CLIENT_ID) = CONCAT(ADR6.ADDRNUMBER, ADR6.SAP_CLIENT_ID) 	

		LEFT JOIN ETL.T_ADRC_1 AS ADRC_1
			ON CONCAT(KNA1.ADRNR, KNA1.SAP_CLIENT_ID) = CONCAT(ADRC.ADDRNUMBER, ADRC.SAP_CLIENT_ID)	
	
		LEFT JOIN 
		(
			SELECT 
				CONCAT(FKKMAZE.GPART, FKKMAZE.SAP_CLIENT_ID) AS GeschPartner_Mandant,
				MAX(MAHNS) AS Mahnstufe
			FROM     
				ETL.T_FKKMAZE_1 AS FKKMAZE
			LEFT JOIN 
				ETL.T_DFKKOP_1 AS DFKKOP 
				ON CONCAT(DFKKOP.GPART, DFKKOP.SAP_CLIENT_ID, DFKKOP.OPBEL, DFKKOP.OPUPW, DFKKOP.OPUPK, DFKKOP.OPUPZ) = 
				   CONCAT(FKKMAZE.GPART, FKKMAZE.SAP_CLIENT_ID, FKKMAZE.OPBEL, FKKMAZE.OPUPW, FKKMAZE.OPUPK, FKKMAZE.OPUPZ) 
			WHERE MAHNS > 0
				AND MAHNS != 00
				AND MAHNS IS NOT NULL	
				AND DFKKOP.BLDAT >= CURRENT_DATE()-365
			GROUP BY
				GeschPartner_Mandant
		) AS FKKMAZE
			ON CONCAT(KNA1.KUNNR, KNA1.SAP_CLIENT_ID) = FKKMAZE.GeschPartner_Mandant

		WHERE 
            KNA1.KTOKD = 'ZBC0'   -- This is the condition "WHERE exists( Flag_Hauptkunde )"
            AND ADRC.COUNTRY_1 IN ('DE', 'NL')
	),
	
	Kundenliste_Full AS (
		SELECT
             LEFT(HAUPT.Debitor_ORG_Mandant, 10) AS Debitor_ORG_Mandant,
		     HAUPT.Salutation,
		     REPLACE(HAUPT.firstName, ';', ' ') AS firstName,
             REPLACE(HAUPT.lastName, ';', ' ') AS lastName,
		     HAUPT.companyName,
		     HAUPT.DateOfBirth,
		     HAUPT.Phone,
		     HAUPT.Email,
		     'N' AS Flag_Nur_Lieferadresse,
		     REPLACE(HAUPT.streetName, ';', ' ') AS streetName,   
		     HAUPT.streetNumber,       
		     HAUPT.addressSuffix,
		     REPLACE(HAUPT.zipCode, ';', ' ') AS zipCode,
             REPLACE(HAUPT.city, ';', ' ') AS city,
		     HAUPT.country_1, 
		     HAUPT.Sperrmerkmal,
		     HAUPT.Mahnstufe,
		     HAUPT.Datum_erste_Bestellung,
		     HAUPT.Datum_letzte_Bestellung,
		     FAKTURA.GP_Anzahl_Best_SZA_12m,
		     FAKTURA.GP_Anzahl_Best_NSZA_12m,
		     LASTSCHR.BelegdatumLetzteLastschrift,
             FAKTURA.GP_Volumen_Best_SZA_12m	AS GP_Volumen_Best_SZA_12m,
		     FAKTURA.GP_Volumen_Best_NSZA_12m	AS GP_Volumen_Best_NSZA_12m,
             CASE WHEN RETCAX.Gesamtfakturawert = 0 THEN 0 ELSE CEIL((RETSD.Retourenwert/RETCAX.Gesamtfakturawert)*100) END AS GP_Retouren_Quote_Prz_12m,     
		     OPFK.GP_OP_Fakturiert_SZA,
		     OPFK.GP_OP_Fakturiert,
		     OPNFK.GP_OP_nichtfakturiert_SZA,
		     OPNFK.GP_OP_nichtfakturiert,
             fl_Stornoauftrag_hist,
		     fl_zahlweg_raten_hist,
		     fl_zahlweg_rechnung_hist,
		     fl_zahlweg_sichere_za_hist,
		     fl_Gesundheit_Warenkorb_hist, 	 
		     fl_Haushalt_Warenkorb_hist,
		     fl_Hobby_Warenkorb_hist, 	 
		     fl_Kinderwelt_Warenkorb_hist, 	  	 
		     fl_Mode_Warenkorb_hist, 	  	      
		     fl_Multimedia_Warenkorb_hist, 	  	       	 
		     fl_Sport_Warenkorb_hist, 	 
		     fl_Weinwelt_Warenkorb_hist, 	 	 
		     fl_Baumarkt_Warenkorb_hist, 	 	     
		     fl_Wohnen_Warenkorb_hist,       
		     fl_kanal_web_hist, 	 	           
		     fl_kanal_CIC_hist,
		     fl_kanal_iphone_hist,   
		     fl_kanal_Android_hist,
      		 fl_abweichende_lieferadresse_hist,
      		 CASE WHEN MAHN.aktuell_hoechste_Mahnstufe > 0 THEN MAHN.aktuell_hoechste_Mahnstufe ELSE 0 END AS aktuell_hoechste_Mahnstufe,
             CASE WHEN HIST.letztkaufdatum > CURRENT_DATE() - 30 THEN 'selber_Monat'
                  WHEN HIST.letztkaufdatum > CURRENT_DATE() - 60 THEN 'letzter_Monat'
                  WHEN HIST.letztkaufdatum > CURRENT_DATE() - 120 THEN 'zwei_bis_drei_Monate'
                  WHEN HIST.letztkaufdatum > CURRENT_DATE() - 99999 THEN 'mehr_als_drei_Monate' 
                  ELSE 'Kein_Kauf' END AS kl_letztkauf  
		FROM 
			H_Hauptkundenliste AS HAUPT

		LEFT JOIN R_SHS_Kennzahlen_Faktura_final AS FAKTURA 
			ON HAUPT.Debitor_ORG_Mandant = FAKTURA.GeschPartner_Mandant

		LEFT JOIN T_DFKKOP_LASTSCHRIFT02 AS LASTSCHR
			ON HAUPT.Debitor_ORG_Mandant = LASTSCHR.GeschPartner_Mandant

		LEFT JOIN R_SHS_Kennzahlen_RetourenQuote_SD AS RETSD
			ON HAUPT.Debitor_ORG_Mandant = RETSD.GeschPartner_Mandant

		LEFT JOIN R_SHS_Kennzahlen_RetourenQuote_CAX AS RETCAX
			ON HAUPT.Debitor_ORG_Mandant = RETCAX.GeschPartner_Mandant
		
		LEFT JOIN R_SHS_Kennzahlen_OP_FK_final AS OPFK 
			ON HAUPT.Debitor_ORG_Mandant = OPFK.GeschPartner_Mandant	
			
		LEFT JOIN R_SHS_Kennzahlen_OP_NFK_final AS OPNFK
			ON HAUPT.Debitor_ORG_Mandant = OPNFK.GeschPartner_Mandant	
      
       LEFT JOIN Kundenhistorie AS HIST
			ON HAUPT.Debitor_ORG_Mandant = HIST.Debitor_ORG_Mandant
			
		LEFT JOIN Mahnpositionen AS MAHN
			ON HAUPT.Debitor_ORG_Mandant = MAHN.GeschPartner_Mandant  
	)  
    
	SELECT 
		*
	FROM 
		Kundenliste_Full
	WHERE
		(aktuell_hoechste_Mahnstufe > 0 
		OR Datum_letzte_Bestellung > CURRENT_DATE() - 365)
);