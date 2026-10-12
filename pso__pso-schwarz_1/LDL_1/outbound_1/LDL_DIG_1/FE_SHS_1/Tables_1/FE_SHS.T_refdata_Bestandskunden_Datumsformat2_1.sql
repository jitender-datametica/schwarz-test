CREATE TABLE IF NOT EXISTS ldl_dig_fe_shs.t_refdata_bestandskunden_datumsformat2_1 AS WITH H_HAUPTKUNDENLISTE AS (SELECT CAST(CONCAT(KNA1.kunnr, KNA1.sap_client_id) AS STRING) AS debitor_org_mandant,
   KNA1.anred AS salutation,
    CASE
    WHEN KNA1.name1 IS NOT NULL
    THEN IFNULL(SPLIT(KNA1.name1, ' ')[SAFE_OFFSET(0)], '')
    ELSE NULL
    END AS firstname,
   RIGHT(KNA1.name1, LENGTH(KNA1.name1) - STRPOS(KNA1.name1, ' ')) AS lastname,
   KNA1.kunnr AS debitor,
   KNA1.kunnr AS geschpartner,
   ADRC.nameco AS companyname,
   BUT000.birthdt AS dateofbirth,
   ADR2.telnumber AS phone,
   ADR6.smtpaddr AS email,
   ADRC.street AS streetname,
   ADRC.housenum1 AS streetnumber,
   ADRC.strsuppl2 AS addresssuffix,
   ADRC.postcode1 AS zipcode,
   ADRC.city1 AS city,
   ADRC.country_1,
    CASE
    WHEN CONCAT(KNA1.kunnr, KNA1.sap_client_id) IN ('1067363151100', '1072574974100')
    THEN 1
    ELSE CASE
     WHEN KNA1.aufsd IS NOT NULL
     THEN 1
     ELSE 0
     END
    END AS sperrmerkmal,
    CASE
    WHEN CONCAT(KNA1.kunnr, KNA1.sap_client_id) = '1000940044100'
    THEN 0
    ELSE FKKMAZE.aktuelle_mahnstufe
    END AS mahnstufe,
   VBAK.datum_erste_bestellung,
   VBAK.datum_letzte_bestellung
  FROM ldl_dig_etl.t_kna1_1 AS KNA1_1
   INNER JOIN (SELECT CONCAT(kunnr, sap_client_id) AS debitor_org_mandant,
     DATE(MIN(audat)) AS datum_erste_bestellung,
     DATE(MAX(audat)) AS datum_letzte_bestellung
    FROM ldl_dig_etl.t_vbak_1
    WHERE audat > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
     AND vbtyp = 'C'
    GROUP BY debitor_org_mandant) AS VBAK ON CONCAT(KNA1.kunnr, KNA1.sap_client_id) = VBAK.debitor_org_mandant
   LEFT JOIN ldl_dig_etl.t_but000_1 AS BUT000 ON CONCAT(KNA1.kunnr, KNA1.sap_client_id) = CONCAT(BUT000.partner, BUT000.sap_client_id
     )
   LEFT JOIN (SELECT *
    FROM ldl_dig_etl.t_adr2_1
    WHERE (validfrom = '' OR validto = '')
     AND flgdefault = 'X') AS ADR2 ON CONCAT(BUT000.addrcomm, BUT000.sap_client_id) = CONCAT(ADR2.addrnumber, ADR2.sap_client_id
     )
   LEFT JOIN (SELECT *
    FROM ldl_dig_etl.t_adr6_1
    WHERE (validfrom = '' OR validto = '')
     AND flgdefault = 'X') AS ADR6_1 ON CONCAT(BUT000.addrcomm, BUT000.sap_client_id) = CONCAT(ADR6.addrnumber, ADR6.sap_client_id
     )
   LEFT JOIN ldl_dig_etl.t_adrc_1 AS ADRC_1 ON CONCAT(KNA1.adrnr, KNA1.sap_client_id) = CONCAT(ADRC.addrnumber, ADRC.sap_client_id
     )
   LEFT JOIN (SELECT CONCAT(FKKMAZE.gpart, FKKMAZE.sap_client_id) AS geschpartner_mandant,
     MAX(FKKMAZE.mahns) AS aktuelle_mahnstufe
    FROM ldl_dig_etl.t_fkkmaze_1 AS FKKMAZE
     LEFT JOIN ldl_dig_etl.t_dfkkop_1 AS DFKKOP ON CONCAT(DFKKOP.gpart, DFKKOP.sap_client_id, DFKKOP.opbel, DFKKOP.opupw,
       DFKKOP.opupk, DFKKOP.opupz) = CONCAT(FKKMAZE.gpart, FKKMAZE.sap_client_id, FKKMAZE.opbel, FKKMAZE.opupw, FKKMAZE
       .opupk, FKKMAZE.opupz)
    WHERE FKKMAZE.mahns > 0
     AND DFKKOP.augst <> '9'
     AND DFKKOP.bldat >= DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
     AND DFKKOP.blart NOT IN ('GA', 'ZU', 'ZI', 'GW')
    GROUP BY geschpartner_mandant) AS FKKMAZE ON CONCAT(KNA1.kunnr, KNA1.sap_client_id) = FKKMAZE.geschpartner_mandant
  WHERE KNA1.ktokd = 'ZBC0' -- This is the condition "WHERE exists( Flag_Hauptkunde )"

   AND ADRC.country_1 IN ('DE', 'NL')), R_SHS_BASIS_KENNAHLEN AS (SELECT CONCAT(DFKKOP0.gpart, DFKKOP0.sap_client_id) AS
   geschpartner_mandant,
   CONCAT(DFKKOP0.xblnr, DFKKOP0.sap_client_id) AS verkaufsbeleg_mandant,
   DFKKOP0.blart AS text_blart,
   DFKKOP0.bldat AS belegdatum_bldat,
   CONCAT(DFKKOP0.opbel, DFKKOP0.sap_client_id) AS cax_belegnummer_mandant,
   DFKKOP0.opbel AS belegnummer_opbel,
   DFKKOP0.augst AS ausgleichsstatus_augst,
   DFKKOP0.betrh AS hausw_betrh,
   DFKKOP0.pymet AS zahlweg_pymet,
   CONSTANT_I_TWO.zlow AS zahlart_zzsecpayment,
    CASE
    WHEN DFKKOP0.augst = '9'
    THEN 1
    ELSE 0
    END AS flag_auftrag_bezahlt
  FROM ldl_dig_etl.t_dfkkop_1 AS DFKKOP0
   LEFT JOIN (SELECT fieldname,
     zlow
    FROM ldl_dig_etl.t_constant_i_1
    WHERE conkey = 410
     AND NOT STARTS_WITH(fieldname, 'SEC_')
     AND NOT STARTS_WITH(fieldname, 'REF_')) AS CONSTANT_I ON DFKKOP0.pymet = CONSTANT_I.zlow
   LEFT JOIN (SELECT LTRIM(fieldname, 'SEC_') AS fieldname,
     zlow
    FROM ldl_dig_etl.t_constant_i_1
    WHERE conkey = 410
     AND STARTS_WITH(fieldname, 'SEC_')) AS CONSTANT_I_TWO ON CONSTANT_I.fieldname = CONSTANT_I_TWO.fieldname
  WHERE DFKKOP0.bldat > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
   AND DFKKOP0.blart IN ('RE_1', 'RP', 'RL')
   AND ROUND(SAFE_CAST(CONCAT(DFKKOP0.xblnr, DFKKOP0.sap_client_id) AS BIGNUMERIC), 0) IS NOT NULL
   AND ROUND(SAFE_CAST(CONCAT(DFKKOP0.gpart, DFKKOP0.sap_client_id) AS BIGNUMERIC), 0) IS NOT NULL
   AND ROUND(SAFE_CAST(CONCAT(DFKKOP0.opbel, DFKKOP0.sap_client_id) AS BIGNUMERIC), 0) IS NOT NULL
  ORDER BY geschpartner_mandant DESC NULLS FIRST), R_SHS_KENNZAHLEN_FAKTURA_FINAL AS (SELECT geschpartner_mandant,
   COUNT(DISTINCT CASE
     WHEN zahlart_zzsecpayment = 'X'
     THEN verkaufsbeleg_mandant
     ELSE NULL
     END) AS gp_anzahl_best_sza_12m,
   COUNT(DISTINCT CASE
     WHEN zahlart_zzsecpayment = ''
     THEN verkaufsbeleg_mandant
     ELSE NULL
     END) AS gp_anzahl_best_nsza_12m,
   SUM(CASE
     WHEN zahlart_zzsecpayment = 'X'
     THEN hausw_betrh
     ELSE 0
     END) AS gp_volumen_best_sza_12m,
   SUM(CASE
     WHEN zahlart_zzsecpayment = ''
     THEN hausw_betrh
     ELSE 0
     END) AS gp_volumen_best_nsza_12m
  FROM R_SHS_BASIS_KENNAHLEN
  WHERE flag_auftrag_bezahlt = 1
  GROUP BY geschpartner_mandant), T_DFKKOP_LASTSCHRIFT02 AS (SELECT geschpartner_mandant,
   PARSE_DATE('%F', SUBSTR(CAST(MAX(belegdatumlastschrift) AS STRING), 1, 20)) AS belegdatumletztelastschrift
  FROM (SELECT DISTINCT CAST(CONCAT(gpart, sap_client_id) AS STRING) AS geschpartner_mandant,
     bldat AS belegdatumlastschrift
    FROM ldl_dig_etl.t_dfkkop_1
    WHERE pymet IN ('L', 'B')) AS LASTSCHRIFT
  GROUP BY geschpartner_mandant), R_SHS_KENNZAHLEN_RETOURENQUOTE_SD AS (SELECT CONCAT(VBAK.kunnr, VBAP.sap_client_id) AS
   geschpartner_mandant,
   SUM(VBAP.kzwi1) AS retourenwert
  FROM ldl_dig_etl.t_vbak_1 AS VBAK
   LEFT JOIN ldl_dig_etl.t_vbap_1 AS VBAP ON VBAK.vbeln = VBAP.vbeln
  WHERE VBAK.audat > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
   AND VBAK.vbtyp = 'H'
  GROUP BY geschpartner_mandant), R_SHS_KENNZAHLEN_RETOURENQUOTE_CAX AS (SELECT geschpartner_mandant,
   SUM(hausw_betrh) AS gesamtfakturawert
  FROM R_SHS_BASIS_KENNAHLEN
  WHERE ausgleichsstatus_augst = '9'
   AND text_blart = 'RE_1'
   AND belegdatum_bldat > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
  GROUP BY geschpartner_mandant), R_SHS_KENNZAHLEN_OP_FK_FINAL AS (SELECT geschpartner_mandant,
   SUM(CASE
     WHEN zahlart_zzsecpayment = 'X'
     THEN hausw_betrh
     ELSE 0
     END) AS gp_op_fakturiert_sza,
   SUM(CASE
     WHEN zahlart_zzsecpayment = ''
     THEN hausw_betrh
     ELSE 0
     END) AS gp_op_fakturiert
  FROM R_SHS_BASIS_KENNAHLEN
  WHERE ausgleichsstatus_augst = ''
  GROUP BY geschpartner_mandant), R_SHS_KENNZAHLEN_OP_NFK_FINAL AS (SELECT CONCAT(VBAK.kunnr, VBAK.sap_client_id) AS
   geschpartner_mandant,
   SUM(CASE
     WHEN CONST.zahlart_zzsecpayment = 'X'
     THEN VBAP0.kzwi1
     ELSE 0
     END) AS gp_op_nichtfakturiert_sza,
   SUM(CASE
     WHEN CONST.zahlart_zzsecpayment = ''
     THEN VBAP0.kzwi1
     ELSE 0
     END) AS gp_op_nichtfakturiert
  FROM ldl_dig_etl.t_dfkkop_1 AS DFKKOP3
   LEFT JOIN (SELECT *
    FROM ldl_dig_etl.t_vbak_1
    WHERE audat > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
     AND vbtyp = 'C') AS VBAK ON DFKKOP3.xblnr = VBAK.vbeln
   LEFT JOIN ldl_dig_etl.t_vbkd_1 AS VBKD ON VBAK.vbeln = VBKD.vbeln
   LEFT JOIN (SELECT zlow AS zahlart_zzsecpayment,
     LTRIM(fieldname, 'SEC_') AS fieldname
    FROM ldl_dig_etl.t_constant_i_1
    WHERE conkey = 410
     AND STARTS_WITH(fieldname, 'SEC_')) AS CONST ON VBKD.zterm = CONST.fieldname
   LEFT JOIN ldl_dig_etl.t_vbap_1 AS VBAP0 ON VBAK.vbeln = VBAP0.vbeln
    -- The following WHERE is equivalent to VBUK.Flag_nicht_fakturiert = '1'

  WHERE DFKKOP3.augst = ''
  GROUP BY geschpartner_mandant), KUNDENAUFTRAGSPOSITIONEN_TMP AS (SELECT CAST(CONCAT(VBAK0.vbeln, VBAK0.sap_client_id) AS STRING)
   AS verkaufsbeleg_mandant,
   VBAK0.audat AS kaufdatum_hist,
   CAST(CONCAT(VBAK0.kunnr, VBAP1.sap_client_id) AS STRING) AS gpid_mandant,
   VBAP1.matnr AS artikel_1,
   VBAP1.kzwi1 AS brutto_artikelverkaufswert_kzwi1,
   VBAP1.kzwi2 AS brutto_versandkostenpauschale_kzwi2,
   VBAP1.kzwi3 AS brutto_art_spez_versandkosten_kzwi3,
   CAST(LEFT(MVKE.prodh, 2) AS STRING) AS shopcat_ebene1,
   TVKBT.bezei AS verkaufskanal_hist,
   VBKD0.zterm AS zahlweg_hist,
    CASE
    WHEN VBAK0.augru IS NULL
    THEN 0
    ELSE 1
    END AS flag_storno,
   BUT0.addrcomm AS billing_address_sid,
   BUT1.addrcomm AS delivery_address_sid,
    CASE
    WHEN BUT0.addrcomm <> BUT1.addrcomm
    THEN 1
    ELSE 0
    END AS fl_abweichende_lieferadresse_hist
  FROM ldl_dig_etl.t_vbak_1 AS VBAK0
   LEFT JOIN ldl_dig_etl.t_vbap_1 AS VBAP1 ON CAST(CONCAT(VBAK0.vbeln, VBAK0.sap_client_id) AS STRING) = CAST(CONCAT(VBAP1.vbeln, VBAP1.sap_client_id) AS STRING)
    
   LEFT JOIN ldl_dig_etl.t_mvke_1 AS MVKE_1 ON CAST(CONCAT(VBAP1.matnr, VBAK0.vkorg) AS STRING) = CAST(CONCAT(MVKE.matnr, MVKE.vkorg) AS STRING)
    
   LEFT JOIN (SELECT '0001' AS vkbur,
     'Sales_1 Office South' AS bezei
    FROM (SELECT '0001' AS column1,
        'Sales_1 Office South' AS column2
       UNION ALL
       SELECT '1000' AS column1,
        'Web' AS column2
       UNION ALL
       SELECT '2000' AS column1,
        'Android' AS column2
       UNION ALL
       SELECT '3000' AS column1,
        'iOS' AS column2
       UNION ALL
       SELECT '4000' AS column1,
        'CSA' AS column2)) AS TVKBT ON VBAK0.vkbur = TVKBT.vkbur
   LEFT JOIN ldl_dig_etl.t_vbkd_1 AS VBKD0 ON CAST(CONCAT(VBAK0.vbeln, VBAK0.sap_client_id, CAST(VBAP1.posnr AS STRING))
     AS STRING) = CAST(CONCAT(VBKD0.vbeln, VBKD0.sap_client_id, CAST(VBKD0.posnr AS STRING)) AS STRING)
   LEFT JOIN ldl_dig_etl.t_but000_1 AS BUT0 ON VBAK0.kunnr = BUT0.partner
   LEFT JOIN (SELECT vbeln,
     kunnr,
     posnr
    FROM ldl_dig_etl.t_vbpa_1
    WHERE parvw = 'WE') AS VBPA ON CAST(CONCAT(VBAK0.vbeln, VBAP1.posnr) AS STRING) = CAST(CONCAT(VBPA.vbeln, VBPA.posnr) AS STRING)
    
   LEFT JOIN ldl_dig_etl.t_but000_1 AS BUT1 ON VBPA.kunnr = BUT1.partner
  WHERE VBAK0.audat > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
   AND VBAK0.vbtyp = 'C'), KUNDENHISTORIE AS (SELECT gpid_mandant AS debitor_org_mandant,
   SUM(DISTINCT CAST(verkaufsbeleg_mandant AS FLOAT64)) AS anzahl_bestellungen_hist,
   SUM(brutto_artikelverkaufswert_kzwi1 + brutto_versandkostenpauschale_kzwi2 + brutto_art_spez_versandkosten_kzwi3) AS
   sum_warenkorb_wert_hist,
   MAX(CASE
     WHEN flag_storno = 1 AND brutto_artikelverkaufswert_kzwi1 IS NOT NULL AND brutto_versandkostenpauschale_kzwi2
       IS NOT NULL AND brutto_art_spez_versandkosten_kzwi3 IS NOT NULL
     THEN 1
     ELSE 0
     END) AS fl_stornoauftrag_hist,
   MAX(CASE
     WHEN zahlweg_hist = 'X' AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_zahlweg_raten_hist,
   MAX(CASE
     WHEN zahlweg_hist IN ('B', 'R') AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_zahlweg_rechnung_hist,
   MAX(CASE
     WHEN zahlweg_hist IN ('P', 'K', 'S', '', 'G', 'V') AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_zahlweg_sichere_za_hist,
   MAX(CASE
     WHEN shopcat_ebene1 = '55' AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_gesundheit_warenkorb_hist,
   MAX(CASE
     WHEN shopcat_ebene1 = '20' AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_haushalt_warenkorb_hist,
   MAX(CASE
     WHEN shopcat_ebene1 = '60' AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_hobby_warenkorb_hist,
   MAX(CASE
     WHEN shopcat_ebene1 = '36' AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_kinderwelt_warenkorb_hist,
   MAX(CASE
     WHEN shopcat_ebene1 = '46' AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_mode_warenkorb_hist,
   MAX(CASE
     WHEN shopcat_ebene1 = '17' AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_multimedia_warenkorb_hist,
   MAX(CASE
     WHEN shopcat_ebene1 = '27' AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_sport_warenkorb_hist,
   MAX(CASE
     WHEN shopcat_ebene1 = '50' AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_weinwelt_warenkorb_hist,
   MAX(CASE
     WHEN shopcat_ebene1 = '41' AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_baumarkt_warenkorb_hist,
   MAX(CASE
     WHEN shopcat_ebene1 = '31' AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_wohnen_warenkorb_hist,
   MAX(CASE
     WHEN verkaufskanal_hist = 'Web' AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_kanal_web_hist,
   MAX(CASE
     WHEN verkaufskanal_hist = 'CIC' AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_kanal_cic_hist,
   MAX(CASE
     WHEN verkaufskanal_hist = 'iPhone' AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_kanal_iphone_hist,
   MAX(CASE
     WHEN verkaufskanal_hist = 'Android' AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_kanal_android_hist,
   MAX(CASE
     WHEN fl_abweichende_lieferadresse_hist = 1 AND brutto_artikelverkaufswert_kzwi1 > 0
     THEN 1
     ELSE 0
     END) AS fl_abweichende_lieferadresse_hist,
   MAX(kaufdatum_hist) AS letztkaufdatum
  FROM KUNDENAUFTRAGSPOSITIONEN_TMP
  GROUP BY debitor_org_mandant), DFKKOP_HOECHSTE_AKTUELLSTE_MAHNSTUFE AS (SELECT CONCAT(DFKKOP4.gpart, DFKKOP4.sap_client_id
    , DFKKOP4.opbel, DFKKOP4.opupw, DFKKOP4.opupk, DFKKOP4.opupz) AS geschpartner_belegnummer_mandant,
   CONCAT(DFKKOP4.gpart, DFKKOP4.sap_client_id) AS geschpartner_mandant,
   DFKKOP4.blart AS belegart_blart,
   DFKKOP4.augst AS ausgleichsstatus_augst,
   FKKMAZE.mahnstufe_mahns
  FROM ldl_dig_etl.t_dfkkop_1 AS DFKKOP4
   INNER JOIN (SELECT CONCAT(gpart, sap_client_id, opbel, opupw, opupk, opupz) AS geschpartner_belegnummer_mandant,
     MAX(mahns) AS mahnstufe_mahns
    FROM ldl_dig_etl.t_fkkmaze_1
    WHERE laufd >= DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
    GROUP BY geschpartner_belegnummer_mandant) AS FKKMAZE ON CONCAT(DFKKOP4.gpart, DFKKOP4.sap_client_id, DFKKOP4.opbel
     , DFKKOP4.opupw, DFKKOP4.opupk, DFKKOP4.opupz) = FKKMAZE.geschpartner_belegnummer_mandant
  WHERE DFKKOP4.bldat >= DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
  ORDER BY geschpartner_mandant NULLS LAST), MAHNPOSITIONEN AS (SELECT geschpartner_mandant,
   MAX(mahnstufe_mahns) AS aktuell_hoechste_mahnstufe
  FROM DFKKOP_HOECHSTE_AKTUELLSTE_MAHNSTUFE
  WHERE mahnstufe_mahns > 0
   AND ausgleichsstatus_augst <> '9'
   AND belegart_blart NOT IN ('GA', 'ZU', 'ZI', 'GW')
  GROUP BY geschpartner_mandant), KUNDENLISTE_FULL AS (SELECT LEFT(HAUPT.debitor_org_mandant, 10) AS debitor_org_mandant
   ,
   HAUPT.salutation,
   HAUPT.firstname,
   HAUPT.lastname,
   HAUPT.companyname,
   HAUPT.dateofbirth,
   HAUPT.phone,
   HAUPT.email,
   'N' AS flag_nur_lieferadresse,
   HAUPT.streetname,
   HAUPT.streetnumber,
   HAUPT.addresssuffix,
   HAUPT.zipcode,
   HAUPT.city,
   HAUPT.country_1,
   HAUPT.sperrmerkmal,
   HAUPT.mahnstufe,
   HAUPT.datum_erste_bestellung,
   HAUPT.datum_letzte_bestellung,
   FAKTURA.gp_anzahl_best_sza_12m,
   FAKTURA.gp_anzahl_best_nsza_12m,
   LASTSCHR.belegdatumletztelastschrift,
   ROUND(FAKTURA.gp_volumen_best_sza_12m, 2) AS gp_volumen_best_sza_12m,
   ROUND(FAKTURA.gp_volumen_best_nsza_12m, 2) AS gp_volumen_best_nsza_12m,
    CASE
    WHEN RETCAX.gesamtfakturawert = 0
    THEN 0
    ELSE CEIL(RETSD.retourenwert / RETCAX.gesamtfakturawert * 100)
    END AS gp_retouren_quote_prz_12m,
   OPFK.gp_op_fakturiert_sza,
   OPFK.gp_op_fakturiert,
   OPNFK.gp_op_nichtfakturiert_sza,
   OPNFK.gp_op_nichtfakturiert,
   HIST.fl_stornoauftrag_hist,
   HIST.fl_zahlweg_raten_hist,
   HIST.fl_zahlweg_rechnung_hist,
   HIST.fl_zahlweg_sichere_za_hist,
   HIST.fl_gesundheit_warenkorb_hist,
   HIST.fl_haushalt_warenkorb_hist,
   HIST.fl_hobby_warenkorb_hist,
   HIST.fl_kinderwelt_warenkorb_hist,
   HIST.fl_mode_warenkorb_hist,
   HIST.fl_multimedia_warenkorb_hist,
   HIST.fl_sport_warenkorb_hist,
   HIST.fl_weinwelt_warenkorb_hist,
   HIST.fl_baumarkt_warenkorb_hist,
   HIST.fl_wohnen_warenkorb_hist,
   HIST.fl_kanal_web_hist,
   HIST.fl_kanal_cic_hist,
   HIST.fl_kanal_iphone_hist,
   HIST.fl_kanal_android_hist,
   HIST.fl_abweichende_lieferadresse_hist,
   MAHN.aktuell_hoechste_mahnstufe,
    CASE
    WHEN HIST.letztkaufdatum > DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
    THEN 'selber_Monat'
    WHEN HIST.letztkaufdatum > DATE_SUB(CURRENT_DATE, INTERVAL 60 DAY)
    THEN 'letzter_Monat'
    WHEN HIST.letztkaufdatum > DATE_SUB(CURRENT_DATE, INTERVAL 120 DAY)
    THEN 'zwei_bis_drei_Monate'
    WHEN HIST.letztkaufdatum > DATE_SUB(CURRENT_DATE, INTERVAL 99999 DAY)
    THEN 'mehr_als_drei_Monate'
    ELSE 'Kein_Kauf'
    END AS kl_letztkauf
  FROM H_HAUPTKUNDENLISTE AS HAUPT
   LEFT JOIN R_SHS_KENNZAHLEN_FAKTURA_FINAL AS FAKTURA ON HAUPT.debitor_org_mandant = FAKTURA.geschpartner_mandant
   LEFT JOIN T_DFKKOP_LASTSCHRIFT02 AS LASTSCHR ON HAUPT.debitor_org_mandant = LASTSCHR.geschpartner_mandant
   LEFT JOIN R_SHS_KENNZAHLEN_RETOURENQUOTE_SD AS RETSD ON HAUPT.debitor_org_mandant = RETSD.geschpartner_mandant
   LEFT JOIN R_SHS_KENNZAHLEN_RETOURENQUOTE_CAX AS RETCAX ON HAUPT.debitor_org_mandant = RETCAX.geschpartner_mandant
   LEFT JOIN R_SHS_KENNZAHLEN_OP_FK_FINAL AS OPFK ON HAUPT.debitor_org_mandant = OPFK.geschpartner_mandant
   LEFT JOIN R_SHS_KENNZAHLEN_OP_NFK_FINAL AS OPNFK ON HAUPT.debitor_org_mandant = OPNFK.geschpartner_mandant
   LEFT JOIN KUNDENHISTORIE AS HIST ON HAUPT.debitor_org_mandant = HIST.debitor_org_mandant
   LEFT JOIN MAHNPOSITIONEN AS MAHN ON HAUPT.debitor_org_mandant = MAHN.geschpartner_mandant) (-- Is the following CROSS JOIN correct or do we need sap client id?

  SELECT *
  FROM KUNDENLISTE_FULL);
