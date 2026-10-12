CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fur_prognose (mandant_id OPTIONS(description='Mandant im DWH'), wup_id
OPTIONS(description='Marktnummer'), nb_id OPTIONS(description=' Nebenbetriebskennziffer'), art_id
OPTIONS(description='DWH-Artikelnummer'), dat OPTIONS(description='Prognosedatumim Format JJJJ-MM-TT'), menge_prognose
OPTIONS(description='Normalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_mean '), menge_prognose_bef
OPTIONS(description='Normalprognosemenge  in Basismengeneinheit verändert um den BEF (Bedarfseinflussfaktor)  aus dem Quellfeld fc_dif_effect'),
menge_prognose_max OPTIONS(description='Maximalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_max'),
listung_id
OPTIONS(description='kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Denormalisiert - aus art_wup_zu_per angereichert'),
kdis
OPTIONS(description='kdis = kein Druck in Sortimentsliste. Kennzeichnet die Bestellbarkeit eines Artikels. kdis 0: der Artikel ist über den normalen Weg bestellbar, 1: der Artikel wird  zugeteilt'),
dispomerkmal
OPTIONS(description='Dispomerkmal. Denormalisiert aus der Tabelle art_wup_status_per. Referenz zur Lookuptabelle l_dispomerkmal'),
progn_groesser_fg
OPTIONS(description='menge_prognose ist größer als die menge_af in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)'),
menge_af_groesser_fg
OPTIONS(description='menge_af ist größer als die menge_prognose in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)'),
menge_prognose_aktion
OPTIONS(description='Prognostizierte Aktionsmenge. Wird vorläufig nur gefüllt sein für Backshop-Artikel (WG 291), wenn sie in Aktion sind. Aus der Quellspalte fc_act'),
prognose_horizont
OPTIONS(description='Prognosehorizont: für wie viele Tage gab es prognostizierte Mengen (wie viele Felder von ZFRE_DWH_FCST.menge_01 bis menge_35 waren gefüllt)'),
menge_ofc OPTIONS(description='Menge OF'))
OPTIONS(DESCRIPTION = `AIS - HIER WERDEN DIE PROGNOSTIZIERTEN ABVERKAUFSMENGEN AUS SAP F&R FÜR 35 TAGE IM VORAUS UND MEHRERE JAHRE HISTORISCH GESPEICHERT`)
AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat,
 menge_prognose,
 menge_prognose_bef,
 menge_prognose_max,
 listung_id,
 kdis,
 dispomerkmal,
 progn_groesser_fg,
 menge_af_groesser_fg,
 menge_prognose_aktion,
 prognose_horizont,
 menge_ofc
FROM kfl_production_dbp_data.fur_prognose;