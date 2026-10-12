CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.EK_INFOSATZ_WUP_ZU_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
EK_INFOSATZ_ID INTEGER NOT NULL
OPTIONS(description='Nummer des Infosatzes. Zusammen mit mandant_id eindeutiger Schlüssel'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
PROZENT_AKZEPTANZ_UNTERLIEF NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Prozentwert der Akzeptanz einer Unterlieferung aus untto'),
LOESCH_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag gelöscht aus eine.loekz. Infosätze können sowohl auf Kopf- als auch auf Pos-Ebene gelöscht sein'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
MIND_BESTELLMENGE NUMERIC(18,3) OPTIONS(description='Mindestbestellmenge'),
PLANLIEFERZEIT INTEGER OPTIONS(description='Planlieferzeit in Tagen'),
RUNDUNGSPROFIL STRING(10) COLLATE 'und:ci' OPTIONS(description='Rundungsprofil'),
NORMAL_BESTELLMENGE NUMERIC(18,3) OPTIONS(description='Normalbestellmenge'),
UEBERLIEFERUNG_TOLERANZGRENZE NUMERIC(18,3) OPTIONS(description='Toleranzgrenze für Überlieferung'),
UEBERLIEFERUNG_UNBEGRENZT_FG INTEGER OPTIONS(description='Kennzeichen: unbegrenzte Überlieferung erlaubt'),
UNTERLIEFERUNG_TOLERANZGRENZE NUMERIC(18,3) OPTIONS(description='Toleranzgrenze für Unterlieferung'),
NETTOPREIS NUMERIC(18,3) OPTIONS(description='Nettopreis im Einkaufsinfo'),
BMPE STRING(3) COLLATE 'und:ci' OPTIONS(description='Bestellpreismengeneinheit'),
BESTAET_STEUERSCHLUESSEL INTEGER OPTIONS(description='Bestätigungssteuerschlüssel'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
PRIMARY KEY (MANDANT_ID, EK_INFOSATZ_ID, WUP_ID, NB_ID) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Zuordnung Einkaufsinfosaetze zu Betrieben aus der SAP-Quelle EINE_1');