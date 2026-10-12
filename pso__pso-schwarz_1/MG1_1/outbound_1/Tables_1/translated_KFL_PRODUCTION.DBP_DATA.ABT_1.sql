CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ABT_1 (
ABT_ID INTEGER NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
MANDANT_ID INTEGER DEFAULT 1 NOT NULL OPTIONS(description='Mandant_1 im DWH'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ABT_ID, ARTHIERTYP_ID, MANDANT_ID) NOT ENFORCED
) OPTIONS(description='Abteilung - oberste Stufe der Artikelhierarchie');