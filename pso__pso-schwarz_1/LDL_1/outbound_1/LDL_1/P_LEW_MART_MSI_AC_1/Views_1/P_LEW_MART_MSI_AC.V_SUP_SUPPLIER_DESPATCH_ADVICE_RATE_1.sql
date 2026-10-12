CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_sup_supplier_despatch_advice_rate_1 (client_id
OPTIONS(description='Landeskennzeichen'), country_pol_cd OPTIONS(description='Landeskuerzel'), wh_id
OPTIONS(description='Gesellschafts-Nr.'), location_name OPTIONS(description='Gesellschaftsort'), contact_medium
OPTIONS(description='Kontaktmedium-Nr.'), contact_medium_desc OPTIONS(description='Kontaktmedium'),
contact_medium_purpose OPTIONS(description='Verwendungszweck'), item_rcv_dt OPTIONS(description='Wareneingangsdatum'),
cy_week OPTIONS(description='Kalenderwoche'), cy_month OPTIONS(description='Kalendermonat'), byr
OPTIONS(description='Geschaeftsjahr'), sup_sid OPTIONS(description='Lieferanten-Nr.'), src_orig_supplier_nr
OPTIONS(description=''), global_location_nr OPTIONS(description='GLN'), supplier_name
OPTIONS(description='Lieferantenberzeichnung'), contact_last_changed_dt
OPTIONS(description='Aenderungsdatum des Kontaktmediums'), avis_count OPTIONS(description='Angekommene Lieferavise'),
we_count OPTIONS(description='Gebuchte Wareneingänge'), we_count_edi
OPTIONS(description='Gebuchte Wareneingänge EDI-Lieferanten'), avis_used OPTIONS(description='Verwendete Lieferavise'),
avis_valid_from OPTIONS(description=''), free_delivery_order_valid_from OPTIONS(description=''),
crossdocking_order_valid_from OPTIONS(description=''), direct_order_valid_from OPTIONS(description='')) AS SELECT *
FROM ldl_p_lew_mart_msi.v_sup_supplier_despatch_advice_rate_1;