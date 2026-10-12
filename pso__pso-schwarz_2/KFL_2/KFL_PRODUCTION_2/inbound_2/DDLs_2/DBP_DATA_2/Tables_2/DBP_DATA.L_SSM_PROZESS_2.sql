--==============================================================
-- Table: l_ssm_prozess_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_ssm_prozess_2
   generated from Powerdesigner on Montag, 14. August 2023 14:55:07
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_SSM_PROZESS_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   ssm_prozess_id                      NUMBER(38,0)     NOT NULL COMMENT 'ID des Prozesses',
   ssm_aufwand_typ_id                  NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'ID des Aufwandstyp (z.B. Aufgabe, Minimal, Dynamisch, etc.)',
   wup_abt_id                          NUMBER(38,0)     COMMENT 'ID der Abteilung innerhalb eines Marktes',
   treiber_id                          NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID des Sollstunden-Modell-Treiber (Einflussgrößen auf den Personalaufwand /Tätigkeit des Marktmitarbeiter)',
   dat_von                             DATE             COMMENT 'Datum im Format JJJJ-MM_2-TT',
   dat_bis                             DATE             COMMENT 'Datum im Format JJJJ-MM_2-TT',
   ssm_prozess_bez                     VARCHAR(80)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung des Prozesses (z.B. Warenverräumung, etc.)',
   dayforce_xrefcode                   VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Für den Export in externes Tool DayForce. Mapping Prozess zu XrefCode per Vorgabe durch DayForce',
   dayforce_xrefcode_de                VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Für den Export in externes Tool DayForce. Mapping Prozess zu XrefCode per Vorgabe durch DayForce',
   dayforce_minimal_mapping            NUMBER(38,0)     COMMENT 'Kennzeichnung Minimalprozess (z.B. Minimalbesetzung an Frischetheke) für Berechnung Planauslastung',
   oeffnung_laden_theken_fg            NUMBER(38,0)     COMMENT 'Bedeutung: Prozess richtet sich an  0 = Ladenöffnung, 1 = an Thekenöffnung',
   rundung_typ_kz                      NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Kennzeichen gibt an auf welcher Zeitebene gerundet wird. 0=Stunde, 1=15 min; 2=30min',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_SSM_PROZESS PRIMARY KEY (mandant_id, ssm_prozess_id) NOT ENFORCED
)  COMMENT = 'VIS - Sollstundenmodell - Lookuptabelle für die Prozesse';
