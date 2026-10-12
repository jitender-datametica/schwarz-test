CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_l_kunde_2 (crm_kunde_id
OPTIONS(description='CRM-interne ID des Kunden'), zeit_registrierung
OPTIONS(description='Registrierungsdatum des Kunden'), zeit_abmeldung
OPTIONS(description='Abmeldedatum des Kunden - ist immer gefüllt'), kundentyp_cd
OPTIONS(description='Code des Kundentypes.'), kundenherkunft_cd
OPTIONS(description='Code der Kundenherkunft ( example values: K-App,Marktplatz,Mobiles Registrierungsformular,kappAndroid,kappIOS,marketplaceLoyalty,sscTerminal,sscWeb,Web).'),
gender_id OPTIONS(description='ID für das Geschlecht des Kunden'), geburtsjahr
OPTIONS(description='Geburtsjahr des Kunden ( example value: 08.08.1988 ) '), kunde_statusgrund_id
OPTIONS(description='Statusgrund-ID des Kunden (liefert Information darüber, wieso der Kunde aktiv oder inaktiv ist (aktiv_fg))'),
strasse OPTIONS(description='Straße in welcher der Kunde wohnt'), wohnort
OPTIONS(description='Ort in welchem der Kunde wohnt'), plz
OPTIONS(description='Postleitzahl (PLZ) des Ortes in welchem der Kunde wohnt'), kunde_mandant_id
OPTIONS(description='Land_2 des Kundenwohnorts'), geo_gitter_100_nr
OPTIONS(description='Geografischen Koordinaten des Gitters (GEO-Gitternetz ) in der Größe 100*100, zu dem die geokodierte Adressinformation ( Längen- und Breitengrad) der Kunde gehört. Ein Geo-Gitternetz ist ein Raster aus Quadrate zur präzisen Positionsbestimmung auf der Erde.Räumliche Analysen sind nur erlaubt, wenn innerhalb eines GEO-Gitternetz mindestens 7 aktuell registrierte Kunden leben.Ist das nicht der Fall, das Gitter erhält einen Null-Value.'),
geo_gitter_500_nr
OPTIONS(description='Geografischen Koordinaten des Gitters (GEO-Gitternetz ) in der Größe 500*500, zu dem die geokodierte Adressinformation ( Längen- und Breitengrad) der Kunde gehört. Ein Geo-Gitternetz ist ein Raster aus Quadrate zur präzisen Positionsbestimmung auf der Erde.Räumliche Analysen sind nur erlaubt, wenn innerhalb eines GEO-Gitternetz mindestens 7 aktuell registrierte Kunden leben.Ist das nicht der Fall, das Gitter erhält einen Null-Value.'),
geo_gitter_1000_nr
OPTIONS(description='Geografischen Koordinaten des Gitters (GEO-Gitternetz ) in der Größe 1000*1000, zu dem die geokodierte Adressinformation ( Längen- und Breitengrad) der Kunde gehört. Ein Geo-Gitternetz ist ein Raster aus Quadrate zur präzisen Positionsbestimmung auf der Erde.Räumliche Analysen sind nur erlaubt, wenn innerhalb eines GEO-Gitternetz mindestens 7 aktuell registrierte Kunden leben.Ist das nicht der Fall, das Gitter erhält einen Null-Value.'),
vorzugsfiliale_wup_id OPTIONS(description='ID der präferierten Filiale'), vorzugsfiliale_mandant_id
OPTIONS(description='Land_2 der präferierten Filiale'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), merge_fg
OPTIONS(description='Flag, das anzeigt ob dieser Kontakt mit einem anderen Kontakt gemerged/zusammengeführt wurde'),
registrierungsfiliale_wup_id
OPTIONS(description='Filiale in der sich der Kunde registriert hat. Bei physischen Kunden (Anmeldung in der Filiale) kommt diese Information aus dem\""mauellen\"" Registrierungsprozess. Bei digitalen Kunden (Anmeldung über App) kommt diese Information aus der App.'),
registrierungsfiliale_mandant_id OPTIONS(description='Mandant_2 ID zur Registrierungsfiliale'),
registrierungsfiliale_nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer. Gehört zur registrierten Registrierungsfiliale.'),
aktiv_fg OPTIONS(description='Flag das anzeigt, ob der Kunde aktiv oder inaktiv ist'), haushaltsgroesse
OPTIONS(description='Haushaltsgröße'), beschaeftigung_status_id
OPTIONS(description='Beschäftigungsstatus, sagt aus ob Kunde bspw. Schüler/in, Hausmann/frau, Angestellte/r,... ist'),
crm_cidaas_id
OPTIONS(description='MS Dynamics - contact.kl_keycloakid -\nMeldet sich Person unter Verwendung derselben Mailadresse/Mobilnummer an zwei verschiedenen K Card Programmen an, bekommt sie zwei separate Kontakte (crm_kunde_id), Konten (crm_konto_id) und separate Karten (kundenkarte_id). Beide Kontakte werden jedoch mit derselben Cidaas ID versehen.  '))
AS SELECT crm_kunde_id,
 zeit_registrierung,
 zeit_abmeldung,
 kundentyp_cd,
 kundenherkunft_cd,
 gender_id,
 geburtsjahr,
 kunde_statusgrund_id,
 strasse,
 wohnort,
 plz,
 kunde_mandant_id,
 geo_gitter_100_nr,
 geo_gitter_500_nr,
 geo_gitter_1000_nr,
 vorzugsfiliale_wup_id,
 vorzugsfiliale_mandant_id,
 nb_id,
 merge_fg,
 registrierungsfiliale_wup_id,
 registrierungsfiliale_mandant_id,
 registrierungsfiliale_nb_id,
 aktiv_fg,
 haushaltsgroesse,
 beschaeftigung_status_id,
 crm_cidaas_id
FROM kfl_production_dbp_data.crm_l_kunde_2;