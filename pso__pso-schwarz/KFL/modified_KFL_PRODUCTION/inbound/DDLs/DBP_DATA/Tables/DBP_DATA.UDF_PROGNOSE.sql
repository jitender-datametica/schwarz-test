--==============================================================
-- Table: udf_prognose
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: udf_prognose
   generated from Powerdesigner on Dienstag, 27. Mai 2025 16:24:50
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.UDF_PROGNOSE CLUSTER BY (
     MANDANT_ID,
     DAT_PROGNOSELAUF,
     DAT 
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
   diagnose_id                         VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Diagnoseidentifikator (Regelwerk für die Prognose).',
   dat_prognoselauf                    DATE             NOT NULL COMMENT 'Datum des Prognoselaufs (ENTRY_DATE).',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT.',
   prognose_horizont                   INTEGER     NOT NULL COMMENT 'Prognosehorizont: für wie viele Tage gab es prognostizierte Mengen (wie viele Felder von QUANTITY_01 - bis QUANTITY_80 waren gefüllt).',
   menge_prognose_af                   NUMBER(29,3)     DEFAULT 0 COMMENT 'Aktionsfreier Bedarf in Basismengeneinheit.',
   menge_prognose_sa                   NUMBER(29,3)     DEFAULT 0 COMMENT 'Werbebedarf in Basismengeneinheit.',
   menge_prognose_gesteuert            NUMBER(29,3)     DEFAULT 0 COMMENT 'Manuell gesteuerte Prognose in Basismengeneinheit.',
   prognose_trennung_cd                VARCHAR(3)       COMMENT 'Eindeutige Kennzeichnung der übergeordneten Trennung der Prognosen auf Markt/Artikel/Tag-Ebene. Sie dient der Unterscheidung zwischen ungesteuerten und gesteuerten Prognosen, die aus PMR-Daten ermittelt und während der Beladung angereichert werden. Mögliche Werte sind AF (Aktionsfrei), SA (Sonderaktion) oder BBY (Bonusbuy/K-Card). Dies ist relevant, da zukünftig die Prognosetrennung nicht mehr über Angebots-IDs in SAP erfolgt, sondern über diese Attribut-Logik im DWH abgebildet wird.',
   prognose_feingliederung_id          INTEGER     COMMENT 'Eindeutige Kennzeichnung der weiteren, feineren Gliederung der Prognosen auf Markt/Artikel/Tag-Ebene, basierend auf der Logik der prognose_trennung_cd. Sie präzisiert die Prognose-Trennung und wird aus PMR-Daten ermittelt und während der Beladung angereichert. Mögliche Werte:
            -1= nicht definiert
            1= Nur Prospekt
            2= Prospekt + K-Card
            3= KDN-only
            4= KDP-only
            5= BBY KMO
            6= Prospekt + BBY KMO',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_UDF_PROGNOSE PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, diagnose_id, dat_prognoselauf, dat) NOT ENFORCED
)  COMMENT = 'SCM - Prognosewerte aus SAP UDF - Transparente Tabelle ZUDF_TS_DWH.
             Die Tabelle UDF_PROGNOSE enthält die durch das SAP-Quellsystem UDF berechneten Abverkaufsprognosen aller prognoserelevanten Artikel-Markt-Tag-Kombinationen.
             Die Prognoserelevanz definiert sich dabei über bestimmte Stammdaten-Konstellationen (wie z.B. Dispomerkmal und Postenkennzeichen).
             Die Prognosen werden mit jedem Prognoselauf (dat_prognoselauf) neu berechnet und stehen für einen Gültigkeitstag (dat) dadurch mehrfach zur Verfügung – hierbei wird stets der Wert für den aktuellsten Gültigkeitstag (dat) für die Ermittlung der Autodispo-Bestellmengen verwendet. Die Prognosen liegen sowohl für den aktionsfreien Bedarf (menge_prognose_af) als auch für den Werbebedarf (menge_prognose_sa) sowie inklusive manueller Prognosesteuerungen (menge_prognose_gesteuert) vor.';
