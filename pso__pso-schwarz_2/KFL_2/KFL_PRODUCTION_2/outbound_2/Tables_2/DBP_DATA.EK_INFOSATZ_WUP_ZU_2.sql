CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ek_infosatz_wup_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ek_infosatz_id INTEGER NOT NULL
OPTIONS(description='Nummer des Infosatzes. Zusammen mit mandant_id eindeutiger Schlüssel'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
prozent_akzeptanz_unterlief NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Prozentwert der Akzeptanz einer Unterlieferung aus untto'),
loesch_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag gelöscht aus eine.loekz. Infosätze können sowohl auf Kopf- als auch auf Pos-Ebene gelöscht sein'),
mind_bestellmenge NUMERIC(18,3) OPTIONS(description='Mindestbestellmenge'),
planlieferzeit BIGNUMERIC(38,0) OPTIONS(description='Planlieferzeit in Tagen'),
rundungsprofil STRING(10) COLLATE 'und:ci' OPTIONS(description='Rundungsprofil'),
normal_bestellmenge NUMERIC(18,3) OPTIONS(description='Normalbestellmenge'),
ueberlieferung_toleranzgrenze NUMERIC(18,3) OPTIONS(description='Toleranzgrenze für Überlieferung'),
ueberlieferung_unbegrenzt_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen: unbegrenzte Überlieferung erlaubt'),
unterlieferung_toleranzgrenze NUMERIC(18,3) OPTIONS(description='Toleranzgrenze für Unterlieferung'),
nettopreis NUMERIC(18,3) OPTIONS(description='Nettopreis im Einkaufsinfo'),
bmpe STRING(3) COLLATE 'und:ci' OPTIONS(description='Bestellpreismengeneinheit'),
bestaet_steuerschluessel BIGNUMERIC(38,0) OPTIONS(description='Bestätigungssteuerschlüssel'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, ek_infosatz_id, wup_id, nb_id) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Zuordnung Einkaufsinfosaetze zu Betrieben aus der SAP-Quelle EINE_2');