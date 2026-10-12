--==============================================================
-- Table: inventur_warenverlust_kalk_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventur_warenverlust_kalk_2
   generated from Powerdesigner on Mittwoch, 26. März 2025 14:46:40
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.INVENTUR_WARENVERLUST_KALK_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Der "WUP_2" beinhaltet Märkte und Lager. WUP_2 = WarenUmschlagsPlatz. Mutter WUP_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer. Es betrifft sich nur Filiale, deshalb immer 0.',
   inventurart_id                      INTEGER     NOT NULL COMMENT 'Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.',
   dat_inventur_von                    DATE             NOT NULL COMMENT 'Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_2 unterscheiden.',
   dat_inventur_bis                    DATE             NOT NULL COMMENT 'Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_2 unterscheiden.',
   owg_id                              INTEGER     NOT NULL COMMENT 'ID der Oberwarengruppe',
   gj                                  INTEGER     COMMENT 'Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.',
   betrag_vk_netto_inventur_diff_kalk  NUMBER(29,4)     COMMENT 'Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur_2-Zeitraum',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_INVENTUR_WARENVERLUST_KALK PRIMARY KEY (mandant_id, wup_id, nb_id, inventurart_id, dat_inventur_bis, owg_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle basiert auf Excel und enthält Kalkulatorische Abgrenzung aus dem CO für Jahres- und Zwischeninventuren. Die Tabelle deckt einen Sonderfall ab. Es wird nur Daten für Mandant_2 DE geben und wahrscheinlich nur für zwei Inventur_2-Arten, Jahresinventur und möglicherweise Zwischeninventur. CO muss in Deutschland kalkulatorische Abgrenzungen auf die Inventur_2-Differenzen buchen. Das heißt die eigentlichen systemischen Inventur_2-Werte werden um diesen Wert erhöht oder verringert.';
