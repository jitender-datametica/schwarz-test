create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_LEERGUT_WUP_TAG(
	MANDANT_ID,
	WUP_ID,
	DAT,
	WRG_ID,
	MENGE_AUTOMAT_EW,
	BETRAG_BRUTTO_AUTOMAT_EW,
	MENGE_AUTOMAT_MW,
	BETRAG_BRUTTO_AUTOMAT_MW,
	MENGE_INFO_EW,
	BETRAG_BRUTTO_INFO_EW,
	MENGE_INFO_MW,
	BETRAG_BRUTTO_INFO_MW,
	MENGE_WE_VZ,
	BETRAG_BRUTTO_WE_VZ,
	MENGE_DEZ_WE,
	BETRAG_BRUTTO_DEZ_WE,
	MENGE_DEZ_WE_KORR,
	BETRAG_BRUTTO_DEZ_WE_KORR,
	MENGE_DEZ_WE_STORNO,
	BETRAG_BRUTTO_DEZ_WE_STORNO,
	MENGE_DEZ_WE_UML,
	BETRAG_BRUTTO_DEZ_WE_UML,
	MENGE_ABHOLUNG_VZ,
	BETRAG_BRUTTO_ABHOLUNG_VZ,
	MENGE_UMBUCHUNG_ABGANG,
	BETRAG_BRUTTO_UMBUCHUNG_ABGANG,
	MENGE_ABHOLUNG_LIEF,
	BETRAG_BRUTTO_ABHOLUNG_LIEF,
	MENGE_ABHOLUNG_LIEF_KORR,
	BETRAG_BRUTTO_ABHOLUNG_LIEF_KORR,
	MENGE_ABHOLUNG_LIEF_STORNO,
	BETRAG_BRUTTO_ABHOLUNG_LIEF_STORNO,
	MENGE_ABSCHSCHRIFT_FREMD,
	BETRAG_BRUTTO_ABSCHRIFT_FREMD,
	MENGE_ABSCHRIFT_BRUCH,
	BETRAG_BRUTTO_ABSCHRIFT_BRUCH,
	MENGE_ABSCHRIFT_ENTSORGUNGMOD,
	BETRAG_BRUTTO_ABSCHRIFT_ENTSORGUNGMOD,
	MENGE_ZUFUEHRUNG_INFO,
	BETRAG_BRUTTO_ZUFUEHRUNG_INFO,
	MENGE_EINLOESE_KASSE,
	BETRAG_BRUTTO_EINLOESE_KASSE,
	MENGE_EINWEG_ABRECHNUNG,
	BETRAG_BRUTTO_EINWEG_ABRECHNUNG,
	BETRAG_BRUTTO_ZUGANG,
	BETRAG_BRUTTO_ABGANG,
	BETRAG_BRUTTO_VERAENDERUNG,
	BETRAG_INVENTUR,
	GRP_INVENTUR,
	KOMBI_INV,
	BETRAG_INVENTUR_AUF,
	BETRAG_ZAEHLUNG,
	GRP_INVZAEHL,
	KOMBI_INVZAEHL,
	BETRAG_INVZAEHL_AUF
) as  






WITH
zeit AS (
    SELECT dat
    FROM DBP_MSI_VIEW_VIS.MV_TAG
    WHERE akt_gj BETWEEN -1 AND 0
)
, wup AS (
    SELECT mandant_id, wup_id, aktuell_wup_id
    FROM DBP_DATA.WUP wup
)
, krs AS (
    SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
    FROM dbp_data.kurs krs1 
    WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
    AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
    UNION ALL 
    SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
    FROM dbp_data.kurs krs2 
    WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
    AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
)
, vis AS (
    SELECT DISTINCT v.mandant_id, wup.aktuell_wup_id AS wup_id, v.dat, v.wrg_id
    FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_FAKT_WUP v
    JOIN zeit t
    ON v.dat = t.dat
    JOIN wup wup
    ON v.mandant_id = wup.mandant_id AND v.wup_id = wup.wup_id
    WHERE v.mandant_id = 1
)

, an AS (
    SELECT
        COALESCE(pfand.mandant_id, info.mandant_id)                                                                                             AS mandant_id
        , COALESCE(pfand.wup_id, info.wup_id)                                                                                                   AS wup_id
        , COALESCE(pfand.dat, info.dat)                                                                                                         AS dat
        , COALESCE(pfand.wrg_id, info.wrg_id)                                                                                                   AS wrg_id
        
        , COALESCE(pfand.MENGE_AUTOMAT_EW, 0)                                                                                                   AS MENGE_AUTOMAT_EW
        , COALESCE(pfand.BETRAG_BRUTTO_AUTOMAT_EW, 0)                                                                                           AS BETRAG_BRUTTO_AUTOMAT_EW
        , COALESCE(pfand.MENGE_AUTOMAT_MW, 0)                                                                                                   AS MENGE_AUTOMAT_MW
        , COALESCE(pfand.BETRAG_BRUTTO_AUTOMAT_MW, 0)                                                                                           AS BETRAG_BRUTTO_AUTOMAT_MW
        
        , COALESCE(info.MENGE_INFO_EW, 0)                                                                                                       AS MENGE_INFO_EW
        , COALESCE(info.BETRAG_BRUTTO_INFO_EW, 0)                                                                                               AS BETRAG_BRUTTO_INFO_EW
        , COALESCE(info.MENGE_INFO_MW, 0)                                                                                                       AS MENGE_INFO_MW
        , COALESCE(info.BETRAG_BRUTTO_INFO_MW, 0)                                                                                               AS BETRAG_BRUTTO_INFO_MW
    
    FROM
        (
        
            SELECT 
               ek.MANDANT_ID
               , wup.aktuell_wup_id 				                                                                                            AS WUP_ID 
               , ek.BON_DAT                                                                                                                     AS DAT
               , krs.nach_wrg_id                                                                                                                AS WRG_ID
            
               , SUM(CASE WHEN plu_gruppe IN ('0000000000200', '0000000000400') THEN ep.MENGE ELSE 0 END)                                       AS MENGE_AUTOMAT_EW
               , SUM(CASE WHEN plu_gruppe IN ('0000000000200', '0000000000400') THEN ep.BON_ZEILEN_WERT * krs.umrechnungskurs ELSE 0 END)       AS BETRAG_BRUTTO_AUTOMAT_EW
            
               , SUM(CASE WHEN plu_gruppe IN ('0000000000100', '0000000000300') THEN ep.MENGE ELSE 0 END)                                       AS MENGE_AUTOMAT_MW
               , SUM(CASE WHEN plu_gruppe IN ('0000000000100', '0000000000300') THEN ep.BON_ZEILEN_WERT * krs.umrechnungskurs ELSE 0 END)       AS BETRAG_BRUTTO_AUTOMAT_MW
            
            FROM DBP_V_ODS.V_ELS_LEERGUT_KOPF ek
            
            JOIN DBP_V_ODS.V_ELS_LEERGUT_POSITION ep
            ON ek.MANDANT_ID = ep.MANDANT_ID 
             AND ek.BARCODE_LEERGUT = ep.BARCODE_LEERGUT
            
            JOIN krs krs
            ON krs.von_wrg_id = ek.WRG_ID
    
            JOIN zeit t
            ON ek.bon_dat = t.dat
        
            JOIN wup wup
            ON ek.mandant_id = wup.mandant_id AND ek.wup_id = wup.wup_id
            
            WHERE 
                ek.mandant_id = 1
                AND plu_gruppe IN ('0000000000100', '0000000000300', '0000000000200', '0000000000400')
    
            GROUP BY ALL
            
        ) pfand FULL OUTER JOIN
        (
            
            SELECT 
                 leer.MANDANT_ID
               , wup.aktuell_wup_id 				                                                                                                                                AS WUP_ID 
               , leer.BON_DAT                                                                                                                                                       AS DAT
               , krs.nach_wrg_id                                                                                                                                                    AS WRG_ID
            
               , SUM(CASE WHEN ((leer.ean_kasse IS NOT NULL) AND ((leer.umsatz_brutto / NULLIFZERO(leer.menge)) = -0.25)) THEN leer.menge ELSE 0 END)                                                        AS MENGE_INFO_EW
               , SUM(CASE WHEN ((leer.ean_kasse IS NOT NULL) AND ((leer.umsatz_brutto / NULLIFZERO(leer.menge)) = -0.25)) THEN leer.umsatz_brutto * krs.umrechnungskurs * -1 ELSE 0 END)                     AS BETRAG_BRUTTO_INFO_EW
               
               , SUM(CASE WHEN ((leer.ean_kasse IS NULL) OR ((leer.umsatz_brutto / NULLIFZERO(leer.menge)) <> -0.25)) THEN leer.menge ELSE 0 END)                                     AS MENGE_INFO_MW
               , SUM(CASE WHEN ((leer.ean_kasse IS NULL) OR ((leer.umsatz_brutto / NULLIFZERO(leer.menge)) <> -0.25)) THEN leer.umsatz_brutto * krs.umrechnungskurs * -1 ELSE 0 END)  AS BETRAG_BRUTTO_INFO_MW
            
            FROM DBP_V_ODS.V_ODS_BON_kopf k
            
            INNER JOIN DBP_V_ODS.V_ODS_BON_LEERGUT leer
            ON k.BON_ID = leer.BON_ID 
                AND k.MANDANT_ID = leer.MANDANT_ID 
                AND k.BON_DAT = leer.BON_DAT 
                AND k.WUP_ID = leer.WUP_ID 
            
            JOIN krs krs
            ON krs.von_wrg_id = k.WRG_ID
    
            JOIN zeit t
            ON leer.bon_dat = t.dat
        
            JOIN wup wup
            ON leer.mandant_id = wup.mandant_id AND leer.wup_id = wup.wup_id
            
            WHERE 
                k.mandant_id = 1
            
            GROUP BY ALL
        ) info
        ON pfand.mandant_id = info.mandant_id AND pfand.wup_id = info.wup_id AND pfand.dat = info.dat AND pfand.wrg_id = info.wrg_id
)

, wf AS (
    SELECT 
        t1.mandant_id
        , wup.aktuell_wup_id 				                                                                                                                                                        AS WUP_ID 
        , t1.dat_buch                                                                                                                                                                               AS DAT
        , krs.nach_wrg_id                                                                                                                                                                           AS WRG_ID
    
        
        , SUM(CASE WHEN wg_id IN (980,985) AND wug_id = 500 AND t1.lager_bewart_id IN ('305','306','901') AND t1.auto_fg NOT IN ('L') THEN MENGE_LAGERBEW_BME ELSE 0 END)                           AS MENGE_WE_VZ
        , SUM(CASE WHEN wg_id IN (980,985) AND wug_id = 500 AND t1.lager_bewart_id IN ('305','306','901') AND t1.auto_fg NOT IN ('L') THEN BETRAG_VERKAUF * krs.umrechnungskurs ELSE 0 END)         AS BETRAG_BRUTTO_WE_VZ
    
        
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (300,400)) OR t1.ART_ID = 980001200) AND t1.lager_bewart_id IN ('901','905') AND t1.auto_fg NOT IN ('L') 
                THEN MENGE_LAGERBEW_BME ELSE 0 END)                                                                                                                                                 AS MENGE_DEZ_WE
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (300,400)) OR t1.ART_ID = 980001200) AND t1.lager_bewart_id IN ('901','905') AND t1.auto_fg NOT IN ('L') 
                THEN BETRAG_VERKAUF * krs.umrechnungskurs ELSE 0 END)                                                                                                                               AS BETRAG_BRUTTO_DEZ_WE
        
        
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (300,400)) OR t1.ART_ID = 980001200) AND t1.auto_fg NOT IN ('L') AND
                (
                        (t1.lager_bewart_id IN ('915') AND ref_beleg_id IS NULL) OR
                        (t1.lager_bewart_id IN ('915','916') AND ref_beleg_id IS NOT NULL AND t4.lager_bewart_id IN ('901','905'))
                )                    
                THEN MENGE_LAGERBEW_BME ELSE 0 END)                                                                                                                                                 AS MENGE_DEZ_WE_KORR
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (300,400)) OR t1.ART_ID = 980001200) AND t1.auto_fg NOT IN ('L') AND
                (
                        (t1.lager_bewart_id IN ('915') AND ref_beleg_id IS NULL) OR
                        (t1.lager_bewart_id IN ('915','916') AND ref_beleg_id IS NOT NULL AND t4.lager_bewart_id IN ('901','905'))
                )
                THEN BETRAG_VERKAUF * krs.umrechnungskurs ELSE 0 END)                                                                                                                               AS BETRAG_BRUTTO_DEZ_WE_KORR
                                                                                                                                          
        
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (300,400)) OR t1.ART_ID = 980001200) AND t1.lager_bewart_id IN ('902', '906') AND t1.auto_fg NOT IN ('L') 
                THEN MENGE_LAGERBEW_BME ELSE 0 END)                                                                                                                                                 AS MENGE_DEZ_WE_STORNO
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (300,400)) OR t1.ART_ID = 980001200) AND t1.lager_bewart_id IN ('902', '906') AND t1.auto_fg NOT IN ('L') 
                THEN BETRAG_VERKAUF * krs.umrechnungskurs ELSE 0 END)                                                                                                                               AS BETRAG_BRUTTO_DEZ_WE_STORNO
        
        
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (300,400)) OR t1.ART_ID = 980001200) AND t1.lager_bewart_id IN ('305','306') AND t1.auto_fg NOT IN ('L','X') 
                THEN MENGE_LAGERBEW_BME ELSE 0 END)                                                                                                                                                 AS MENGE_DEZ_WE_UML
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (300,400) )OR t1.ART_ID = 980001200) AND t1.lager_bewart_id IN ('305','306') AND t1.auto_fg NOT IN ('L','X') 
                THEN BETRAG_VERKAUF * krs.umrechnungskurs ELSE 0 END)                                                                                                                               AS BETRAG_BRUTTO_DEZ_WE_UML
        
        
        , SUM(CASE WHEN wg_id IN (980,985) AND wug_id IN (500) AND t1.lager_bewart_id IN ('301') AND t1.auto_fg NOT IN ('L') AND t1.nb_id = 0
                THEN MENGE_LAGERBEW_BME ELSE 0 END)                                                                                                                                                 AS MENGE_ABHOLUNG_VZ
        , SUM(CASE WHEN wg_id IN (980,985) AND wug_id IN (500) AND t1.lager_bewart_id IN ('301') AND t1.auto_fg NOT IN ('L') AND t1.nb_id = 0
                THEN BETRAG_VERKAUF * krs.umrechnungskurs ELSE 0 END)                                                                                                                               AS BETRAG_BRUTTO_ABHOLUNG_VZ
        
        
        , SUM(CASE WHEN wg_id IN (980,985) AND wug_id IN (500) AND t1.lager_bewart_id IN ('303','304') AND t1.auto_fg NOT IN ('L', 'X') 
                THEN MENGE_LAGERBEW_BME ELSE 0 END)                                                                                                                                                 AS MENGE_UMBUCHUNG_ABGANG
        , SUM(CASE WHEN wg_id IN (980,985) AND wug_id IN (500) AND t1.lager_bewart_id IN ('303','304') AND t1.auto_fg NOT IN ('L', 'X')
                THEN BETRAG_VERKAUF * krs.umrechnungskurs ELSE 0 END)                                                                                                                               AS BETRAG_BRUTTO_UMBUCHUNG_ABGANG
        
        
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (000,100,300,400)) OR t1.ART_ID = 980001200) AND
                ( 
                	(t1.lager_bewart_id IN ('907','912') AND t1.auto_fg NOT IN ('L')) OR
                	(t1.lager_bewart_id IN ('303','304') AND t1.auto_fg NOT IN ('L','X'))
                ) 
                THEN MENGE_LAGERBEW_BME ELSE 0 END)                                                                                                                                                 AS MENGE_ABHOLUNG_LIEF
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (000,100,300,400)) OR t1.ART_ID = 980001200) AND
                ( 
                	(t1.lager_bewart_id IN ('907','912') AND t1.auto_fg NOT IN ('L')) OR
                	(t1.lager_bewart_id IN ('303','304') AND t1.auto_fg NOT IN ('L','X'))
                ) 
                THEN BETRAG_VERKAUF * krs.umrechnungskurs ELSE 0 END)                                                                                                                               AS BETRAG_BRUTTO_ABHOLUNG_LIEF
        
        
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (000,100,300,400)) OR t1.ART_ID = 980001200) AND t1.auto_fg NOT IN ('L') AND 
                    (
                        (t1.lager_bewart_id IN ('916') AND ref_beleg_id IS NULL) OR
                        (t1.lager_bewart_id IN ('915','916') AND ref_beleg_id IS NOT NULL AND t4.lager_bewart_id IN ('907','912'))
                    )
                THEN t1.BETRAG_VERKAUF * krs.umrechnungskurs ELSE 0 END)                                                                                                                            AS BETRAG_BRUTTO_ABHOLUNG_LIEF_KORR
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (000,100,300,400)) OR t1.ART_ID = 980001200) AND t1.auto_fg NOT IN ('L') AND 
                    (
                        (t1.lager_bewart_id IN ('915') AND ref_beleg_id IS NULL) OR
                        (t1.lager_bewart_id IN ('915','916') AND ref_beleg_id IS NOT NULL AND t4.lager_bewart_id IN ('907','912'))
                    )
                THEN t1.MENGE_LAGERBEW_BME ELSE 0 END)                                                                                                                                              AS MENGE_ABHOLUNG_LIEF_KORR

         
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (000,100,300,400)) OR t1.ART_ID = 980001200) AND t1.lager_bewart_id IN ('908') AND t1.auto_fg NOT IN ('L')  
                THEN t1.BETRAG_VERKAUF * krs.umrechnungskurs ELSE 0 END)                                                                                                                            AS BETRAG_BRUTTO_ABHOLUNG_LIEF_STORNO
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (000,100,300,400)) OR t1.ART_ID = 980001200) AND t1.lager_bewart_id IN ('908') AND t1.auto_fg NOT IN ('L') 
                THEN t1.MENGE_LAGERBEW_BME ELSE 0 END)                                                                                                                                              AS MENGE_ABHOLUNG_LIEF_STORNO
                
        
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (000,300,400)) OR t1.ART_ID = 980001200) AND t1.lager_bewart_id IN ('157','X65','Y65') AND t1.auto_fg NOT IN ('L') 
                THEN MENGE_LAGERBEW_BME ELSE 0 END)                                                                                                                                                 AS MENGE_ABSCHSCHRIFT_FREMD
        , SUM(CASE WHEN ((wg_id IN (980) AND wug_id IN (000,300,400)) OR t1.ART_ID = 980001200) AND t1.lager_bewart_id IN ('157','X65','Y65') AND t1.auto_fg NOT IN ('L')
                THEN BETRAG_VERKAUF * krs.umrechnungskurs ELSE 0 END)                                                                                                                               AS BETRAG_BRUTTO_ABSCHRIFT_FREMD
        
        
        , SUM(CASE WHEN wg_id IN (980) AND wug_id IN (000,300,400) AND
                    (
                            (t1.lager_bewart_id IN ('Y54') AND auto_fg NOT IN ('L')) 
                            OR 
                            (t1.lager_bewart_id IN ('X54') AND auto_fg IN (''))
                    )
                THEN MENGE_LAGERBEW_BME ELSE 0 END)                                                                                                                                                 AS MENGE_ABSCHRIFT_BRUCH
        , SUM(CASE WHEN wg_id IN (980) AND wug_id IN (000,300,400) AND
                    (
                            (t1.lager_bewart_id IN ('Y54') AND auto_fg NOT IN ('L')) 
                            OR 
                            (t1.lager_bewart_id IN ('X54') AND auto_fg IN (''))
                    )
                THEN BETRAG_VERKAUF * krs.umrechnungskurs ELSE 0 END)                                                                                                                               AS BETRAG_BRUTTO_ABSCHRIFT_BRUCH

        
        , SUM(CASE WHEN t1.ART_ID = 980101000 AND t1.lager_bewart_id IN ('Y65') AND t1.auto_fg NOT IN ('L') 
                THEN MENGE_LAGERBEW_BME ELSE 0 END)                                                                                                                                                 AS MENGE_ABSCHRIFT_ENTSORGUNGMOD
        , SUM(CASE WHEN t1.ART_ID = 980101000 AND t1.lager_bewart_id IN ('Y65') AND t1.auto_fg NOT IN ('L')
                THEN BETRAG_VERKAUF * krs.umrechnungskurs ELSE 0 END)                                                                                                                               AS BETRAG_BRUTTO_ABSCHRIFT_ENTSORGUNGMOD 
            
    FROM dbp_data.LAGERBEW_DET t1
    
    JOIN dbp_data.LAGERBEW t2
    ON t1.MANDANT_ID = t2.MANDANT_ID 
    AND t1.LAGERBEW_BELEG_ID = t2.LAGERBEW_BELEG_ID 
    AND t1.kj = t2.KJ 
    
    JOIN dbp_data.art_wg_zu_per t3
    ON t1.ART_ID = t3.ART_ID 
    AND t1.MANDANT_ID = t3.MANDANT_ID 
    AND t3.arthiertyp_id = 2
    AND t3.DAT_BIS = '9999-12-31'
    
    LEFT JOIN 
    (
        Select t4a.folge_beleg_id, t4a.folge_beleg_pos_id, t4a.mandant_id, t4a.wup_id, t4a.dat_buch, t4a.ref_beleg_id, t4b.lager_bewart_id
        FROM
        dbp_data.BEST_BELEGFLUSS t4a
        JOIN dbp_data.LAGERBEW_DET t4b
        ON t4b.lagerbew_beleg_id = t4a.ref_beleg_id
        AND t4b.lagerbew_beleg_pos_id = t4a.ref_beleg_pos_id
        AND t4b.mandant_id = t4a.mandant_id 
        AND t4b.wup_id = t4a.wup_id
        AND t4b.kj = t4a.kj
    ) t4
    ON t1.lagerbew_beleg_id = t4.folge_beleg_id
    AND t1.lagerbew_beleg_pos_id = t4.folge_beleg_pos_id
    AND t1.mandant_id = t4.mandant_id 
    AND t1.wup_id = t4.wup_id
    AND t1.dat_buch = t4.dat_buch
    
    JOIN krs krs
    ON krs.von_wrg_id = t1.wrg_id

    JOIN zeit t
    ON t1.dat_buch = t.dat
    
    JOIN wup wup
    ON t1.mandant_id = wup.mandant_id AND t1.wup_id = wup.wup_id
    
    WHERE 
        t1.mandant_id = 1
    
        AND ((t3.wg_id IN (980,985)
        AND t3.WUG_ID IN (000,100,300,400,500)) OR t1.ART_ID = 980001200 OR t1.ART_ID = 980101000)
        AND t1.lager_bewart_id IN ('157','301','303','304','305','306','901','902','905','906','907','908','912','915','916','X54', 'X65', 'Y05','Y54','Y65')
    
    GROUP BY ALL
)

, zu AS (
    SELECT 
    	k.mandant_id
        , wup.aktuell_wup_id 				                        AS WUP_ID 
        , k.bon_dat                                                 AS DAT
        , krs.nach_wrg_id                                           AS WRG_ID
        , SUM(k2.menge)                                             AS MENGE_ZUFUEHRUNG_INFO
        , SUM(k2.umsatz_brutto* krs.umrechnungskurs * -1)                AS BETRAG_BRUTTO_ZUFUEHRUNG_INFO
    
    FROM dbp_ods.ods_bon_transaction k
    JOIN dbp_ods.ods_bon_kopf k1
    ON k.mandant_id = k1.mandant_id AND k.bon_id = k1.bon_id AND k.wup_id = k1.wup_id AND k.bon_dat = k1. bon_dat
    JOIN dbp_ods.ods_bon_verkauf k2
    ON k2.mandant_id = k1.mandant_id AND k2.bon_id = k1.bon_id AND k2.wup_id = k1.wup_id AND k2.bon_dat = k1. bon_dat
    
    JOIN krs krs
    ON krs.von_wrg_id = k1.wrg_id

    JOIN zeit t
    ON k.bon_dat = t.dat
    
    JOIN wup wup
    ON k1.mandant_id = wup.mandant_id AND k.wup_id = wup.wup_id
    
    WHERE 
        k.mandant_id = 1
        AND (k.bon_id, k.wup_id, k.mandant_id) NOT IN (SELECT bon_id, wup_id, mandant_id  FROM dbp_ods.ods_bon_storno)
        AND turnover_fg = 0
        AND transaction_name = 'EMPTY_CRATE'
    
    GROUP BY ALL

)

, ew AS (
    SELECT 
        ab.mandant_id
        , wup.aktuell_wup_id 				                                     AS WUP_ID 
        , ab.dat
        , krs.nach_wrg_id                                                        AS WRG_ID
        , SUM(menge)                                                             AS MENGE_EINLOESE_KASSE
        , SUM((umsatz_netto + umsatz_mwst_betrag) * krs.umrechnungskurs * -1)    AS BETRAG_BRUTTO_EINLOESE_KASSE                                                                                                        
    FROM dbp_data.artbew ab

    JOIN krs krs
    ON krs.von_wrg_id = ab.wrg
   
    JOIN zeit t
    ON ab.dat = t.dat
    
    JOIN wup wup
    ON ab.mandant_id = wup.mandant_id AND ab.wup_id = wup.wup_id
    
    WHERE art_id IN (980054100,980053300)
    GROUP BY ALL
)

, ea AS (
    SELECT 
        abr.mandant_id
        , wup.aktuell_wup_id 				                                     AS WUP_ID 
        , abr.dat_ruecknahme                                                     AS DAT
        , 'EUR'                                                                  AS WRG_ID
        , SUM(menge_einweg)                                                      AS MENGE_EINWEG_ABRECHNUNG  
        , SUM(menge_einweg * 0.25)                                               AS BETRAG_BRUTTO_EINWEG_ABRECHNUNG 
    FROM dbp_data.leergut_einweg_dat_abrechnung abr
   
    JOIN zeit t
    ON abr.dat_ruecknahme = t.dat
    
    JOIN wup wup
    ON abr.mandant_id = wup.mandant_id AND abr.wup_id = wup.wup_id
        
    GROUP BY ALL

)

, invAuf AS (
    SELECT 
        inv.mandant_id
        , inv.wup_id
        , t.dat
        , wrg_id
        , CASE WHEN t.dat = inv.dat THEN betrag_inventur ELSE 0 END                                                                                                     AS betrag_inventur
        , DENSE_RANK () OVER (PARTITION BY mandant_id, wup_id, wrg_id ORDER BY inv.dat ASC NULLS LAST)                                                                  AS grp_inventur
    FROM
    ( 
        SELECT DISTINCT
            v.mandant_id
            , wup.aktuell_wup_id                                                                                                                                        AS wup_id
            , v.dat + 1                                                                                                                                                 AS dat
            , krs.nach_wrg_id                                                                                                                                           AS wrg_id
            , betrag_leergut_inventur * krs.umrechnungskurs                                                                                                             AS betrag_inventur
            , COALESCE(MAX(dat+1) OVER (PARTITION BY v.mandant_id, wup.aktuell_wup_id, v.wrg_id  ORDER BY v.dat ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) - 1, '9999-12-31')      AS dat_follow
        FROM DBP_MSI_DATA.TS_WUP_DAT_LEERGUT  v
        JOIN wup wup
        ON v.mandant_id = wup.mandant_id AND v.wup_id = wup.wup_id
        JOIN krs krs
        ON krs.von_wrg_id = v.wrg_id
        WHERE betrag_leergut_inventur <> 0
    ) inv
    JOIN zeit t
    WHERE t.dat BETWEEN inv.dat AND inv.dat_follow
)
, invBet AS ( 
        SELECT v.mandant_id
            , wup.aktuell_wup_id                                                                                                                                        AS wup_id
            , v.dat                                                                                                                                                     AS dat
            , krs.nach_wrg_id                                                                                                                                           AS wrg_id
            , SUM(betrag_leergut_inventur * krs.umrechnungskurs)                                                                                                             AS betrag_inventur
        FROM DBP_MSI_DATA.TS_WUP_DAT_LEERGUT  v
        JOIN wup wup
        ON v.mandant_id = wup.mandant_id AND v.wup_id = wup.wup_id 
        JOIN krs krs
        ON krs.von_wrg_id = v.wrg_id
        WHERE betrag_leergut_inventur <> 0
		GROUP BY v.mandant_id
            , wup.aktuell_wup_id
            , v.dat
            , krs.nach_wrg_id
)
, zae AS (
     SELECT v.mandant_id
        , wup.aktuell_wup_id AS wup_id
        , v.dat
        , krs.nach_wrg_id                                                                                                                                                   AS wrg_id
        , SUM(v.betrag_leergut_zaehlung * krs.umrechnungskurs)                                                                                                                   AS betrag_zaehlung
    FROM DBP_MSI_DATA.TS_WUP_DAT_LEERGUT v
    JOIN wup wup
    ON v.mandant_id = wup.mandant_id AND v.wup_id = wup.wup_id
    JOIN krs krs
    ON krs.von_wrg_id = v.wrg_id
    WHERE betrag_leergut_zaehlung <> 0
	GROUP BY v.mandant_id
		, wup.aktuell_wup_id
		, v.dat
		, krs.nach_wrg_id
)
, invZaehl AS (
    SELECT 
        auf.mandant_id
        , auf.wup_id
        , t.dat
        , wrg_id
        , CASE WHEN t.dat = auf.dat THEN betrag_invZaehl ELSE 0 END                                                                                                         AS betrag_invZaehl
        , DENSE_RANK () OVER (PARTITION BY mandant_id, wup_id, wrg_id ORDER BY auf.dat ASC NULLS LAST)                                                                      AS grp_invZaehl
    FROM
    ( 
        SELECT DISTINCT
            v.mandant_id
            , wup.aktuell_wup_id                                                                                                                                            AS wup_id
            , v.dat + 1                                                                                                                                                     AS dat
            , krs.nach_wrg_id                                                                                                                                               AS wrg_id
            , COALESCE(betrag_leergut_inventur, betrag_leergut_zaehlung) * krs.umrechnungskurs                                                                              AS betrag_invZaehl
            , COALESCE(MAX(dat+1) OVER (PARTITION BY v.mandant_id, wup.aktuell_wup_id, v.wrg_id ORDER BY v.dat ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) - 1, '9999-12-31')           AS dat_follow   
        FROM DBP_MSI_DATA.TS_WUP_DAT_LEERGUT v
        JOIN wup wup
        ON v.mandant_id = wup.mandant_id AND v.wup_id = wup.wup_id
        JOIN krs krs
        ON krs.von_wrg_id = v.wrg_id
        WHERE betrag_leergut_inventur <> 0 OR betrag_leergut_zaehlung <> 0
    ) auf
    JOIN zeit t
    WHERE t.dat BETWEEN auf.dat AND auf.dat_follow
)

SELECT
    mandant_id
    , wup_id
    , dat
    , wrg_id

    
    , menge_automat_ew
    , betrag_brutto_automat_ew
    , menge_automat_mw
    , betrag_brutto_automat_mw
    , menge_info_ew
    , betrag_brutto_info_ew
    , menge_info_mw
    , betrag_brutto_info_mw

    
    , menge_we_vz
    , betrag_brutto_we_vz
    , menge_dez_we
    , betrag_brutto_dez_we
    , menge_dez_we_korr
    , betrag_brutto_dez_we_korr
    , menge_dez_we_storno
    , betrag_brutto_dez_we_storno
    , menge_dez_we_uml
    , betrag_brutto_dez_we_uml
    , menge_abholung_vz
    , betrag_brutto_abholung_vz
    , menge_umbuchung_abgang
    , betrag_brutto_umbuchung_abgang
    , menge_abholung_lief
    , betrag_brutto_abholung_lief
    , menge_abholung_lief_korr
    , betrag_brutto_abholung_lief_korr
    , menge_abholung_lief_storno
    , betrag_brutto_abholung_lief_storno
    , menge_abschschrift_fremd
    , betrag_brutto_abschrift_fremd
    , menge_abschrift_bruch
    , betrag_brutto_abschrift_bruch
    , menge_abschrift_entsorgungmod
    , betrag_brutto_abschrift_entsorgungmod

    
    , menge_zufuehrung_info
	, betrag_brutto_zufuehrung_info

    
    , menge_einloese_kasse
	, betrag_brutto_einloese_kasse 

    
    , menge_einweg_abrechnung
    , betrag_brutto_einweg_abrechnung
    
    
    , betrag_brutto_zugang
    , betrag_brutto_abgang
    , betrag_brutto_zugang + betrag_brutto_abgang AS betrag_brutto_veraenderung

    
    , betrag_inventur

    
    , grp_inventur
    , IFF(grp_inventur IS NULL, NULL, betrag_inventur_auf + betrag_brutto_veraenderung) AS kombi_inv
    , SUM(kombi_inv) OVER (PARTITION BY mandant_id, wup_id, wrg_id, grp_inventur ORDER BY dat)  AS betrag_inventur_auf
    
    
    , betrag_zaehlung
    
    
    , grp_invZaehl
    , IFF(grp_invZaehl IS NULL, NULL, betrag_invZaehl + betrag_brutto_veraenderung) AS kombi_invZaehl
    , SUM(kombi_invZaehl) OVER (PARTITION BY mandant_id, wup_id, wrg_id, grp_invZaehl ORDER BY dat)  AS betrag_invZaehl_auf
FROM
(
    SELECT 
        vis.mandant_id
        , vis.wup_id
        , vis.dat
        , vis.wrg_id

        
        , COALESCE(menge_automat_ew, 0)                                                         AS menge_automat_ew
        , COALESCE(betrag_brutto_automat_ew, 0)                                                 AS betrag_brutto_automat_ew
        , COALESCE(menge_automat_mw, 0)                                                         AS menge_automat_mw
        , COALESCE(betrag_brutto_automat_mw, 0)                                                 AS betrag_brutto_automat_mw
        , COALESCE(menge_info_ew, 0)                                                            AS menge_info_ew
        , COALESCE(betrag_brutto_info_ew, 0)                                                    AS betrag_brutto_info_ew
        , COALESCE(menge_info_mw, 0)                                                            AS menge_info_mw
        , COALESCE(betrag_brutto_info_mw, 0)                                                    AS betrag_brutto_info_mw
    
        
        , COALESCE(menge_we_vz, 0)                                                              AS menge_we_vz
        , COALESCE(betrag_brutto_we_vz, 0)                                                      AS betrag_brutto_we_vz
        , COALESCE(menge_dez_we, 0)                                                             AS menge_dez_we
        , COALESCE(betrag_brutto_dez_we, 0)                                                     AS betrag_brutto_dez_we
        , COALESCE(menge_dez_we_korr, 0)                                                        AS menge_dez_we_korr
        , COALESCE(betrag_brutto_dez_we_korr, 0)                                                AS betrag_brutto_dez_we_korr
        , COALESCE(menge_dez_we_storno, 0)                                                      AS menge_dez_we_storno
        , COALESCE(betrag_brutto_dez_we_storno, 0)                                              AS betrag_brutto_dez_we_storno
        , COALESCE(menge_dez_we_uml, 0)                                                         AS menge_dez_we_uml
        , COALESCE(betrag_brutto_dez_we_uml, 0)                                                 AS betrag_brutto_dez_we_uml
        , COALESCE(menge_abholung_vz, 0)                                                        AS menge_abholung_vz
        , COALESCE(betrag_brutto_abholung_vz, 0)                                                AS betrag_brutto_abholung_vz
        , COALESCE(menge_umbuchung_abgang, 0)                                                   AS menge_umbuchung_abgang
        , COALESCE(betrag_brutto_umbuchung_abgang, 0)                                           AS betrag_brutto_umbuchung_abgang
        , COALESCE(menge_abholung_lief, 0)                                                      AS menge_abholung_lief
        , COALESCE(betrag_brutto_abholung_lief, 0)                                              AS betrag_brutto_abholung_lief
        , COALESCE(menge_abholung_lief_korr, 0)                                                 AS menge_abholung_lief_korr
        , COALESCE(betrag_brutto_abholung_lief_korr, 0)                                         AS betrag_brutto_abholung_lief_korr
        , COALESCE(menge_abholung_lief_storno, 0)                                               AS menge_abholung_lief_storno
        , COALESCE(betrag_brutto_abholung_lief_storno, 0)                                       AS betrag_brutto_abholung_lief_storno
        , COALESCE(menge_abschschrift_fremd, 0)                                                 AS menge_abschschrift_fremd
        , COALESCE(betrag_brutto_abschrift_fremd, 0)                                            AS betrag_brutto_abschrift_fremd
        , COALESCE(menge_abschrift_bruch, 0)                                                    AS menge_abschrift_bruch
        , COALESCE(betrag_brutto_abschrift_bruch, 0)                                            AS betrag_brutto_abschrift_bruch
        , COALESCE(menge_abschrift_entsorgungmod, 0)                                            AS menge_abschrift_entsorgungmod
        , COALESCE(betrag_brutto_abschrift_entsorgungmod, 0)                                    AS betrag_brutto_abschrift_entsorgungmod
    
        
        , COALESCE(menge_zufuehrung_info, 0)                                                    AS menge_zufuehrung_info
    	, COALESCE(betrag_brutto_zufuehrung_info, 0)                                            AS betrag_brutto_zufuehrung_info

        
        , COALESCE(menge_einloese_kasse, 0)                                                     AS menge_einloese_kasse 
        , COALESCE(betrag_brutto_einloese_kasse, 0)                                             AS betrag_brutto_einloese_kasse 

        
        , COALESCE(menge_einweg_abrechnung, 0)                                                  AS menge_einweg_abrechnung 
        , COALESCE(betrag_brutto_einweg_abrechnung, 0)                                          AS betrag_brutto_einweg_abrechnung 
        
        
        , COALESCE(betrag_brutto_automat_mw, 0) + COALESCE(betrag_brutto_info_mw, 0) + COALESCE(betrag_brutto_dez_we, 0) + COALESCE(betrag_brutto_dez_we_korr, 0) + COALESCE(betrag_brutto_dez_we_storno, 0) + COALESCE(betrag_brutto_dez_we_uml, 0) + COALESCE(betrag_brutto_zufuehrung_info, 0) AS betrag_brutto_zugang 
        , COALESCE(betrag_brutto_abholung_vz, 0) + COALESCE(betrag_brutto_umbuchung_abgang, 0) + COALESCE(betrag_brutto_abholung_lief, 0) + COALESCE(betrag_brutto_abholung_lief_korr, 0) + COALESCE(betrag_brutto_abschrift_fremd, 0) + COALESCE(betrag_brutto_abschrift_bruch, 0) AS betrag_brutto_abgang

        
        , COALESCE(invBet.betrag_inventur, 0)                                                   AS betrag_inventur
        
        
        , COALESCE(invAuf.betrag_inventur, 0)                                                   AS betrag_inventur_auf
        , invAuf.grp_inventur
        
        
        , COALESCE(zae.betrag_zaehlung, 0)                                                      AS betrag_zaehlung
        
        
        , COALESCE(invZaehl.betrag_invZaehl, 0)                                                 AS betrag_invZaehl
        , invZaehl.grp_invZaehl
    FROM vis
    LEFT OUTER JOIN an
        ON vis.mandant_id = an.mandant_id AND vis.wup_id = an.wup_id AND vis.dat = an.dat AND vis.wrg_id = an.wrg_id
    LEFT OUTER JOIN wf
        ON vis.mandant_id = wf.mandant_id AND vis.wup_id = wf.wup_id AND vis.dat = wf.dat AND vis.wrg_id = wf.wrg_id
    LEFT OUTER JOIN  zu
        ON vis.mandant_id = zu.mandant_id AND vis.wup_id = zu.wup_id AND vis.dat = zu.dat AND vis.wrg_id = zu.wrg_id
    LEFT OUTER JOIN  ew
        ON vis.mandant_id = ew.mandant_id AND vis.wup_id = ew.wup_id AND vis.dat = ew.dat AND vis.wrg_id = ew.wrg_id
    LEFT OUTER JOIN  ea
        ON vis.mandant_id = ea.mandant_id AND vis.wup_id = ea.wup_id AND vis.dat = ea.dat AND vis.wrg_id = ea.wrg_id
    LEFT OUTER JOIN invAuf
        ON vis.mandant_id = invAuf.mandant_id AND vis.wup_id = invAuf.wup_id AND vis.dat = invAuf.dat AND vis.wrg_id = invAuf.wrg_id
    LEFT OUTER JOIN invBet
        ON vis.mandant_id = invBet.mandant_id AND vis.wup_id = invBet.wup_id AND vis.dat = invBet.dat AND vis.wrg_id = invBet.wrg_id  
    LEFT OUTER JOIN zae
        ON vis.mandant_id = zae.mandant_id AND vis.wup_id = zae.wup_id AND vis.dat = zae.dat AND vis.wrg_id = zae.wrg_id
    LEFT OUTER JOIN invZaehl
        ON vis.mandant_id = invZaehl.mandant_id AND vis.wup_id = invZaehl.wup_id AND vis.dat = invZaehl.dat AND vis.wrg_id = invZaehl.wrg_id
    
)
;
