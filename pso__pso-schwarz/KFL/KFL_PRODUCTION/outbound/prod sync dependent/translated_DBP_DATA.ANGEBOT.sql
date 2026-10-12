CREATE OR REPLACE TABLE kfl_production_dbp_data.angebot (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
angebot_nr STRING(50) NOT NULL OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'),
dat_angebot_gueltig_von DATE NOT NULL OPTIONS(description='Datum, ab dem das Angebot gültig ist.'),
dat_angebot_gueltig_bis DATE NOT NULL OPTIONS(description='Datum bis dahin das Angebot gültig ist'),
kjwo_ww INTEGER NOT NULL OPTIONS(description='Werbewoche im  Format JJJJWW.'),
angebot_name STRING(100) NOT NULL OPTIONS(description='Name des Angebotes'),
angebot_beschreibung_txt STRING(500) OPTIONS(description='Freitext zur weiteren beschreibung des Angebotes'),
angebot_status_id INTEGER NOT NULL OPTIONS(description='ID des Angebotsstatus'),
angebot_typ_cd STRING(10) OPTIONS(description='Alphanumerischer Code des Angebotstyp.'),
anz_angebot_limit INTEGER NOT NULL OPTIONS(description='Anzahl wie oft das Angebot maximal verwendet werden kann.'),
geschaeftsvorfall_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige ID eines Geschäftsvorfalls aus gv_id, z.Bsp. 01'),
hauptangebot_fg INTEGER NOT NULL
OPTIONS(description='Flag gibt an, ob es sich bei dem Angebot um das Hauptangebot handelt (1) oder nicht (0). Wird ein Artikel in den Märkten zu unterschiedlichen Aktionspreisen angeboten, werden die unterschiedlichen Anegbote einem Hauptangebot  zugeordnet.'),
hauptangebot_nr STRING(50)
OPTIONS(description='Numerische oder Alphanumerische Nummer des dazugehörigen Hauptangebotes.'),
bonuskauf_fg INTEGER NOT NULL
OPTIONS(description='Flag gibt an, ob es sich um einen Bonuskauf handelt (1) oder nicht (0).'),
bonuskauf_id STRING(20) COLLATE 'und:ci'
OPTIONS(description='Handelt es sich bei dem Angebot um einen Bonuskauf, eindeutige ID einer Bonuskaufaktion z.Bsp. 700 aus bbynr'),
konditionsart_id STRING(4)
OPTIONS(description='Handelt es sich bei dem Angebot um einen Bonuskauf, Eindeutiger Fachschlüssel der Konditionsart des Bonuskaufes.'),
aktion_id STRING(10) COLLATE 'und:ci'
OPTIONS(description='Handelt es sich bei dem Angebot um eine Aktion, eindeutige Kennung einer Aktion'),
bewart_id INTEGER
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
aktion_typ_id STRING(4)
OPTIONS(description='Handelt es sich bei dem Angebot um eine Aktion gibt der Typ die Art der Aktion an: KDN = Promotion erhaltbar wenn App verwendet wird; KDP = Promotion nur für einen gezielten Nutzerkreis erhaltbar (bspw. personalisiert); KDI = Promotion die bei einem externen Partner erworben wurde (bspw.Partner Coupon, SMP Coupon, Gutschein von Partner.'),
markt_version_txt STRING(500)
OPTIONS(description='Kodierte Information in Textform die aus einem generischen Namen, Länderkürzel und Zeitstempel an dem es angelegt wurde besteht.'),
anz_market_version INTEGER
OPTIONS(description='Anzahl gibt an, in wie vielen Märkten das Angebot mit dieser market_version verwendet wird.'),
transfer_status_id INTEGER NOT NULL
OPTIONS(description='ID des Transferstatus. Der Transferstatus gibt den aktuellen Stand der Übertragung an SAP Retail an, bspw.\""empfohlen\"",\""genehmigt\"",\""storniert\"", etc.'),
akzeptiert_fg INTEGER NOT NULL
OPTIONS(description='Flag gibt an, ob das Angebot akzeptiert ist. Akzeptiert bedeutet, dass es an SAP RET übertragen wird. (Vereinzelt Ausnahmen bei Bonuskauf möglich).'),
angebot_geloescht_fg INTEGER NOT NULL OPTIONS(description='Flag gibt an, ob das Angebot im Quellsystem gelöscht wurde.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, angebot_nr) NOT ENFORCED
)
OPTIONS(description='Stammtabelle für Angebote. Ein Angebot wird in den unterschiedlichen Werbekanälen beworben und in den Märkten für unterschiedliche Artikel umgesetzt.');