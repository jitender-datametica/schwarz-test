CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_despatch_advice_item_wh_receiving (client_id
OPTIONS(description='Landeskennzeichen'), wh_id OPTIONS(description='Gesellschafts-Nr.'), sup_sid
OPTIONS(description='Lieferanten-Nr.'), item_rcv_dt OPTIONS(description='Wareneingangsdatum'), cy_week
OPTIONS(description='Kalenderwoche'), cy_month OPTIONS(description='Kalendermonat'), byr
OPTIONS(description='Geschaeftsjahr'), global_location_nr OPTIONS(description='GLN'), supplier_name
OPTIONS(description='Lieferantenbezeichnung'), src_orig_supplier_nr OPTIONS(description=''), we_count_ges
OPTIONS(description='Gebuchte Wareneingänge')) AS SELECT *
FROM ldl_p_lew_mart_msi.v_despatch_advice_item_wh_receiving;