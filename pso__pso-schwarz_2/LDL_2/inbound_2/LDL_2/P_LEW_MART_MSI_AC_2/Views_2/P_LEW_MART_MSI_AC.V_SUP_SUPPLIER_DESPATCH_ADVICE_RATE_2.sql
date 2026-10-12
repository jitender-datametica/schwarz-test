CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_SUP_SUPPLIER_DESPATCH_ADVICE_RATE_2
(
    client_id                           COMMENT 'Landeskennzeichen'
    , country_pol_cd                    COMMENT 'Landeskuerzel'
    , wh_id                             COMMENT 'Gesellschafts-Nr.'
    , location_name                     COMMENT 'Gesellschaftsort'
    , contact_medium                    COMMENT 'Kontaktmedium-Nr.'
    , contact_medium_desc               COMMENT 'Kontaktmedium'
    , contact_medium_purpose            COMMENT 'Verwendungszweck'
    , item_rcv_dt                       COMMENT 'Wareneingangsdatum'
    , cy_week                           COMMENT 'Kalenderwoche'
    , cy_month                          COMMENT 'Kalendermonat'
    , byr                               COMMENT 'Geschaeftsjahr'
    , sup_sid                           COMMENT 'Lieferanten-Nr.'
    , src_orig_supplier_nr              COMMENT ''
    , global_location_nr                COMMENT 'GLN'
    , supplier_name                     COMMENT 'Lieferantenberzeichnung'
    , contact_last_changed_dt           COMMENT 'Aenderungsdatum des Kontaktmediums'
    , avis_count                        COMMENT 'Angekommene Lieferavise'
    , we_count                          COMMENT 'Gebuchte Wareneingänge'
    , we_count_edi                      COMMENT 'Gebuchte Wareneingänge EDI-Lieferanten'
    , avis_used                         COMMENT 'Verwendete Lieferavise'
    , avis_valid_from                   COMMENT ''
    , free_delivery_order_valid_from    COMMENT ''
    , crossdocking_order_valid_from     COMMENT ''
    , direct_order_valid_from           COMMENT ''
) AS
SELECT
    client_id
    , country_pol_cd
    , wh_id
    , location_name
    , contact_medium
    , contact_medium_desc
    , contact_medium_purpose
    , item_rcv_dt
    , cy_week
    , cy_month
    , byr
    , sup_sid
    , src_orig_supplier_nr
    , global_location_nr
    , supplier_name
    , contact_last_changed_dt
    , avis_count
    , we_count
    , we_count_edi
    , avis_used
    , avis_valid_from
    , free_delivery_order_valid_from
    , crossdocking_order_valid_from
    , direct_order_valid_from
FROM P_LEW_MART_MSI.v_sup_supplier_despatch_advice_rate_2
;