--==============================================================
-- Table: transportation_unit_aktivitaet
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_aktivitaet
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:30:29
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transportation_unit_aktivitaet (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
transportation_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Transporteinheit (intern)'),
kj_transportation_unit BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anlagejahr der Transporteinheit'),
transportation_unit_sr_act_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='transportation_unit_sr_act_id'),
aktivitaet_richtung_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Richtung einer Warenannahme- und Versandaktivitaet'),
anlieferung_id STRING(20) COLLATE 'und:ci'
OPTIONS(description='Buchungsnummer aus dem Mercareon System. Quellfeld ist bunum'),
mercareon_kommentar_tdl STRING(255) COLLATE 'und:ci'
OPTIONS(description='Mercareon Buchung Kommentar Transportdienstleister'),
mercareon_kommentar_kl STRING(255) COLLATE 'und:ci' OPTIONS(description='Mercareon Buchung Kommentar Kaufland'),
leerpal_entscheidung_id STRING(2) COLLATE 'und:ci' OPTIONS(description='Entscheidung ueber Leerpalettentausch'),
anz_pal_platz NUMERIC(6,2) OPTIONS(description='Palletenplatz mit 4,2 Dezimalstellen'),
ladung_begrenzung_fg BIGNUMERIC(38,0) OPTIONS(description='Load Restraint'),
kommentar STRING(40) COLLATE 'und:ci' OPTIONS(description='Freier Text / Kommentar'),
kfz_kennzeichen STRING(20) COLLATE 'und:ci' OPTIONS(description='Kfz-Kennzeichen'),
temp_frische_rel_fg BIGNUMERIC(38,0) OPTIONS(description='Temperatur Frische relevant'),
temp_frische STRING(6) COLLATE 'und:ci' OPTIONS(description='Temperatur Frische'),
temp_frische_nok_fg BIGNUMERIC(38,0) OPTIONS(description='Temperatur Frische außerhalb des zulaessigen Bereichs'),
temp_frische_korr BIGNUMERIC(38,0) OPTIONS(description='Temperatur frisch korrigiert'),
temp_oug_rel_fg BIGNUMERIC(38,0) OPTIONS(description='Temperatur Obst und Gemuese relevant'),
temp_oug BIGNUMERIC(38,0) OPTIONS(description='Temperatur Obst und Gemuese'),
temp_oug_nok_fg BIGNUMERIC(38,0) OPTIONS(description='Temperatur Obst und Gemuese außerhalb des zulaessigen Bereichs'),
temp_oug_korr BIGNUMERIC(38,0) OPTIONS(description='Temperatur Obst und Gemuese korrigiert'),
temp_tkk_rel_fg BIGNUMERIC(38,0) OPTIONS(description='Temperatur Tiefgefroren relevant'),
temp_tkk BIGNUMERIC(38,0) OPTIONS(description='Temperatur Tiefgefroren'),
temp_tkk_nok_fg BIGNUMERIC(38,0) OPTIONS(description='Temperatur Tiefgefroren außerhalb des zulaessigen Bereichs'),
temp_tkk_korr STRING(6) COLLATE 'und:ci' OPTIONS(description='Temperatur Tiefgefroren korrigiert'),
temp_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Temperatur UoM'),
nutzung_grund_id STRING(2) COLLATE 'und:ci' OPTIONS(description='Utlization Reason'),
sortimentsreihenfolge STRING(10) COLLATE 'und:ci' OPTIONS(description='Sortimentsreihenfolge auf dem LKW'),
ladung_gew NUMERIC(18,3) OPTIONS(description='Ladungsgewicht der Transporteinheit'),
ladung_gew_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Gewichtseinheit'),
ladung_vol NUMERIC(18,3) OPTIONS(description='Ladungsvolumen der Transporteinheit'),
ladung_vol_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Volumeneinheit'),
dat_tour DATE OPTIONS(description='Tourdatum'),
menge_gefahrgut NUMERIC(7,2) OPTIONS(description='Gefahrgutmenge'),
belos_tourart_id BIGNUMERIC(38,0) OPTIONS(description='Belos Tourart'),
belos_tourstatus_id BIGNUMERIC(38,0)
OPTIONS(description='ID des Tourstatus; unterscheidet, ob im System angelegt, gesendet oder abgerechnet wurde'),
belos_tourart_subtyp BIGNUMERIC(38,0) OPTIONS(description='Tourart Subtyp'),
belos_adresse_spedition_id STRING(40)
OPTIONS(description='Eindeutiger Schluessel zur Identifikation einer Belos Adresse'),
belos_sonderabwicklung_id STRING(20) OPTIONS(description='Sonderabwicklung'),
belos_sonderabwicklung_ugk_fg BIGNUMERIC(38,0) OPTIONS(description='Sonderabwicklung UGK auf dieser Tour vorhanden'),
belos_sonderabwicklung_gk_fg BIGNUMERIC(38,0) OPTIONS(description='Sonderabwicklung GK auf dieser Tour vorhanden'),
belos_sonderabwicklung_tg_fg BIGNUMERIC(38,0) OPTIONS(description='Sonderabwicklung TG auf dieser Tour vorhanden'),
belos_sonderabwicklung_tiko_fg BIGNUMERIC(38,0) OPTIONS(description='Sonderabwicklung TIKO auf dieser Tour vorhanden'),
datzeit_start_plan TIMESTAMP
OPTIONS(description='Startzeitstempel des geplanten Starts einer W/V-Aktivitaet'),
datzeit_start_ist TIMESTAMP
OPTIONS(description='Startzeitstempel des geplanten Starts einer W/V-Aktivitaet'),
datzeit_ende_plan TIMESTAMP
OPTIONS(description='Endezeitstempel des geplanten Starts einer W/V-Aktivitaet'),
datzeit_ende_ist TIMESTAMP
OPTIONS(description='Startzeitstempel des geplanten Starts einer W/V-Aktivitaet'),
datzeit_route TIMESTAMP OPTIONS(description='Abfahrtstermin für Route'),
route_kz STRING(1) OPTIONS(description='Ermittlungskennzeichen der Route zum Verladen der TE'),
route_quelle STRING(1) OPTIONS(description='Herkunft der Routenstammdaten'),
tour_office_fg BIGNUMERIC(38,0) OPTIONS(description='Fahrer muss ins Transportbuero'),
tour_classification STRING(2) OPTIONS(description='Tourinfo'),
belos_rundlauf_transport_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen Rundlauf'),
belos_fleischwerk_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen FLW-Tour'),
belos_distribution_abr_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen Abrechnungsrelevnat'),
belos_industrie_abh_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen Industrieabholung'),
belos_adresse_absender_num_id BIGNUMERIC(38,0) OPTIONS(description='BELOS-Adresse Absender (numerisch)'),
lagernummer_id STRING(4) OPTIONS(description='Lagernummer ID.'),
datzeit_anlage TIMESTAMP
OPTIONS(description='Timestamap, an dem der Satz im Quellsystem angelegt wurde.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, transportation_unit_id, transportation_unit_sr_act_id, kj_transportation_unit) NOT ENFORCED
) OPTIONS(description='S&R Activity of Transportation Unit');