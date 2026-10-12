--==============================================================
-- Table: angebot
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: angebot
   generated from Powerdesigner on Donnerstag, 6. März 2025 17:55:24
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANGEBOT (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   angebot_nr                          VARCHAR(50)      NOT NULL COMMENT 'Numerische oder Alphanumerische Nummer des Angebots',
   dat_angebot_gueltig_von             DATE             NOT NULL COMMENT 'Datum, ab dem das Angebot gültig ist.',
   dat_angebot_gueltig_bis             DATE             NOT NULL COMMENT 'Datum bis dahin das Angebot gültig ist',
   kjwo_ww                             INTEGER     NOT NULL COMMENT 'Werbewoche im  Format JJJJWW.',
   angebot_name                        VARCHAR(100)     NOT NULL COMMENT 'Name des Angebotes',
   angebot_beschreibung_txt            VARCHAR(500)     COMMENT 'Freitext zur weiteren beschreibung des Angebotes',
   angebot_status_id                   INTEGER     NOT NULL COMMENT 'ID des Angebotsstatus',
   angebot_typ_cd                      VARCHAR(10)      COMMENT 'Alphanumerischer Code des Angebotstyp.',
   anz_angebot_limit                   INTEGER     NOT NULL COMMENT 'Anzahl wie oft das Angebot maximal verwendet werden kann.',
   geschaeftsvorfall_id                VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID eines Geschäftsvorfalls aus gv_id, z.Bsp. 01',
   hauptangebot_fg                     INTEGER     NOT NULL COMMENT 'Flag gibt an, ob es sich bei dem Angebot um das Hauptangebot handelt (1) oder nicht (0). Wird ein Artikel in den Märkten zu unterschiedlichen Aktionspreisen angeboten, werden die unterschiedlichen Anegbote einem Hauptangebot  zugeordnet.',
   hauptangebot_nr                     VARCHAR(50)      COMMENT 'Numerische oder Alphanumerische Nummer des dazugehörigen Hauptangebotes.',
   bonuskauf_fg                        INTEGER     NOT NULL COMMENT 'Flag gibt an, ob es sich um einen Bonuskauf handelt (1) oder nicht (0).',
   bonuskauf_id                        VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Handelt es sich bei dem Angebot um einen Bonuskauf, eindeutige ID einer Bonuskaufaktion z.Bsp. 700 aus bbynr',
   konditionsart_id                    VARCHAR(4)       COMMENT 'Handelt es sich bei dem Angebot um einen Bonuskauf, Eindeutiger Fachschlüssel der Konditionsart des Bonuskaufes.',
   aktion_id                           VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Handelt es sich bei dem Angebot um eine Aktion, eindeutige Kennung einer Aktion',
   bewart_id                           INTEGER     COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
   aktion_typ_id                       VARCHAR(4)       COMMENT 'Handelt es sich bei dem Angebot um eine Aktion gibt der Typ die Art der Aktion an: KDN = Promotion erhaltbar wenn App verwendet wird; KDP = Promotion nur für einen gezielten Nutzerkreis erhaltbar (bspw. personalisiert); KDI = ????',
   markt_version_txt                   VARCHAR(500)     COMMENT 'Kodierte Information in Textform die aus einem generischen Namen, Länderkürzel und Zeitstempel an dem es angelegt wurde besteht.',
   anz_market_version                  INTEGER     COMMENT 'Anzahl gibt an, in wie vielen Märkten das Angebot mit dieser market_version verwendet wird.',
   transfer_status_id                  INTEGER     NOT NULL COMMENT 'ID des Transferstatus. Der Transferstatus gibt den aktuellen Stand der Übertragung an SAP Retail an, bspw. "empfohlen", "genehmigt", "storniert", etc.',
   akzeptiert_fg                       INTEGER     NOT NULL COMMENT 'Flag gibt an, ob das Angebot akzeptiert ist. Akzeptiert bedeutet, dass es an SAP RET übertragen wird. (Vereinzelt Ausnahmen bei Bonuskauf möglich).',
   angebot_geloescht_fg                INTEGER     NOT NULL COMMENT 'Flag gibt an, ob das Angebot im Quellsystem gelöscht wurde.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANGEBOT PRIMARY KEY (mandant_id, angebot_nr) NOT ENFORCED
)  COMMENT = 'Stammtabelle für Angebote. Ein Angebot wird in den unterschiedlichen Werbekanälen beworben und in den Märkten für unterschiedliche Artikel umgesetzt.';
