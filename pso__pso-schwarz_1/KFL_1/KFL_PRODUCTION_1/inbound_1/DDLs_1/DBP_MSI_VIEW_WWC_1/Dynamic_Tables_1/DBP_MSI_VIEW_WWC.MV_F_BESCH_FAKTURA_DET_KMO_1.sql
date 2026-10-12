CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.MV_F_BESCH_FAKTURA_DET_KMO_1
--17.03.2014 twie: Fakturabelege KMO
--14.04.2014 twie: Steuersatz/typ aufgenommen, Dummy_1 für aktion_id
--10.06.2014 twie: wegen BED die Vorzeichenlogik bei menge_faktura_bme und menge_faktura_lme entfernt, dafür bei betrag_mwst rein
--02.07.2014 twie: aktion_fg auf 1 setzten bei aktion_id -1. (-1 wird von BED bei nicht eindeutiger aktion_id gesetzt, ist aber eine_1 Aktion. Dummy_1 bei keiner Aktion_1 ist dagegen die 0.)
--03.07.2014 twie: Für Pfand Polen aus lagerbew_det_1 (erkennbar an Fakturaart Z41, Z42) das Vorzeichen bei allen Fakten drehen
--14.03.2016 srom: Bisher hat ein Artikel_1, der nicht in Aktion_1 war, eine_1 "0" in der Spalte aktion_id. Nach der Änderung wird es blank (' ') sein.
--05.08.2016 srom: AP0009976 - Werbeabschriften, Erweiterung um die Aktionsdaten, damit das auf Ebene Markt | Artikel_1 | Aktion_1 berechnet wird
--22.09.2016 mrau: AP0009976 - Werbeabschriften: Erweiterung besch_faktura_det_kmo_1 um die Spalten vk_aktion_brutto und vk_vor_aktion_brutto
--27.09.2016 mrau: AP0009976 - Werbeabschriften - Entfernen JOIN auf dbp_view.v_aktion_1  - wird nicht benötigt.
--06.10.2016 mrau: INC0898229 Left JOIN auf mwst_per_1 wird wg. Pfandartikel benötigt
--01.08.2018 srom: AP0011752 - Expansion Moldau, Umstellung auf mandant_id <> 1
--30.04.2019 ssch1303: SPEC0054497 LEFT JOIN auf  besch_faktura_kondit_1
--18.11.2019 cbru1709: SPEC0066030 Erweiterung des vorherigen Joins um Mandant_1 7 und Konditionsschlüssel für Mandant_1 2
--17.01.2020 lwei0109: ergänzung zur SPEC0066030, soll Mandant_1 2 jetzt doch die gleichen Konditionsschlüssel wie mandent 7 haben, daher habe ich die filterung für Mandant_1 2 entfernt und bei Mandant_1=7 ein Mandantn in (2,7) gemacht.
--03.03.2020 lwei0109: SPEC0072217, Mandant_1 4 soll die gleichen Konditionsschlüssel wie mandent 2 und 7 haben.
--20.04.2020 srom0404: AP0060322, SPEC0075395, Erweiterung where kondition_schl_id RB19 und alle Schlüssel auch für Land_1 Polen
--20.08.2020 srom0404: AP0068810, SPEC0085813, Erweiterung kondition_schl_id um HR
--29.01.2021 lwei0109: AP0068810, SPEC0085813, SK noch ergänzt
--04.02.2021 lwei0109: AP0068810, SPEC0085813, PL noch ergänzt
--11.08.2021 richternic: AP0087722 SPEC0122464 MD Konditionsart ergaenzen
(
mandant_id
,faktura_beleg_id
,faktura_beleg_pos_id
,fakturaart_id
,dat_faktura_sap
,fktyp
,wrg_id
,mandant_id_empfaenger
,art_id
,wup_id
,nb_id
,retoure_pos_kz
,basismenge_einh_id
,verk_menge_einh_id
,steuer_typ_id
,sap_steuer_id
,kurrf
,aktion_id
,aktion_fg
,anz_kondition_schl_id
,timestamp_faktura
,vorzeichen_menge
,menge_faktura_bme
,menge_faktura_lme
,betrag_verrechnung
,betrag_netto
,zwsum_1_betrag
,betrag_mwst
,vk_aktion_netto_faktura
,vk_vor_aktion_netto_faktura
,abschriftbetrag_netto_faktura
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC 
AS
--NSR2941808 Modifizierung WWC-Views - Sushi Umsätze
--04.07.2023, SPEC0205969, prescherad: Ausfiltern Shop in Shop
--20.11.2023, SPEC0224904, prescherad: Ausfiltern_Eloading
--22.10.2024, SPEC0276971, prescherad: Ausfiltern WGI969006 für CZ und DE
--19.11.2024, SPEC0281741, prescherad: WGI969006 Filter für CZ entfernen
--14.02.2025, SPEC0282957, prescherad: Ausfiltern_Eloading Alle Mandanten außer DE
SELECT
v01.mandant_id,
v01.faktura_beleg_id,
v02.faktura_beleg_pos_id,
v01.fakturaart_id,
v01.dat_faktura_sap,
v01.fktyp,
v01.wrg_id,
v01.mandant_id_empfaenger,
v02.art_id,
v02.wup_id,
v02.nb_id,
v02.retoure_pos_kz,
v02.basismenge_einh_id,
v02.verk_menge_einh_id,
v02.steuer_typ_id,
v02.sap_mwst_id AS sap_steuer_id,
v01.kurrf,
Coalesce(v02.aktion_id, '') AS aktion_id,
CASE WHEN v02.aktion_id <> '' OR v04.anz_kondition_schl_id > 1 THEN 1 ELSE 0 END AS aktion_fg,
v04.anz_kondition_schl_id,
--(TO_TIMESTAMP(TO_CHAR(v01.dat_erstellung, 'YYYY/MM_1/DD') ||Coalesce(CAST(v01.zeit_erstellung AS CHAR(8)),'00:00:00'), 'YYYY/MM_1/DD HH:MI:SS')) AS timestamp_faktura,
timestamp_from_parts(v01.dat_erstellung,v01.zeit_erstellung) AS timestamp_faktura,
CASE WHEN v02.retoure_pos_kz='X' THEN -1
ELSE 1
END AS vorzeichen_menge,
CASE WHEN  v01.fakturaart_id IN ('Z41','Z42') THEN v02.menge_faktura_bme * -1 ELSE  v02.menge_faktura_bme END AS  menge_faktura_bme,
CASE WHEN  v01.fakturaart_id IN ('Z41','Z42') THEN v02.menge_faktura_lme * -1 ELSE  v02.menge_faktura_lme END AS menge_faktura_lme,
CASE WHEN  v01.fakturaart_id IN ('Z41','Z42') THEN v02.betrag_verrechnung * -1 ELSE v02.betrag_verrechnung END AS betrag_verrechnung,
CASE WHEN  v01.fakturaart_id IN ('Z41','Z42') THEN v02.betrag_netto * -1 ELSE v02.betrag_netto END AS betrag_netto,
CASE WHEN  v01.fakturaart_id IN ('Z41','Z42') THEN v02.zwsum_1_betrag * -1 ELSE v02.zwsum_1_betrag END AS zwsum_1_betrag,
CASE WHEN  v01.fakturaart_id IN ('Z41','Z42') THEN v02.betrag_mwst * vorzeichen_menge * -1 ELSE v02.betrag_mwst * vorzeichen_menge END AS betrag_mwst,

--Doppelcast um TD Verhalten zu simulieren
CAST((v02.vk_aktion_brutto     / (1.00 + (CAST((v03.mwst / 100.00) AS NUMBER(38,2))))) AS NUMBER(38,2)) AS vk_aktion_netto_faktura,
CAST((v02.vk_vor_aktion_brutto / (1.00 + (CAST((v03.mwst / 100.00) AS NUMBER(38,2))))) AS NUMBER(38,2)) AS vk_vor_aktion_netto_faktura,

(vk_vor_aktion_netto_faktura - vk_aktion_netto_faktura) * menge_faktura_bme * (CASE WHEN aktion_fg = 1 THEN 1 END) AS abschriftbetrag_netto_faktura
FROM dbp_view.v_besch_faktura_kmo_1 v01 

--prescherad: Filtern auf letzen 2 Jahre und laufendes
JOIN dbp_view.v_tag_1 v06
ON v01.dat_faktura_sap=v06.dat
AND akt_kj BETWEEN -2 AND 0

JOIN dbp_view.v_besch_faktura_det_kmo_1 v02 
ON v01.mandant_id       = v02.mandant_id
AND v01.faktura_beleg_id = v02.faktura_beleg_id
AND v01.dat_faktura_sap  = v02.dat_faktura_sap  

--Suhsi RO ausfiltern
INNER JOIN DBP_VIEW.V_art_wg_zu_per_1 V05
ON v02.Art_ID=v05.art_id
AND v02.mandant_id = v05.mandant_id
   -- Wenn nicht Mandant_1 1,7 dann alles   
   AND (v05.MANDANT_ID NOT IN (1,7)
      -- wenn  Mandant_1 1,7 dann  kein Sushi/Shop in Shop 
      OR (V05.MANDANT_ID IN (1,7) AND TO_VARCHAR(V05.wg_id,'FM000')|| TO_VARCHAR(V05.wug_id,'FM000') != '969006' )
   )
   -- Wenn nicht Mandant_1 7 dann alles   
   AND (v05.MANDANT_ID != 7
   -- Wenn  Mandant_1 7 dann kein Pfand 
      OR v05.MANDANT_ID = 7 AND TO_VARCHAR(v05.wg_id,'FM000') !='980')

--Ausfiltern Shop in Shop
AND V05.wg_id!=961
--Ausfiltern E-Loading alle Mandaten ungleich 1
AND (v05.MANDANT_ID NOT IN (2,3,4,5,6,7,8)
     -- wenn  Mandant_1 ungleich 1 dann ohne E-loading 
      OR (v05.MANDANT_ID IN  (2,3,4,5,6,7,8) AND TO_VARCHAR(V05.wg_id,'FM000')|| TO_VARCHAR(v05.wug_id,'FM000') NOT IN ('969001','969002','969003','969004'))  
   )       
AND V05.arthiertyp_id = 2
AND V05.dat_bis = '9999-12-31'

LEFT JOIN (SELECT
mandant_id,
faktura_beleg_id,
faktura_beleg_pos_id,
Count(kondition_schl_id) AS anz_kondition_schl_id
FROM dbp_view.v_besch_faktura_kondit_1
           
      WHERE (
      (kondition_schl_id IN ('PN10','ZNR','ZK03','ZK01','ZK02','ZBON','ZBOV','ZWG1','Z3F2','ZAR1','ZAR2','ZM05','ZHM','ZMW','ZBAR','ZBAP','ZMP','RB19') AND mandant_id IN (2,4,7)) 
             
     OR (kondition_schl_id IN ('PN10','ZNR','ZK03','ZK01','ZK02','ZBON','ZBOV','ZWG1','Z3F2','ZAR1','ZM05','ZHM','ZMW','ZBAR','ZMP','ZMPP','ZM06') AND mandant_id IN (5,6))

     OR (kondition_schl_id IN ('PN10','ZNR','ZK03','ZK01','ZK02','ZBON','ZBOV','ZWG1','Z3F2','ZAR1','ZAR2','ZM05','ZHM','ZMW','ZBAR','ZBAP','ZMP','RB19','ZMPP') AND mandant_id = 3 )
     OR (kondition_schl_id IN ('PN10','ZNR','ZK03','ZK01','ZK02','ZBON','ZBOV','ZWG1','Z3F2','ZAR1','ZM05','ZHM','ZMW','ZBAR','ZBAP','ZMP','ZMPP','ZM06') AND mandant_id = 8 )
                 )
     GROUP BY mandant_id
                   ,faktura_beleg_id
                   ,faktura_beleg_pos_id
           ) v04

  ON v01.mandant_id           = v04.mandant_id
 AND v01.faktura_beleg_id     = v04.faktura_beleg_id
 AND v02.faktura_beleg_pos_id = v04.faktura_beleg_pos_id


LEFT JOIN dbp_view.v_mwst_per_1 v03
ON v02.mandant_id  = v03.mandant_id
AND v02.sap_mwst_id = v03.sap_mwst_id
AND v02.dat_faktura_sap BETWEEN v03.dat_von AND v03.dat_bis 

WHERE v01.mandant_id <> 1;