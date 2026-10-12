create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_F_KDC_RATING(
	KDC_RATING_UID,
	CREATION_DATE,
	EXPIRATION_DATE,
	MANDANT_ID,
	GEKU_ARTIKEL_UID,
	GEKU_EMOTION_ID,
	GEKU_PRIORITAET_ID,
	RESPONSE_TIME,
	KINDNESS,
	SATISFACTION,
	REPEATED_CONTACT,
	RECOMMENDATION,
	DATZEIT_INSERTED,
	DATZEIT_UPDATED,
	DAT_INSERTED,
	DAT_UPDATED,
	ABSCHLUSSGRUND_ID
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    kdc_rating_uid --anonyme ID
   ,creation_date --Ticket Erstelldatum
   ,expiration_date --Ticket Abschlussdatum
   ,mandant_id --Ticket Land
   ,geku_artikel_uid --Ticket Kategorie
   ,geku_emotion_id --Ticket Emotion
   ,geku_prioritaet_id --Ticket Priorität
   ,response_time
   ,kindness
   ,satisfaction
   ,repeated_contact
   ,recommendation
   ,datzeit_inserted --Zeitpunkt Link zum Formular an Kunde geschickt
   ,datzeit_updated --Zeitpunkt Antwort vom Kunde (optional)
   ,CAST(datzeit_inserted AS DATE) AS dat_inserted
   ,CAST(datzeit_updated AS DATE) AS dat_updated
   ,abschlussgrund_id --Ticket Abschlussgrund

   FROM DBP_DATA.KDC_RATING;
