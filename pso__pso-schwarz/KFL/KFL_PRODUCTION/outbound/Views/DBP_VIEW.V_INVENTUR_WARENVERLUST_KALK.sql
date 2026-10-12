CREATE OR REPLACE VIEW kfl_production_dbp_view.v_inventur_warenverlust_kalk (mandant_id
OPTIONS(description='Mandant im DWH.'), wup_id
OPTIONS(description='Der "WUP" beinhaltet Märkte und Lager. WUP = WarenUmschlagsPlatz. Mutter WUP ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer. Es betrifft sich nur Filiale, deshalb immer 0.'),
inventurart_id
OPTIONS(description='Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.'),
dat_inventur_von
OPTIONS(description='Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land unterscheiden.'),
dat_inventur_bis
OPTIONS(description='Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land unterscheiden.'),
owg_id OPTIONS(description='ID der Oberwarengruppe'), gj
OPTIONS(description='Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.'),
betrag_vk_netto_inventur_diff_kalk
OPTIONS(description='Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur-Zeitraum'))
OPTIONS(DESCRIPTION = `DIE TABELLE BASIERT AUF EXCEL UND ENTHÄLT KALKULATORISCHE ABGRENZUNG AUS DEM CO FÜR JAHRES- UND ZWISCHENINVENTUREN. DIE TABELLE DECKT EINEN SONDERFALL AB. ES WIRD NUR DATEN FÜR MANDANT DE GEBEN UND WAHRSCHEINLICH NUR FÜR ZWEI INVENTUR-ARTEN, JAHRESINVENTUR UND MÖGLICHERWEISE ZWISCHENINVENTUR. CO MUSS IN DEUTSCHLAND KALKULATORISCHE ABGRENZUNGEN AUF DIE INVENTUR-DIFFERENZEN BUCHEN. DAS HEISST DIE EIGENTLICHEN SYSTEMISCHEN INVENTUR-WERTE WERDEN UM DIESEN WERT ERHÖHT ODER VERRINGERT.`)
AS SELECT mandant_id,
 wup_id,
 nb_id,
 inventurart_id,
 dat_inventur_von,
 dat_inventur_bis,
 owg_id,
 gj,
 betrag_vk_netto_inventur_diff_kalk
FROM kfl_production_dbp_data.inventur_warenverlust_kalk;