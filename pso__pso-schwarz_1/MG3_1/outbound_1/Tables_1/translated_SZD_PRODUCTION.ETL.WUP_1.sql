CREATE OR REPLACE TABLE szd_production_etl.wup_1 (
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
vw_id INTEGER DEFAULT 0
OPTIONS(description='ID des Vertriebsweges. Einkaufs-Sicht auf die wup_1 Objekte (Restaurants und Backshops z.Bsp. haben keinen Vertriebsweg)'),
vs_id INTEGER DEFAULT 0 OPTIONS(description='ID der Vertriebsschiene. Vertriebs-Sicht auf die wup_1 Objekte'),
land_id STRING(8) COLLATE 'und:ci' DEFAULT '  ' NOT NULL
OPTIONS(description='Land_1, in dem sich der Markt befindet (PL, CZ, DE,..)'),
region_id INTEGER OPTIONS(description='Bundesland, in dem sich der Markt befindet'),
dat_von DATE OPTIONS(description='Eroeffnungsdatum. Muss nicht der 1. Abverkaufstag sein! Format YYYY-MM_1-DD'),
wup_typ_id INTEGER DEFAULT 0
OPTIONS(description='entspricht der Kennzeichnung der Art_1 des Umschlagplatzes (0: normaler Markt; 1: Lager; 2: Verteilzentrum : -1 System. Neu koennten hier auch noch Mitbewerbermaerkte gefuehrt werden.'),
wup_name_v STRING(160) COLLATE 'und:ci' DEFAULT ' '
OPTIONS(description='Marktbezeichnung fuer den Vertrieb (aus Hyperion gepflegt)'),
wup_name_e STRING(160) COLLATE 'und:ci' DEFAULT ' '
OPTIONS(description='Marktbezeichnung fuer den Einkauf (aus SAP gepflegt)'),
wup_standort STRING(160) COLLATE 'und:ci' DEFAULT ' ' OPTIONS(description='Ortsbezeichnung'),
wup_plz STRING(40) COLLATE 'und:ci' DEFAULT ' ' OPTIONS(description='Postleitzahl'),
wup_str STRING(160) COLLATE 'und:ci' DEFAULT ' ' OPTIONS(description='Strasse'),
vf_id INTEGER DEFAULT 0 OPTIONS(description='Vertriebsform (Kaufland, Handelshof,...)'),
vkl_id INTEGER DEFAULT - 1 OPTIONS(description='Verkaufsleiter - kommt aus der Hyperion - Schnittstelle'),
hl_id INTEGER OPTIONS(description='Hausleiter'),
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) OPTIONS(description='Schließungsdatum Format YYYY-MM_1-DD'),
lead_mwst NUMERIC(9,3) OPTIONS(description='Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)'),
uebernahme_von STRING(160) COLLATE 'und:ci' DEFAULT ' '
OPTIONS(description='von welchem Mitbewerber wurde der Markt uebernommen'),
breakevenumsatz NUMERIC(18,2) DEFAULT 0 OPTIONS(description='Kennzahl, kommt aus Hyperion'),
systemrentabilitaet NUMERIC(18,2) DEFAULT 0 OPTIONS(description='Kennzahl, kommt aus Hyperion'),
verkaufsflaeche NUMERIC(18,2) DEFAULT 0 OPTIONS(description='Verkaufsflaeche des Marktes'),
betriebsflaeche NUMERIC(18,2) DEFAULT 0 OPTIONS(description='Betriebsflaeche des Marktes'),
fleischsystem INTEGER DEFAULT 0 OPTIONS(description='Kennzeichnung, ob Fleischtheke vorhanden. Wird z.Zt nicht benutzt'),
preiskategorie_food INTEGER
OPTIONS(description='Preiskategorie Food fuer den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe'),
preiskategorie_nonfood INTEGER
OPTIONS(description='Preiskategorie Nonfood fuer den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe'),
sortkategorie_food INTEGER
OPTIONS(description='Sortimentskategorie Food fuer den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe'),
sortkategorie_nonfood INTEGER
OPTIONS(description='Preiskategorie Nonfood fuer den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe. Ist z.Zt. immer mit Null gefuellt'),
sondermarkt INTEGER OPTIONS(description='wird z.Zt. nicht benutzt'),
ref_wup_id INTEGER DEFAULT 0 OPTIONS(description='wird z.Zt. nicht benutzt'),
wm_id INTEGER DEFAULT - 1 OPTIONS(description='Warenmanager ID'),
kassentyp STRING(40) DEFAULT '          '
OPTIONS(description='im Markt benutztes Kassensystem (aus ods_bon_transaction.kassensystem_name)'),
dat_qbm_umstellung DATE OPTIONS(description='Datum seit wann QBM (oder die aktuelle QBM-Version) im Markt aktiv ist'),
getraenkemarkt_fg INTEGER DEFAULT 0 OPTIONS(description='Getraenkemarkt Flag'),
kundenfaktor BIGNUMERIC(11,10) DEFAULT 1
OPTIONS(description='Korrekturfaktor zur Ermittlung der Anzahl der Kunden, bei Maerkten mit Getraenkemarkt angewendet'),
vz_wup_id INTEGER OPTIONS(description='Beim wup_1 vom Typ /"Lager/" ist hier das Verteilzentrum eingetragen'),
qbm_id INTEGER OPTIONS(description='Kennzeichnung, ob der Markt ueber ein QBM-System verfuegt (Reklamationsabwicklung)'),
wup_id_alt INTEGER OPTIONS(description='Bei Wechsel der Marktnummer wird hier die alte Marktnummer hinterlegt'),
verkaufsorganisation_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Organisatorische Einheit, die fuer den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.'),
buchungskreis_id INTEGER
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP_1 ueber die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_1, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland W'),
dat_eroeffnung DATE OPTIONS(description='/"Echtes/" Eroeffnungsdatum des Marktes. Kann von dat_von abweichen.'),
bewertungskreis_id STRING(16) COLLATE 'und:ci' DEFAULT '    '
OPTIONS(description='der Bewertungskreis enthaelt die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. ueber den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt'),
wup_stadt STRING(160) COLLATE 'und:ci' DEFAULT ' ' OPTIONS(description='Ort aus der Adresse des Marktes'),
haupt_wup_id INTEGER
OPTIONS(description='Hier ist der uebergeordnete wup_1 gespeichert, falls mehrere wup_ids logisch zusammengehoeren (z.Bsp. Restaurant zu Markt)'),
kreistyp_gruppe_id STRING(16) COLLATE 'und:ci' OPTIONS(description='Region_1 / Gruppierung Kreistypen'),
dat_umstellung_waage DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL
OPTIONS(description='Datum, ab dem die Waagendaten sich im DWH befinden. Default ist der 31.12.9999'),
dat_von_alt DATE OPTIONS(description='Nur bei Umzugsfilialen gefuellt: Das dat_von der Vorgaenger-Filiale'),
dat_eroeffnung_alt DATE
OPTIONS(description='Nur bei Umzugsfilialen gefuellt: Das Eroeffnungsdatum der Vorgaenger-Filiale'),
umzugsfiliale_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Ist = 1 bei geschlossenen Filialen, fuer die eine_1 Nachfolger-Filiale existiert. Sonst = 0'),
gf_id INTEGER DEFAULT - 1
OPTIONS(description='Geschaeftsfuehrer ID, numerisch. Wird hierzur Performancesteigerung denormalisiert abgelegt, um den CROSS JOIN zur VKL_1-Tabelle zu ersparen'),
umsatz_ea_eur NUMERIC(18,2) DEFAULT 0
OPTIONS(description='Umsatz laut Expansionsauftrag pro Jahr in Euro - Wert wird manuell gepflegt, da keinne SST zur Expansionsdatenbank besteht'),
umsatz_ea_land NUMERIC(18,2) DEFAULT 0
OPTIONS(description='Umsatz laut Expansionsauftrag pro Jahr in Landeswaehrung - Wert wird manuell gepflegt, da keinne SST zur Expansionsdatenbank besteht. Umrechnung ueber Kurstabelle vom Anwender nicht erwuenscht.'),
breitengrad BIGNUMERIC(29,16) OPTIONS(description='Breitengrad aus dem GIS-System (Latitude)'),
laengengrad BIGNUMERIC(29,16) OPTIONS(description='Laengengrad aus dem GIS-System (Longitude)'),
gis_quali_id INTEGER DEFAULT - 1 OPTIONS(description='Numerische ID des GIS Qualitaetskennzeichens. '),
gln_id STRING(80) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Global Location_1 Number - international  eindeutige Kennzeichnung der Lokation. Quelle ist KNA1_1 (Retail) mit den Feldern bbbnr(Basisnummer), bbsnr(Individueller Nummernteil) und bubkz(Pruefziffer)'),
fipo_pruef_objekt_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='eindeutige ID eines Pruefobjekts aus dem Quellfeld pob_id'),
adresse_id INTEGER DEFAULT - 1
OPTIONS(description='Adressnummer aus dem Quellfeld adrnr. Referenz zur SAP Tabelle adrc_1 (im DWH nicht vorhanden)'),
dat_dayforce_ab DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL
OPTIONS(description='Datum, ab dem die Personaldaten aus'),
mandant_id_ursprung INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='urspruengliche Mandant_1 ID DWH bezueglich des Liefersystem (SAP) - Bsp. Moldau wird im SAP-System Rumaenien verwaltet, deshalb wird in diesem Feld die Mandant_1 ID von Rumaenien gespeichert'),
eigentum_miete_kz STRING(4) COLLATE 'und:ci'
OPTIONS(description='Kennzeichen, ob es sich bei der Filiale um Eigentum (=E) oder Mietobjekt (=M) handelt (kann auch null sein, wenn nicht definiert)'),
dat_letzte_modernisierung_von DATE OPTIONS(description='Datum Start letzte Modernisierungsmaßnahme (Format JJJJ-MM_1-TT)'),
dat_letzte_modernisierung_bis DATE OPTIONS(description='Datum Ende letzte Modernisierungsmaßnahme (Format JJJJ-MM_1-TT)'),
dat_letzter_facelift DATE OPTIONS(description='Datum Start letzter Facelift (Format JJJJ-MM_1-TT)'),
dat_wiedereroeffnung DATE
OPTIONS(description='Datum der Wiedereroeffnung bei Abriss/Neubau, bei denen die Marktnummer gleich bleibt (Datum wird manuell gepflegt, da keine Quelle)'),
einwohner_anzahl INTEGER OPTIONS(description='Einwohner je Markt. Manuelle Befuellung'),
umsatz_erwartung_eur NUMERIC(18,2) OPTIONS(description='Umsatz Erwartung je Markt. Manuelle Befuellung'),
dat_letzter__facelift_von DATE OPTIONS(description='Datum des letzten Facelifts des Marktes. Manuelle Befuellung'),
td_update TIMESTAMP,
td_insert TIMESTAMP,
filialtyp_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Filialtypisierung fuer Sortimentskonzept. (VT Orga INTEGER ). Wird jaehrlich manuell aktualisiert.')
);