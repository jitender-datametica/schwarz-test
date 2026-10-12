CREATE OR REPLACE VIEW kfl_production_dbp_view.v_angebot_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'), angebot_nr
OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'), dat_angebot_gueltig_von
OPTIONS(description='Datum, ab dem das Angebot_1 gültig ist.'), dat_angebot_gueltig_bis
OPTIONS(description='Datum bis dahin das Angebot_1 gültig ist'), kjwo_ww
OPTIONS(description='Werbewoche im  Format JJJJWW.'), angebot_name OPTIONS(description='Name des Angebotes'),
angebot_beschreibung_txt OPTIONS(description='Freitext zur weiteren beschreibung des Angebotes'), angebot_status_id
OPTIONS(description='ID des Angebotsstatus'), angebot_typ_cd
OPTIONS(description='Alphanumerischer Code des Angebotstyp.'), anz_angebot_limit
OPTIONS(description='Anzahl wie oft das Angebot_1 maximal verwendet werden kann.'), geschaeftsvorfall_id
OPTIONS(description='Eindeutige ID eines Geschäftsvorfalls aus gv_id, z.Bsp. 01'), hauptangebot_fg
OPTIONS(description='Flag gibt an, ob es sich bei dem Angebot_1 um das Hauptangebot handelt (1) oder nicht (0). Wird ein Artikel_1 in den Märkten zu unterschiedlichen Aktionspreisen angeboten, werden die unterschiedlichen Anegbote einem Hauptangebot  zugeordnet.'),
hauptangebot_nr OPTIONS(description='Numerische oder Alphanumerische Nummer des dazugehörigen Hauptangebotes.'),
bonuskauf_fg OPTIONS(description='Flag gibt an, ob es sich um einen Bonuskauf handelt (1) oder nicht (0).'),
bonuskauf_id
OPTIONS(description='Handelt es sich bei dem Angebot_1 um einen Bonuskauf, eindeutige ID einer Bonuskaufaktion z.Bsp. 700 aus bbynr'),
konditionsart_id
OPTIONS(description='Handelt es sich bei dem Angebot_1 um einen Bonuskauf, Eindeutiger Fachschlüssel der Konditionsart des Bonuskaufes.'),
aktion_id OPTIONS(description='Handelt es sich bei dem Angebot_1 um eine_1 Aktion_1, eindeutige Kennung einer Aktion_1'),
bewart_id
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
aktion_typ_id
OPTIONS(description='Handelt es sich bei dem Angebot_1 um eine_1 Aktion_1 gibt der Typ die Art_1 der Aktion_1 an: KDN = Promotion erhaltbar wenn App verwendet wird; KDP = Promotion nur für einen gezielten Nutzerkreis erhaltbar (bspw. personalisiert); KDI = Promotion die bei einem externen Partner erworben wurde (bspw.Partner Coupon, SMP Coupon, Gutschein_1 von Partner.'),
markt_version_txt
OPTIONS(description='Kodierte Information in Textform die aus einem generischen Namen, Länderkürzel und Zeitstempel an dem es angelegt wurde besteht.'),
anz_market_version
OPTIONS(description='Anzahl gibt an, in wie vielen Märkten das Angebot_1 mit dieser market_version verwendet wird.'),
transfer_status_id
OPTIONS(description='ID des Transferstatus. Der Transferstatus gibt den aktuellen Stand der Übertragung an SAP Retail an, bspw.\""empfohlen\"",\""genehmigt\"",\""storniert\"", etc.'),
akzeptiert_fg
OPTIONS(description='Flag gibt an, ob das Angebot_1 akzeptiert ist. Akzeptiert bedeutet, dass es an SAP RET übertragen wird. (Vereinzelt Ausnahmen bei Bonuskauf möglich).'),
angebot_geloescht_fg OPTIONS(description='Flag gibt an, ob das Angebot_1 im Quellsystem gelöscht wurde.')) AS SELECT
 mandant_id,
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
FROM kfl_production_dbp_data.angebot_1;