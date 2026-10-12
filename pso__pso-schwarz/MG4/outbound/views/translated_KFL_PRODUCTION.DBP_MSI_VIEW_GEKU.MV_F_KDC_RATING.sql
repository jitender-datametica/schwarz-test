-- Es sind zwar einige Kategorien vom Ticket übernommen, aber nicht das Ticket selbst

-- Statt ticket_id gibt es eine anonymisierte ID, da aus Datenschutz nicht in Kombination mit dem Ticket ausgewertet werden darf

-- 01.09.2015 twie: neue Fakttabelle mit KDC Noten aus Zufriedenheitsabfrage

-- Daten kommen direkt aus Webformular, nicht über GEKU Portal
 CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_f_kdc_rating
(kdc_rating_uid, creation_date, expiration_date, mandant_id, geku_artikel_uid, geku_emotion_id, geku_prioritaet_id,
response_time, kindness, satisfaction, repeated_contact, recommendation, datzeit_inserted, datzeit_updated, dat_inserted
, dat_updated, abschlussgrund_id) AS SELECT kdc_rating_uid -- anonyme ID
,
 creation_date -- Ticket Erstelldatum
,
 expiration_date -- Ticket Abschlussdatum
,
 mandant_id -- Ticket Land
,
 geku_artikel_uid -- Ticket Kategorie
,
 geku_emotion_id -- Ticket Emotion
,
 geku_prioritaet_id -- Ticket Priorität
,
 response_time,
 kindness,
 satisfaction,
 repeated_contact,
 recommendation,
 datzeit_inserted -- Zeitpunkt Link zum Formular an Kunde geschickt
,
 datzeit_updated -- Zeitpunkt Antwort vom Kunde (optional)
,
 DATE(datzeit_inserted) AS dat_inserted,
 DATE(datzeit_updated) AS dat_updated,
 abschlussgrund_id -- Ticket Abschlussgrund

FROM kfl_production_dbp_view.v_kdc_rating;