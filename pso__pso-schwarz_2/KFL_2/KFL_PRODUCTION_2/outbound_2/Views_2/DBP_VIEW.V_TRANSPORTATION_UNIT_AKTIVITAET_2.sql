CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transportation_unit_aktivitaet_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), transportation_unit_id OPTIONS(description='Transporteinheit (intern)'),
kj_transportation_unit OPTIONS(description='Anlagejahr der Transporteinheit'), transportation_unit_sr_act_id
OPTIONS(description='transportation_unit_sr_act_id'), aktivitaet_richtung_id
OPTIONS(description='Richtung einer Warenannahme- und Versandaktivitaet'), anlieferung_id
OPTIONS(description='Buchungsnummer aus dem Mercareon System. Quellfeld ist bunum'), mercareon_kommentar_tdl
OPTIONS(description='Mercareon Buchung Kommentar Transportdienstleister'), mercareon_kommentar_kl
OPTIONS(description='Mercareon Buchung Kommentar Kaufland'), leerpal_entscheidung_id
OPTIONS(description='Entscheidung ueber Leerpalettentausch'), anz_pal_platz
OPTIONS(description='Palletenplatz mit 4,2 Dezimalstellen'), ladung_begrenzung_fg OPTIONS(description='Load Restraint'),
kommentar OPTIONS(description='Freier Text / Kommentar'), kfz_kennzeichen OPTIONS(description='Kfz-Kennzeichen'),
temp_frische_rel_fg OPTIONS(description='Temperatur Frische relevant'), temp_frische
OPTIONS(description='Temperatur Frische'), temp_frische_nok_fg
OPTIONS(description='Temperatur Frische außerhalb des zulaessigen Bereichs'), temp_frische_korr
OPTIONS(description='Temperatur frisch korrigiert'), temp_oug_rel_fg
OPTIONS(description='Temperatur Obst und Gemuese relevant'), temp_oug OPTIONS(description='Temperatur Obst und Gemuese'),
temp_oug_nok_fg OPTIONS(description='Temperatur Obst und Gemuese außerhalb des zulaessigen Bereichs'), temp_oug_korr
OPTIONS(description='Temperatur Obst und Gemuese korrigiert'), temp_tkk_rel_fg
OPTIONS(description='Temperatur Tiefgefroren relevant'), temp_tkk OPTIONS(description='Temperatur Tiefgefroren'),
temp_tkk_nok_fg OPTIONS(description='Temperatur Tiefgefroren außerhalb des zulaessigen Bereichs'), temp_tkk_korr
OPTIONS(description='Temperatur Tiefgefroren korrigiert'), temp_einh_id OPTIONS(description='Temperatur UoM'),
nutzung_grund_id OPTIONS(description='Utlization Reason'), sortimentsreihenfolge
OPTIONS(description='Sortimentsreihenfolge auf dem LKW'), ladung_gew
OPTIONS(description='Ladungsgewicht der Transporteinheit'), ladung_gew_einh_id OPTIONS(description='Gewichtseinheit'),
ladung_vol OPTIONS(description='Ladungsvolumen der Transporteinheit'), ladung_vol_einh_id
OPTIONS(description='Volumeneinheit'), dat_tour OPTIONS(description='Tourdatum'), menge_gefahrgut
OPTIONS(description='Gefahrgutmenge'), belos_tourart_id OPTIONS(description='Belos Tourart'), belos_tourstatus_id
OPTIONS(description='ID des Tourstatus; unterscheidet, ob im System angelegt, gesendet oder abgerechnet wurde'),
belos_tourart_subtyp OPTIONS(description='Tourart Subtyp'), belos_adresse_spedition_id
OPTIONS(description='Eindeutiger Schluessel zur Identifikation einer Belos Adresse'), belos_sonderabwicklung_id
OPTIONS(description='Sonderabwicklung'), belos_sonderabwicklung_ugk_fg
OPTIONS(description='Sonderabwicklung UGK auf dieser Tour_2 vorhanden'), belos_sonderabwicklung_gk_fg
OPTIONS(description='Sonderabwicklung GK auf dieser Tour_2 vorhanden'), belos_sonderabwicklung_tg_fg
OPTIONS(description='Sonderabwicklung TG auf dieser Tour_2 vorhanden'), belos_sonderabwicklung_tiko_fg
OPTIONS(description='Sonderabwicklung TIKO auf dieser Tour_2 vorhanden'), datzeit_start_plan
OPTIONS(description='Startzeitstempel des geplanten Starts einer W/V-Aktivitaet'), datzeit_start_ist
OPTIONS(description='Startzeitstempel des geplanten Starts einer W/V-Aktivitaet'), datzeit_ende_plan
OPTIONS(description='Endezeitstempel des geplanten Starts einer W/V-Aktivitaet'), datzeit_ende_ist
OPTIONS(description='Startzeitstempel des geplanten Starts einer W/V-Aktivitaet'), datzeit_route
OPTIONS(description='Abfahrtstermin für Route'), route_kz
OPTIONS(description='Ermittlungskennzeichen der Route zum Verladen der TE'), route_quelle
OPTIONS(description='Herkunft der Routenstammdaten'), tour_office_fg
OPTIONS(description='Fahrer muss ins Transportbuero'), tour_classification OPTIONS(description='Tourinfo'),
belos_rundlauf_transport_fg OPTIONS(description='Kennzeichen Rundlauf'), belos_fleischwerk_fg
OPTIONS(description='Kennzeichen FLW-Tour_2'), belos_distribution_abr_fg
OPTIONS(description='Kennzeichen Abrechnungsrelevnat'), belos_industrie_abh_fg
OPTIONS(description='Kennzeichen Industrieabholung'), belos_adresse_absender_num_id
OPTIONS(description='BELOS-Adresse Absender (numerisch)'), lagernummer_id OPTIONS(description='Lagernummer ID.'),
datzeit_anlage OPTIONS(description='Timestamap, an dem der Satz im Quellsystem angelegt wurde.'))
OPTIONS(DESCRIPTION = `S&R ACTIVITY OF TRANSPORTATION UNIT_2`) AS SELECT mandant_id,
 transportation_unit_id,
 kj_transportation_unit,
 transportation_unit_sr_act_id,
 aktivitaet_richtung_id,
 anlieferung_id,
 mercareon_kommentar_tdl,
 mercareon_kommentar_kl,
 leerpal_entscheidung_id,
 anz_pal_platz,
 ladung_begrenzung_fg,
 kommentar,
 kfz_kennzeichen,
 temp_frische_rel_fg,
 temp_frische,
 temp_frische_nok_fg,
 temp_frische_korr,
 temp_oug_rel_fg,
 temp_oug,
 temp_oug_nok_fg,
 temp_oug_korr,
 temp_tkk_rel_fg,
 temp_tkk,
 temp_tkk_nok_fg,
 temp_tkk_korr,
 temp_einh_id,
 nutzung_grund_id,
 sortimentsreihenfolge,
 ladung_gew,
 ladung_gew_einh_id,
 ladung_vol,
 ladung_vol_einh_id,
 dat_tour,
 menge_gefahrgut,
 belos_tourart_id,
 belos_tourstatus_id,
 belos_tourart_subtyp,
 belos_adresse_spedition_id,
 belos_sonderabwicklung_id,
 belos_sonderabwicklung_ugk_fg,
 belos_sonderabwicklung_gk_fg,
 belos_sonderabwicklung_tg_fg,
 belos_sonderabwicklung_tiko_fg,
 datzeit_start_plan,
 datzeit_start_ist,
 datzeit_ende_plan,
 datzeit_ende_ist,
 datzeit_route,
 route_kz,
 route_quelle,
 tour_office_fg,
 tour_classification,
 belos_rundlauf_transport_fg,
 belos_fleischwerk_fg,
 belos_distribution_abr_fg,
 belos_industrie_abh_fg,
 belos_adresse_absender_num_id,
 lagernummer_id,
 datzeit_anlage
FROM kfl_production_dbp_data.transportation_unit_aktivitaet_2;