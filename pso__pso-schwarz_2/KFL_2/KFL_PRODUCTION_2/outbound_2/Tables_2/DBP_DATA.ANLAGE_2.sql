--==============================================================
-- Table: anlage_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlage_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.anlage_2 (
anlage_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Anlagen Hauptnummer aus anln1'),
anlage_sub_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Anlagen Unternummer aus anln2'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
buchungskreis_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP_2 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_2, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland'),
dat_erstellung DATE NOT NULL OPTIONS(description='Anlagedatum aus dat_erstellung'),
in_lief_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lieferantennummer. Im DWH erzeugter numerischer Schlüssel'),
eigentum_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Flag Eigentum aus eigkz. Wenn Eigentum, dann 1'),
anlage_id_alt STRING(20) COLLATE 'und:ci'
OPTIONS(description='ID der Herkunftsanlage, von der auf die Anlage_2 umgebucht wurde. Aus aibn1. Häufig leer, daher compression'),
anlage_sub_id_alt BIGNUMERIC(38,0)
OPTIONS(description='Unternummer der Herkunftsanlage, von der auf die Anlage_2 umgebucht wurde. Aus aibn2'),
dat_erstellung_alt DATE OPTIONS(description='Ursprüngliches Zugangsdatum der Anlage_2 im Bau / umgebucht. Aus aibdt'),
anlage_bez STRING(100) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Anlaage, konkateniert aus den Feldern txt50 und txa50'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (anlage_sub_id, mandant_id, buchungskreis_id) NOT ENFORCED
) OPTIONS(description='IMS - Anlagen-Stammdaten aus SAP IND anla');