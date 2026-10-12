/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_REF_EJR_LP_RECEIPT_PRINT 
#----------------------------------------------------------------------------
# History:
#  1.0  15.11.2017    Harald Wieber            Release 1.1
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  06.04.2023    Wandtke,Andrzej          AP0152808 : Add case for 'Kein Originalbon'
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_EJR_LP_RECEIPT_PRINT AS
   SELECT	
     cl.client_id
    ,ml.language_id
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Preis'            THEN ml.field_text ELSE NULL END), ' ') AS price_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Kasse'            THEN ml.field_text ELSE NULL END), '' ) AS cash_desk_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Total'            THEN ml.field_text ELSE NULL END), '' ) AS total_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'MWST%'            THEN ml.field_text ELSE NULL END), '' ) AS vatp_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Netto'            THEN ml.field_text ELSE NULL END), '' ) AS netto_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Anzahl'           THEN ml.field_text ELSE NULL END), '' ) AS amount_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'BZ'               THEN ml.field_text ELSE NULL END), '' ) AS rr_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Z'                THEN ml.field_text ELSE NULL END), '' ) AS r_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Text'             THEN ml.field_text ELSE NULL END), '' ) AS text_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Brutto'           THEN ml.field_text ELSE NULL END), '' ) AS brutto_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'MWST'             THEN ml.field_text ELSE NULL END), '' ) AS vat_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Bonnummer'        THEN ml.field_text ELSE NULL END), '' ) AS receipt_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Artikel'          THEN ml.field_text ELSE NULL END), '' ) AS product_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Bonsumme'         THEN ml.field_text ELSE NULL END), '' ) AS receipt_value_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Bediener'         THEN ml.field_text ELSE NULL END), '' ) AS tender_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Wawi'             THEN ml.field_text ELSE NULL END), '' ) AS wawi_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Rückgabegrund'    THEN ml.field_text ELSE NULL END), '' ) AS return_reason_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Freigebender'     THEN ml.field_text ELSE NULL END), '' ) AS approver_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Filiale'          THEN ml.field_text ELSE NULL END), '' ) AS store_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Datum'            THEN ml.field_text ELSE NULL END), '' ) AS date_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Originalbondaten' THEN ml.field_text ELSE NULL END), '' ) AS original_receipt_text
    ,COALESCE(MAX(CASE WHEN ml.field_id = 'Kein Originalbon' THEN ml.field_text ELSE NULL END), '' ) AS no_original_receipt_text	
  FROM p_lew_mart_msi.v_ref_ejr_lp_md_translate ml	
   CROSS JOIN p_lew_mart_msi.v_ref_client cl	
   GROUP BY	
   cl.client_id	
   , ml.language_id;