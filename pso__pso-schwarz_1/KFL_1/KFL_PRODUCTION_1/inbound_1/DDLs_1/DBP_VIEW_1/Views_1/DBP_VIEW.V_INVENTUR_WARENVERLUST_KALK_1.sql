create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_INVENTUR_WARENVERLUST_KALK_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH.',
	WUP_ID COMMENT 'Der \""WUP_1\"" beinhaltet Märkte und Lager. WUP_1 = WarenUmschlagsPlatz. Mutter WUP_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer. Es betrifft sich nur Filiale, deshalb immer 0.',
	INVENTURART_ID COMMENT 'Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.',
	DAT_INVENTUR_VON COMMENT 'Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_1 unterscheiden.',
	DAT_INVENTUR_BIS COMMENT 'Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_1 unterscheiden.',
	OWG_ID COMMENT 'ID der Oberwarengruppe',
	GJ COMMENT 'Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.',
	BETRAG_VK_NETTO_INVENTUR_DIFF_KALK COMMENT 'Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur_1-Zeitraum'
) COMMENT='Die Tabelle basiert auf Excel und enthält Kalkulatorische Abgrenzung aus dem CO für Jahres- und Zwischeninventuren. Die Tabelle deckt einen Sonderfall ab. Es wird nur Daten für Mandant_1 DE geben und wahrscheinlich nur für zwei Inventur_1-Arten, Jahresinventur und möglicherweise Zwischeninventur. CO muss in Deutschland kalkulatorische Abgrenzungen auf die Inventur_1-Differenzen buchen. Das heißt die eigentlichen systemischen Inventur_1-Werte werden um diesen Wert erhöht oder verringert.'
 as 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        inventurart_id,
        dat_inventur_von,
        dat_inventur_bis,
        owg_id,
        gj,
        betrag_vk_netto_inventur_diff_kalk

FROM DBP_DATA.INVENTUR_WARENVERLUST_KALK_1 ;
