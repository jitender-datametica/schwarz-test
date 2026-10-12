CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.CRM_L_KUNDENKARTE_2 (
KUNDENKARTE_ID STRING(1020) NOT NULL
OPTIONS(description='Nummer der Kundenkarte/ Bonuskarte (gehasht), kann gemappt werden mit ods_bon_kopf.kundenkarte_id'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
CRM_KUNDENKARTE_ART_ID INTEGER DEFAULT - 1
OPTIONS(description='Art_2 der Kundenkarte (Ausprägungen: 1 für digital, 2 für physisch, default 1), nicht zu verwechseln mit ods_bon_kopf.kundenkarte_typ_id das kennzeichnet, ob der Bon mit Payback- (1) oder Kundenkarte (2) erzeugt wurde.'),
CRM_KUNDENKARTE_NR STRING(144) NOT NULL
OPTIONS(description='CRM-interne ID für die Kundenkarten/Bonuskarten. Wird in Tabelle aufgenommen, da sie CRM-seitig die eindeutige ID für die Entität arvato_loyaltycard/ für eine_2 Kundenkarte/Bonuskarte darstellt.'),
CRM_KONTO_ID STRING(144)
OPTIONS(description='CRM-interne ID des Loyaltyaccounts/Bonuskontos. Ist im PK wegen Relation zu crm_l_kundenkarte_2'),
GESPERRT_FG INTEGER NOT NULL
OPTIONS(description='Sperrungsflag einer Kundenkarte (1 gesperrt, 0 nicht gesperrt) - wird immer befüllt'),
ZEIT_VON DATETIME OPTIONS(description='Anfang des Kartengültigkeitsintervalls'),
ZEIT_BIS DATETIME NOT NULL OPTIONS(description='Ende des Kartengültigkeitsintervalls - wird immer befüllt'),
GELOESCHT_FG INTEGER NOT NULL
OPTIONS(description='Löschflag einer Kundenkarte (1 gelöscht, 0 nicht gelöscht) - wird immer befüllt'),
TD_INSERT TIMESTAMP,
TD_UPDATE TIMESTAMP
)
OPTIONS(description='CRM - Enthält Daten der Entität\"Arvato_Loyaltycard\" (Kundenkarte) aus MS Dynamics CRM. Eine_2 Karte (crm_l_kundenkarte_2) hängt immer an einem Konto_2 (crm_l_konto.crm_konto_id).');