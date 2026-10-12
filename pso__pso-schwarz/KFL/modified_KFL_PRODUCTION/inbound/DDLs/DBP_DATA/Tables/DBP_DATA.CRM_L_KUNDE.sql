--==============================================================
-- Table: crm_l_kunde
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_kunde
   generated from Powerdesigner on Montag, 15. September 2025 15:03:48
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_L_KUNDE (
   crm_kunde_id                        VARCHAR(36)      NOT NULL COMMENT 'CRM-interne ID des Kunden',
   zeit_registrierung                  TIMESTAMP_LTZ(9) COMMENT 'Registrierungsdatum des Kunden',
   zeit_abmeldung                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Abmeldedatum des Kunden - ist immer gefüllt',
   kundentyp_cd                        VARCHAR(60)      NOT NULL COMMENT 'Code des Kundentypes.',
   kundenherkunft_cd                   VARCHAR(50)      NOT NULL COMMENT 'Code der Kundenherkunft ( example values: K-App,Marktplatz,Mobiles Registrierungsformular,kappAndroid,kappIOS,marketplaceLoyalty,sscTerminal,sscWeb,Web).',
   gender_id                           INTEGER     NOT NULL DEFAULT -1 COMMENT 'ID für das Geschlecht des Kunden',
   geburtsjahr                         INTEGER     NOT NULL DEFAULT 0 COMMENT 'Geburtsjahr des Kunden ( example value: 08.08.1988 ) ',
   kunde_statusgrund_id                INTEGER     NOT NULL DEFAULT -9999 COMMENT 'Statusgrund-ID des Kunden (liefert Information darüber, wieso der Kunde aktiv oder inaktiv ist (aktiv_fg))',
   strasse                             VARCHAR(100)     NOT NULL DEFAULT '0' COMMENT 'Straße in welcher der Kunde wohnt.',
   wohnort                             VARCHAR(30)      NOT NULL DEFAULT '0' COMMENT 'Ort in welchem der Kunde wohnt',
   plz                                 VARCHAR(10)      NOT NULL DEFAULT '0' COMMENT 'Postleitzahl (PLZ) des Ortes in welchem der Kunde wohnt',
   kunde_mandant_id                    INTEGER     NOT NULL COMMENT 'Land des Kundenwohnorts',
   vorzugsfiliale_wup_id               INTEGER     NOT NULL COMMENT 'ID der präferierten Filiale',
   vorzugsfiliale_mandant_id           INTEGER     COMMENT 'Land der präferierten Filiale',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   merge_fg                            INTEGER     NOT NULL DEFAULT -1 COMMENT 'Flag, das anzeigt ob dieser Kontakt mit einem anderen Kontakt gemerged/zusammengeführt wurde',
   registrierungsfiliale_wup_id        INTEGER     NOT NULL DEFAULT 0 COMMENT 'Filiale in der sich der Kunde registriert hat. Bei physischen Kunden (Anmeldung in der Filiale) kommt diese Information aus dem "mauellen" Registrierungsprozess. Bei digitalen Kunden (Anmeldung über App) kommt diese Information aus der App.',
   registrierungsfiliale_mandant_id    INTEGER     NOT NULL DEFAULT -1 COMMENT 'Mandant ID zur Registrierungsfiliale',
   registrierungsfiliale_nb_id         INTEGER     NOT NULL DEFAULT -1 COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer. Gehört zur registrierten Registrierungsfiliale.',
   aktiv_fg                            INTEGER     NOT NULL DEFAULT 0 COMMENT 'Flag das anzeigt, ob der Kunde aktiv oder inaktiv ist',
   haushaltsgroesse                    VARCHAR(20)      COMMENT 'Haushaltsgröße',
   beschaeftigung_status_id            INTEGER     DEFAULT -1 COMMENT 'Beschäftigungsstatus, sagt aus ob Kunde bspw. Schüler/in, Hausmann/frau, Angestellte/r,... ist',
   crm_cidaas_id                       VARCHAR(120)     NOT NULL DEFAULT '-9999' COMMENT 'MS Dynamics - contact.kl_keycloakid -
            Meldet sich Person unter Verwendung derselben Mailadresse/Mobilnummer an zwei verschiedenen K Card Programmen an, bekommt sie zwei separate Kontakte (crm_kunde_id), Konten (crm_konto_id) und separate Karten (kundenkarte_id). Beide Kontakte werden jedoch mit derselben Cidaas ID versehen.  ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_L_KUNDE PRIMARY KEY (crm_kunde_id) NOT ENFORCED
)  COMMENT = 'EK_KUN - Cosmos DB CRM - CRM - Entität "Customer" (Kundenstamm) ';
