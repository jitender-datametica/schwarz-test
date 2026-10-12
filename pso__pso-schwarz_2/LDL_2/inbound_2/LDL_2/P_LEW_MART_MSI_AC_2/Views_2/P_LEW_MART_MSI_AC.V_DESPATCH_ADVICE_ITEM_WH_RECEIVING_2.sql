CREATE OR REPLACE VIEW p_lew_mart_msi_ac.v_despatch_advice_item_wh_receiving_2                                       
(
    client_id                           COMMENT 'Landeskennzeichen'
    , wh_id                             COMMENT 'Gesellschafts-Nr.'
	, sup_sid                           COMMENT 'Lieferanten-Nr.'
    , item_rcv_dt                       COMMENT 'Wareneingangsdatum'
    , cy_week                           COMMENT 'Kalenderwoche'
    , cy_month                          COMMENT 'Kalendermonat'
    , byr                               COMMENT 'Geschaeftsjahr'
    , global_location_nr                COMMENT 'GLN'
    , supplier_name                     COMMENT 'Lieferantenbezeichnung'
	, src_orig_supplier_nr              COMMENT ''
    , we_count_ges                      COMMENT 'Gebuchte Wareneingänge'
) AS
SELECT
    client_id
    , wh_id
	, sup_sid
    , item_rcv_dt
    , cy_week
    , cy_month
    , byr
	, global_location_nr
	, supplier_name
    , src_orig_supplier_nr
    , we_count_ges
FROM p_lew_mart_msi.v_despatch_advice_item_wh_receiving_2
;