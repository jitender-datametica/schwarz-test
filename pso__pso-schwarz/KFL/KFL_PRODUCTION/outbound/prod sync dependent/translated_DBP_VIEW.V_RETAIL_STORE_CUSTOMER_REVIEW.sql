CREATE OR REPLACE VIEW kfl_production_dbp_view.v_retail_store_customer_review (ext_system_name
OPTIONS(description='Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42'),
ext_customer_review_id OPTIONS(description='ID der Review im externen System'), ext_retail_company_id
OPTIONS(description='Id of the retail company in the system that provides the info'), wup_id
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), mandant_id
OPTIONS(description='Mandant im DWH'), ext_store_id
OPTIONS(description='Id of the retail store in the system that provides the info'), review_tmsp
OPTIONS(description='Zeitstempel, wann der Kunde die Rezension abgegeben hat'), review_rating
OPTIONS(description='Bewertung, die der Kunde dem Einzelhandelsgeschäft gegeben hat'), review_native_txt
OPTIONS(description='Rezension in der Originalsprache, die der Kunde dem Einzelhandelsgeschäft gegeben hat'),
review_english_txt
OPTIONS(description='Englische Übersetzung der Rezension, die der Kunde dem Einzelhandelsgeschäft gegeben hat. Diese Spalte ist null, wenn review_native_ext Emoji enthält.'),
review_status_cd
OPTIONS(description='Der Code gibt die Art der Einfügung an, ob die Kundenrezension zuletzt eingefügt oder aktualisiert wurde. (I = Insert, U = Update)'))
AS SELECT ext_system_name,
 ext_customer_review_id,
 ext_retail_company_id,
 wup_id,
 nb_id,
 mandant_id,
 ext_store_id,
 review_tmsp,
 review_rating,
 review_native_txt,
 review_english_txt,
 review_status_cd
FROM kfl_production_dbp_data.retail_store_customer_review;