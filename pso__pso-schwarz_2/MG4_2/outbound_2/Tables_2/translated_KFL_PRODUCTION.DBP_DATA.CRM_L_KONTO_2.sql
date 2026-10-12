CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_l_konto_2 (
crm_konto_id STRING(144) NOT NULL
OPTIONS(description='CRM-interne ID des Loyaltyaccounts/Bonuskontos. Ist im PK wegen Relation zu crm_l_kundenkarte_2'),
crm_kunde_id STRING(144) OPTIONS(description='CRM-interne ID des Kunden'),
crm_konto_typ_id INTEGER,
crm_kundenprogramm_id STRING(144) NOT NULL
OPTIONS(description='CRM-interne ID des Loyaltypogramms/Kundenkartenprogramms. Ein Konto_2 (crm_l_konto_tmp.crm_konto_id) ist stets einem Kundenprogramm zugeordnet.'),
zeit_von DATETIME OPTIONS(description='Anfang des Kartengültigkeitsintervalls'),
zeit_bis DATETIME NOT NULL OPTIONS(description='Ende des Kartengültigkeitsintervalls - wird immer befüllt'),
geloescht_fg INTEGER NOT NULL
OPTIONS(description='Löschflag einer Kundenkarte (1 gelöscht, 0 nicht gelöscht) - wird immer befüllt'),
crm_konto_nr INTEGER OPTIONS(description='Nummer des Loyaltyaccounts/Bonuskontos'),
td_insert TIMESTAMP,
td_update TIMESTAMP
)
OPTIONS(description='CRM - Lookup für das Kundenkonto -\"Arvato_Loyaltyaccount_2\" (1:1 Beziehung). Ein Kunde (crm_kunde.kunde_id) kann Stand 05.03.19 an einem Loyaltyprogramm teilnehmen und hat daher einen Loyaltyaccount/ein Bonuskonto');