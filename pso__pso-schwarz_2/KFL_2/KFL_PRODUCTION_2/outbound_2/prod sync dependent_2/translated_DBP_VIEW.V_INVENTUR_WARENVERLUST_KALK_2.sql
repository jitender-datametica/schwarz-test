CREATE OR REPLACE VIEW kfl_production_dbp_view.v_inventur_warenverlust_kalk_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), wup_id
OPTIONS(description='Der\""WUP_2\"" beinhaltet Märkte und Lager. WUP_2 = WarenUmschlagsPlatz. Mutter WUP_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer. Es betrifft sich nur Filiale, deshalb immer 0.'),
inventurart_id
OPTIONS(description='Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.'),
dat_inventur_von
OPTIONS(description='Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_2 unterscheiden.'),
dat_inventur_bis
OPTIONS(description='Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_2 unterscheiden.'),
owg_id OPTIONS(description='ID der Oberwarengruppe'), gj
OPTIONS(description='Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.'),
betrag_vk_netto_inventur_diff_kalk
OPTIONS(description='Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur_2-Zeitraum'))
OPTIONS(DESCRIPTION = `Die Tabelle basiert auf Excel und enthält Kalkulatorische Abgrenzung aus dem CO für Jahres- und Zwischeninventuren. Die Tabelle deckt einen Sonderfall ab. Es wird nur Daten für Mandant_2 DE geben und wahrscheinlich nur für zwei Inventur_2-Arten, Jahresinventur und möglicherweise Zwischeninventur. CO muss in Deutschland kalkulatorische Abgrenzungen auf die Inventur_2-Differenzen buchen. Das heißt die eigentlichen systemischen Inventur_2-Werte werden um diesen Wert erhöht oder verringert.`)
AS SELECT mandant_id,
 wup_id,
 nb_id,
 inventurart_id,
 dat_inventur_von,
 dat_inventur_bis,
 owg_id,
 gj,
 betrag_vk_netto_inventur_diff_kalk
FROM kfl_production_dbp_data.inventur_warenverlust_kalk_2;