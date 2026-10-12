CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_kartebew_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_2 ID wird verwendet fur Beziehung Lager zu Verteilzentrum.'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
kundenkarte_id STRING(255) NOT NULL
OPTIONS(description='Nummer der Kundenkarte / Bonuskarte (gehasht), kann gemappt werden mit ods_bon_kopf.kundenkarte_id.'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT.'),
loyalty_berechtigt_fg INTEGER NOT NULL
OPTIONS(description='Gibt an, ob CRM Promotion gewährt wurde. 1 = ja; 0 = nein. Ab 01.03.2025 wird das Flag aus ods_bon_kopf_2 berechnet. (Logik für alte Daten folgt)'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
umsatz_netto_sa NUMERIC(29,4) OPTIONS(description='SA Umsatz vermindert um den Mehrwertsteuerbetrag.'),
umsatz_netto_af NUMERIC(29,4) OPTIONS(description='AF Umsatz vermindert um den Mehrwertsteuerbetrag.'),
umsatz_brutto_sa NUMERIC(29,4) OPTIONS(description='SA Umsatz.'),
umsatz_brutto_af NUMERIC(29,4) OPTIONS(description='AF Umsatz.'),
anz_bons INTEGER OPTIONS(description='Bons, die eine_2 Kundenkarte generiert.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, kundenkarte_id, dat, loyalty_berechtigt_fg) NOT ENFORCED
)
OPTIONS(description='EK-KUN - MSDynamicsCRM - Aggregat auf Bondaten für CRM. Granularität Tag_2 - Markt und loyalty_berechtigt_fg. Inhalt: Kundenkarte mit der Anzahl ihrer generierten Bons und ihres Umsatzes (brutto u. netto).');