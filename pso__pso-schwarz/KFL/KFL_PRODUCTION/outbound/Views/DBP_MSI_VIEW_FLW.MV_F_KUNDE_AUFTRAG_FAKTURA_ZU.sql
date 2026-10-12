-- 26.03.2013 TWIE: negatives Vorzeichen fuer Fakturaart ZG25

-- 08.01.2013 twie: NEU Verbindung von kunde_auftrag ueber in_besch_lief_det zu in_besch_faktura_det

-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

-- 05.11.2013 TWIE: Vorzeichen fuer Fakturaart ZFG6 nicht mehr umdrehen, passiert bei dieser schon in SAP

-- 17.01.2014 TWIE: Aussage vom 05.11.2013 stimmt nur bei Preisen, Mengen muessen weiterhin bei ZFG6 umgedreht werden

-- Da in dieser View nur Mengen sind, keine Preise, die ZFG6 wieder aufnehmen

-- 07.09.2016 TWIE: SPEC0014089 Filter auf Fakturaarten erweitern

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_kunde_auftrag_faktura_zu (verkaufs_beleg_id,
verkaufs_beleg_pos_id, lief_beleg_id, lief_beleg_pos_id, faktura_beleg_id, faktura_beleg_pos_id, mandant_id, in_art_id,
werk_id, in_vw_id, absagegrund_id, verk_menge_faktura_einh_id, fakturaart_id, menge_auftrag_vme_kum, menge_bes_bme_kum,
menge_bes_bme_kum_kg, menge_faktura_vkme, menge_faktura_lme, gewicht_netto) AS
-- in MSI kaeme er sonst ueber die Faktura
 -- spart CROSS JOIN in MSI

-- Vorzeichenbestimmung positives Vorzeichen (Lastschriften)

-- Vorzeichenbestimmung negatives Vorzeichen (Gutschriften)
 -- Auftrag
 -- zur Ermittlung des VW

-- Lieferung(en) zum Auftrag
 -- Mapping Lieferung zu Faktura (in_vbfa)
 -- Faktura zur Lieferung
 SELECT -- Belege
 V01
 .verkaufs_beleg_id,
 V01.verkaufs_beleg_pos_id,
 V02.lief_beleg_id,
 V02.lief_beleg_pos_id,
 V04.faktura_beleg_id,
 V04.faktura_beleg_pos_id,
 V01.mandant_id,
 V01.flw_art_id AS in_art_id,
 V01.werk_id,
 V01A.flw_vw_id AS in_vw_id,
 V01.absagegrund_id -- spart CROSS JOIN in MSI
,
 V04.verk_menge_einh_id AS verk_menge_faktura_einh_id,
 V04A.fakturaart_id -- spart CROSS JOIN in MSI
,
 V01.menge_auftrag_vme_kum,
 V01.menge_bes_bme_kum,
  CASE
  WHEN V01B.basismenge_einh_id = 'KG'
  THEN V01.menge_bes_bme_kum
  WHEN V01B.basismenge_einh_id = 'ST'
  THEN ROUND(CAST(V01.menge_bes_bme_kum * V01C.umrech_faktor AS NUMERIC), 6)
  ELSE NULL
  END AS menge_bes_bme_kum_kg,
   CASE
   WHEN V04A.fakturaart_id IN ('ZG04', 'Z504', 'ZFG1', 'ZFG2', 'ZFG3', 'ZFG4', 'ZFGI', 'ZFRE', 'ZFS1', 'ZG14', 'ZS14',
     'ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25', 'ZFG6')
   THEN - 1
   ELSE 1
   END * V04.menge_faktura_vkme AS menge_faktura_vkme,
   CASE
   WHEN V04A.fakturaart_id IN ('ZG04', 'Z504', 'ZFG1', 'ZFG2', 'ZFG3', 'ZFG4', 'ZFGI', 'ZFRE', 'ZFS1', 'ZG14', 'ZS14',
     'ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25', 'ZFG6')
   THEN - 1
   ELSE 1
   END * V04.menge_faktura_lme AS menge_faktura_lme,
     CASE
     WHEN V04A.fakturaart_id IN ('ZG04', 'Z504', 'ZFG1', 'ZFG2', 'ZFG3', 'ZFG4', 'ZFGI', 'ZFRE', 'ZFS1', 'ZG14', 'ZS14'
       , 'ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25', 'ZFG6')
     THEN - 1
     ELSE 1
     END * V04.gewicht_netto * v04c.zaehler / v04c.nenner AS gewicht_netto
FROM kfl_production_dbp_view.v_flw_kunde_auftrag_det AS V01
 LEFT JOIN kfl_production_dbp_view.v_flw_kunde_auftrag AS V01A ON V01.mandant_id = V01A.mandant_id AND V01.verkaufs_beleg_id
    = V01A.verkaufs_beleg_id -- war Inner Join, dann fallen aber DS ohne Auftrag raus

 LEFT JOIN kfl_production_dbp_view.v_flw_art AS V01B ON V01.mandant_id = V01B.mandant_id AND V01.flw_art_id = V01B.flw_art_id
   
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per AS V01C ON V01B.mandant_id = V01C.mandant_id AND V01B.flw_art_id
     = V01C.flw_art_id AND CASE
    WHEN V01B.basismenge_einh_id = 'ST'
    THEN 'KG'
    WHEN V01B.basismenge_einh_id = 'KG'
    THEN 'ST'
    ELSE NULL
    END = V01C.altnv_menge_einh_id
 FULL JOIN kfl_production_dbp_view.v_flw_besch_lief_det AS V02 ON V01.mandant_id = V02.mandant_id AND V01.verkaufs_beleg_id
     = V02.vorlage_beleg_id AND V01.verkaufs_beleg_pos_id = V02.vorlage_beleg_pos_id
 FULL JOIN kfl_production_dbp_view.v_flw_faktura_belegfluss AS V03 ON V02.mandant_id = V03.mandant_id AND V02.lief_beleg_id
     = V03.lief_beleg_id AND V02.lief_beleg_pos_id = V03.lief_beleg_pos_id
 FULL JOIN kfl_production_dbp_view.v_flw_besch_faktura_det AS V04 ON V03.mandant_id = V04.mandant_id AND V03.folge_beleg_id
     = V04.faktura_beleg_id AND V03.folge_beleg_pos_id = V04.faktura_beleg_pos_id
   -- war inner Join fallen DS ohne Faktura raus; Vorzeichen ueber Fakturaart ermitteln

 LEFT JOIN kfl_production_dbp_view.v_flw_besch_faktura AS V04A ON V04.mandant_id = V04A.mandant_id AND V04.faktura_beleg_id
    = V04A.faktura_beleg_id -- war inner Join fallen DS ohne Faktura raus; als Mat.filter und fuer Umrechnung

 LEFT JOIN kfl_production_dbp_view.v_flw_art AS V04B ON V04.mandant_id = V04B.mandant_id AND V04.flw_art_id = V04B.flw_art_id
   
 LEFT JOIN (SELECT V016A.mandant_id,
   V016A.system_id,
   V016A.altnv_menge_einh_id,
   V016A.flw_art_id,
   V016A.gew_einh_id,
   V016B.zaehler,
   V016B.nenner
  FROM kfl_production_dbp_view.v_flw_art_umrech_faktor_per AS V016A
   INNER JOIN kfl_production_dbp_view.v_flw_einheiten_umrechnung AS V016B ON V016A.gew_einh_id = V016B.einh_id) AS v04c
 ON V04.mandant_id = v04c.mandant_id AND V04B.flw_art_id = v04c.flw_art_id AND V04B.basismenge_einh_id = v04c.altnv_menge_einh_id
   -- zum testen
 -- AND v01d.dat_einteilung BETWEEN 1121001 AND 1121231
 -- AND  v04.faktura_beleg_id IS NOT NULL
;