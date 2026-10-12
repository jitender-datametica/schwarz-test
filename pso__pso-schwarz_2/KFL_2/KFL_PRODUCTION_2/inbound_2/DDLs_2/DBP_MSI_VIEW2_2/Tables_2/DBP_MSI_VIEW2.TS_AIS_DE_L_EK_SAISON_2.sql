--==============================================================
-- Table: ts_ais_de_l_ek_saison_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_ais_de_l_ek_saison_2
   generated from Powerdesigner on Donnerstag, 1. Februar 2024 16:09:10
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW2.TS_AIS_DE_L_EK_SAISON_2 (
   ek_saison_id                        NUMBER(38,0)     NOT NULL COMMENT 'Cluster ID des zugehörigen Saisonclusters zum Artikel.',
   ek_saison_bez                       VARCHAR(200)     NOT NULL COMMENT 'Bezeichnung des Clusters.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_AIS_DE_L_EK_SAISON PRIMARY KEY (ek_saison_id) NOT ENFORCED
)  COMMENT = 'AIS DE - Lookup-Tabelle für Verkaufssaisons die vom EK für den EK definiert werden. Quelle: Excel und manuelle Pflege über MSTR Transaction Service.
             ACHTUNG: Diese Tabelle hier ist als Zischenlösung gedacht, bis der Prozess für den Umgang mit Transaction Service Tabellen, die Notwendigkeit Daten manuell ins DWH zu bringen, oder der Umgang mit nicht standardisierten geklärt ist.';
