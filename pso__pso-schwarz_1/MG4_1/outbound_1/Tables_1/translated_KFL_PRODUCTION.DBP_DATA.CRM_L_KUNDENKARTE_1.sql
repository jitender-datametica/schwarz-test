CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_l_kundenkarte_1 (
kundenkarte_id STRING(1020) NOT NULL
OPTIONS(description='Nummer der Kundenkarte/ Bonuskarte (gehasht), kann gemappt werden mit ods_bon_kopf.kundenkarte_id'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
crm_kundenkarte_art_id INTEGER DEFAULT - 1
OPTIONS(description='Art_1 der Kundenkarte (Ausprägungen: 1 für digital, 2 für physisch, default 1), nicht zu verwechseln mit ods_bon_kopf.kundenkarte_typ_id das kennzeichnet, ob der Bon mit Payback- (1) oder Kundenkarte (2) erzeugt wurde.'),
crm_kundenkarte_nr STRING(144) NOT NULL
OPTIONS(description='CRM-interne ID für die Kundenkarten/Bonuskarten. Wird in Tabelle aufgenommen, da sie CRM-seitig die eindeutige ID für die Entität arvato_loyaltycard/ für eine_1 Kundenkarte/Bonuskarte darstellt.'),
crm_konto_id STRING(144)
OPTIONS(description='CRM-interne ID des Loyaltyaccounts/Bonuskontos. Ist im PK wegen Relation zu crm_l_kundenkarte_1'),
gesperrt_fg INTEGER NOT NULL
OPTIONS(description='Sperrungsflag einer Kundenkarte (1 gesperrt, 0 nicht gesperrt) - wird immer befüllt'),
zeit_von DATETIME OPTIONS(description='Anfang des Kartengültigkeitsintervalls'),
zeit_bis DATETIME NOT NULL OPTIONS(description='Ende des Kartengültigkeitsintervalls - wird immer befüllt'),
geloescht_fg INTEGER NOT NULL
OPTIONS(description='Löschflag einer Kundenkarte (1 gelöscht, 0 nicht gelöscht) - wird immer befüllt'),
td_insert TIMESTAMP,
td_update TIMESTAMP
)
OPTIONS(description='CRM - Enthält Daten der Entität\"Arvato_Loyaltycard\" (Kundenkarte) aus MS Dynamics CRM. Eine_1 Karte (crm_l_kundenkarte_1) hängt immer an einem Konto_1 (crm_l_konto.crm_konto_id).');