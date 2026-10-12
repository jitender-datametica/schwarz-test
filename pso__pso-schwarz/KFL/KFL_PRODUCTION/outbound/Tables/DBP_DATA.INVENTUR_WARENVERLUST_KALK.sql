--==============================================================
-- Table: inventur_warenverlust_kalk
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventur_warenverlust_kalk
   generated from Powerdesigner on Mittwoch, 26. März 2025 14:46:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.inventur_warenverlust_kalk (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der "WUP" beinhaltet Märkte und Lager. WUP = WarenUmschlagsPlatz. Mutter WUP ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer. Es betrifft sich nur Filiale, deshalb immer 0.'),
inventurart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.'),
dat_inventur_von DATE NOT NULL
OPTIONS(description='Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land unterscheiden.'),
dat_inventur_bis DATE NOT NULL
OPTIONS(description='Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land unterscheiden.'),
owg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Oberwarengruppe'),
gj BIGNUMERIC(38,0)
OPTIONS(description='Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.'),
betrag_vk_netto_inventur_diff_kalk BIGNUMERIC(38,4)
OPTIONS(description='Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur-Zeitraum'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, inventurart_id, dat_inventur_bis, owg_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle basiert auf Excel und enthält Kalkulatorische Abgrenzung aus dem CO für Jahres- und Zwischeninventuren. Die Tabelle deckt einen Sonderfall ab. Es wird nur Daten für Mandant DE geben und wahrscheinlich nur für zwei Inventur-Arten, Jahresinventur und möglicherweise Zwischeninventur. CO muss in Deutschland kalkulatorische Abgrenzungen auf die Inventur-Differenzen buchen. Das heißt die eigentlichen systemischen Inventur-Werte werden um diesen Wert erhöht oder verringert.');