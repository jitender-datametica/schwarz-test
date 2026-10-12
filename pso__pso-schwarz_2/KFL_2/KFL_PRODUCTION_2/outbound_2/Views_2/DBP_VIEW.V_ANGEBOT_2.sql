CREATE OR REPLACE VIEW kfl_production_dbp_view.v_angebot_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'), angebot_nr
OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'), dat_angebot_gueltig_von
OPTIONS(description='Datum, ab dem das Angebot_2 gültig ist.'), dat_angebot_gueltig_bis
OPTIONS(description='Datum bis dahin das Angebot_2 gültig ist'), kjwo_ww
OPTIONS(description='Werbewoche im  Format JJJJWW.'), angebot_name OPTIONS(description='Name des Angebotes'),
angebot_beschreibung_txt OPTIONS(description='Freitext zur weiteren beschreibung des Angebotes'), angebot_status_id
OPTIONS(description='ID des Angebotsstatus'), angebot_typ_cd
OPTIONS(description='Alphanumerischer Code des Angebotstyp.'), anz_angebot_limit
OPTIONS(description='Anzahl wie oft das Angebot_2 maximal verwendet werden kann.'), geschaeftsvorfall_id
OPTIONS(description='Eindeutige ID eines Geschäftsvorfalls aus gv_id, z.Bsp. 01'), hauptangebot_fg
OPTIONS(description='Flag gibt an, ob es sich bei dem Angebot_2 um das Hauptangebot handelt (1) oder nicht (0). Wird ein Artikel_2 in den Märkten zu unterschiedlichen Aktionspreisen angeboten, werden die unterschiedlichen Anegbote einem Hauptangebot  zugeordnet.'),
hauptangebot_nr OPTIONS(description='Numerische oder Alphanumerische Nummer des dazugehörigen Hauptangebotes.'),
bonuskauf_fg OPTIONS(description='Flag gibt an, ob es sich um einen Bonuskauf handelt (1) oder nicht (0).'),
bonuskauf_id
OPTIONS(description='Handelt es sich bei dem Angebot_2 um einen Bonuskauf, eindeutige ID einer Bonuskaufaktion z.Bsp. 700 aus bbynr'),
konditionsart_id
OPTIONS(description='Handelt es sich bei dem Angebot_2 um einen Bonuskauf, Eindeutiger Fachschlüssel der Konditionsart des Bonuskaufes.'),
aktion_id OPTIONS(description='Handelt es sich bei dem Angebot_2 um eine_2 Aktion_2, eindeutige Kennung einer Aktion_2'),
bewart_id
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
aktion_typ_id
OPTIONS(description='Handelt es sich bei dem Angebot_2 um eine_2 Aktion_2 gibt der Typ die Art_2 der Aktion_2 an: KDN = Promotion erhaltbar wenn App verwendet wird; KDP = Promotion nur für einen gezielten Nutzerkreis erhaltbar (bspw. personalisiert); KDI = ????'),
markt_version_txt
OPTIONS(description='Kodierte Information in Textform die aus einem generischen Namen, Länderkürzel und Zeitstempel an dem es angelegt wurde besteht.'),
anz_market_version
OPTIONS(description='Anzahl gibt an, in wie vielen Märkten das Angebot_2 mit dieser market_version verwendet wird.'),
transfer_status_id
OPTIONS(description='ID des Transferstatus. Der Transferstatus gibt den aktuellen Stand der Übertragung an SAP Retail an, bspw. "empfohlen", "genehmigt", "storniert", etc.'),
akzeptiert_fg
OPTIONS(description='Flag gibt an, ob das Angebot_2 akzeptiert ist. Akzeptiert bedeutet, dass es an SAP RET übertragen wird. (Vereinzelt Ausnahmen bei Bonuskauf möglich).'),
angebot_geloescht_fg OPTIONS(description='Flag gibt an, ob das Angebot_2 im Quellsystem gelöscht wurde.'))
OPTIONS(DESCRIPTION = `Stammtabelle für Angebote. Ein Angebot_2 wird in den unterschiedlichen Werbekanälen beworben und in den Märkten für unterschiedliche Artikel_2 umgesetzt.`)
AS SELECT mandant_id,
 angebot_nr,
 dat_angebot_gueltig_von,
 dat_angebot_gueltig_bis,
 kjwo_ww,
 angebot_name,
 angebot_beschreibung_txt,
 angebot_status_id,
 angebot_typ_cd,
 anz_angebot_limit,
 geschaeftsvorfall_id,
 hauptangebot_fg,
 hauptangebot_nr,
 bonuskauf_fg,
 bonuskauf_id,
 konditionsart_id,
 aktion_id,
 bewart_id,
 aktion_typ_id,
 markt_version_txt,
 anz_market_version,
 transfer_status_id,
 akzeptiert_fg,
 angebot_geloescht_fg
FROM kfl_production_dbp_data.angebot_2;