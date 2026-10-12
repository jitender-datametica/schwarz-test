CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ETL.WG_PER_TMP (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
WG_ID INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
DAT_VON DATE NOT NULL OPTIONS(description='Datum, ab welchem dieser Mehrwertsteuersatz gilt. Format\'YYYY-MM-DD\''),
LEAD_MWST_ID INTEGER NOT NULL OPTIONS(description='führende Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)'),
ABT_ID INTEGER
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte ID\'s, positive Werte: aus Stammdatensystem übernommen'),
DAT_BIS DATE OPTIONS(description='Datum, bis zu welchem dieser Mehrwertsteuersatz gilt. Format\'YYYY-MM-DD\''),
OWG_ID INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='ID der Oberwarengruppe'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PLATZIERUNGSWG_ID INTEGER OPTIONS(description='Platzierungswarengruppe - im DWH generierter numerischer Schlüssel'),
WERBETEAM_CD STRING(100) OPTIONS(description='Code des Werbeteams'),
PRIMARY KEY (MANDANT_ID, WG_ID, ARTHIERTYP_ID, DAT_VON) NOT ENFORCED
);