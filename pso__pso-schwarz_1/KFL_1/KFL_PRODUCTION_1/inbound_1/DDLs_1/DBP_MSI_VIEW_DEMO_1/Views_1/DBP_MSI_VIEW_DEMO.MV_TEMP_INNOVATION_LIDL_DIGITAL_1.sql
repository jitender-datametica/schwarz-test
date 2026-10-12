CREATE OR REPLACE VIEW dbp_msi_view_demo.mv_temp_innovation_lidl_digital_1
(
  Innovationsthema
, Sparte
, Bereich
, Innovationsbeschreibung
, Prozessoptimierung
, Kosteneinsparung
, Umsatzsteigerung
, Kundenbindung
, Differenzierung
, Neutralisierung
, Qualitaetsverbesserung
, Mitarbeitermotivation
, KuenstlicheIntelligenz
, Prozessautomatisierung
, BigData_KI
, Blockchain
, Digitale_Oekosysteme
, CloudComputing
, CyberSicherheit
, Robotik
, VR
, IOT
, weitereTechnologien
, akt_Reifegrad
, UKri_Diff
, UKri_nDiff
, nUKri_Diff
, nUKri_nDiff
, Meilenstein1
, Meilenstein1_Ende
, Meilenstein2
, Meilenstein2_Ende
, Meilenstein3
, Meilenstein3_Ende
, Meilenstein4
, Meilenstein4_Ende
, Meilenstein5
, Meilenstein5_Ende
, InternerAufwand
, Inv_Abteilungen
, ExternePartner
, Kosten_externe_Partner
, Alibaba
, Apple
, Baidu
, Cisco
, Facebook
, Fujitsu
, Google
, Samsung
, Huawei
, Ibm
, Microsoft
, Oracle
, Panasonic
, Salesforce
, SAP
, Siemens
, Tencent
, Toshiba
, WeiterePartner
, Kommentar
)

AS

SELECT 
 Innovationsthema
, Sparte  
, Bereich  
, Innovationsbeschreibung
, Cast (Prozessoptimierung AS BYTEINT) AS Prozessoptimierung
, Cast (Kosteneinsparung AS BYTEINT) AS Kosteneinsparung
, Cast (Umsatzsteigerung AS BYTEINT) AS Umsatzsteigerung
, Cast (Kundenbindung AS BYTEINT) AS Kundenbindung
, Cast (Differenzierung AS BYTEINT) AS Differenzierung
, Cast (Neutralisierung AS BYTEINT) AS Neutralisierung
, Cast (Qualitaetsverbesserung AS BYTEINT) AS Qualitaetsverbesserung
, Cast (Mitarbeitermotivation AS BYTEINT) AS Mitarbeitermotivation
, Cast (KuenstlicheIntelligenz AS BYTEINT) AS KuenstlicheIntelligenz
, Cast (Prozessautomatisierung AS BYTEINT) AS Prozessautomatisierung
, Cast (BigData_KI AS BYTEINT) AS BigData_KI
, Cast (Blockchain AS BYTEINT) AS Blockchain
, Cast (Digitale_Oekosysteme AS BYTEINT) AS Digitale_Oekosysteme
, Cast (CloudComputing AS BYTEINT) AS CloudComputing
, Cast (CyberSicherheit AS BYTEINT) AS CyberSicherheit
, Cast (Robotik AS BYTEINT) AS Robotik
, Cast (VR AS BYTEINT) AS VR
, Cast (IOT AS BYTEINT) AS IOT
, Cast (weitereTechnologien AS BYTEINT) AS weitereTechnologien
, akt_Reifegrad  
, Cast (UKri_Diff AS BYTEINT) AS UKri_Diff
, Cast (UKri_nDiff AS BYTEINT) AS UKri_nDiff
, Cast (nUKri_Diff AS BYTEINT) AS nUKri_Diff
, Cast (nUKri_nDiff AS BYTEINT) AS nUKri_nDiff
, Meilenstein1  
, Meilenstein1_Ende  
, Meilenstein2  
, Meilenstein2_Ende  
, Meilenstein3  
, Meilenstein3_Ende  
, Meilenstein4  
, Meilenstein4_Ende  
, Meilenstein5  
, Meilenstein5_Ende  
, InternerAufwand  
, Inv_Abteilungen  
, ExternePartner  
, Kosten_externe_Partner  
, Cast (Alibaba AS BYTEINT) AS Alibaba
, Cast (Apple AS BYTEINT) AS Apple
, Cast (Baidu AS BYTEINT) AS Baidu
, Cast (Cisco AS BYTEINT) AS Cisco
, Cast (Facebook AS BYTEINT) AS Facebook
, Cast (Fujitsu AS BYTEINT) AS Fujitsu
, Cast (Google AS BYTEINT) AS Google
, Cast (Samsung AS BYTEINT) AS Samsung
, Cast (Huawei AS BYTEINT) AS Huawei
, Cast (Ibm_ AS BYTEINT) AS Ibm
, Cast (Microsoft AS BYTEINT) AS Microsoft
, Cast (Oracle AS BYTEINT) AS Oracle
, Cast (Panasonic AS BYTEINT) AS Panasonic
, Cast (Salesforce AS BYTEINT) AS Salesforce
, Cast (SAP AS BYTEINT) AS SAP
, Cast (Siemens AS BYTEINT) AS Siemens
, Cast (Tencent AS BYTEINT) AS Tencent
, Cast (Toshiba AS BYTEINT) AS Toshiba
, Cast (WeiterePartner AS BYTEINT) AS WeiterePartner
, Kommentar
FROM dbp_msi_v_view.v_temp_innovation_lidl_digital_1;