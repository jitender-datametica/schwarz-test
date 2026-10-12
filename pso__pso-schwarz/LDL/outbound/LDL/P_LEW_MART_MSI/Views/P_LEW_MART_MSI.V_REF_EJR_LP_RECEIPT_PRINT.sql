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


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_ejr_lp_receipt_print AS SELECT CL.client_id,
 ML.language_id,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Preis'
    THEN ML.field_text
    ELSE NULL
    END), ' ') AS price_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Kasse'
    THEN ML.field_text
    ELSE NULL
    END), '') AS cash_desk_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Total'
    THEN ML.field_text
    ELSE NULL
    END), '') AS total_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'MWST%'
    THEN ML.field_text
    ELSE NULL
    END), '') AS vatp_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Netto'
    THEN ML.field_text
    ELSE NULL
    END), '') AS netto_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Anzahl'
    THEN ML.field_text
    ELSE NULL
    END), '') AS amount_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'BZ'
    THEN ML.field_text
    ELSE NULL
    END), '') AS rr_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Z'
    THEN ML.field_text
    ELSE NULL
    END), '') AS r_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Text'
    THEN ML.field_text
    ELSE NULL
    END), '') AS text_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Brutto'
    THEN ML.field_text
    ELSE NULL
    END), '') AS brutto_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'MWST'
    THEN ML.field_text
    ELSE NULL
    END), '') AS vat_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Bonnummer'
    THEN ML.field_text
    ELSE NULL
    END), '') AS receipt_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Artikel'
    THEN ML.field_text
    ELSE NULL
    END), '') AS product_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Bonsumme'
    THEN ML.field_text
    ELSE NULL
    END), '') AS receipt_value_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Bediener'
    THEN ML.field_text
    ELSE NULL
    END), '') AS tender_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Wawi'
    THEN ML.field_text
    ELSE NULL
    END), '') AS wawi_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Rückgabegrund'
    THEN ML.field_text
    ELSE NULL
    END), '') AS return_reason_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Freigebender'
    THEN ML.field_text
    ELSE NULL
    END), '') AS approver_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Filiale'
    THEN ML.field_text
    ELSE NULL
    END), '') AS store_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Datum'
    THEN ML.field_text
    ELSE NULL
    END), '') AS date_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Originalbondaten'
    THEN ML.field_text
    ELSE NULL
    END), '') AS original_receipt_text,
 COALESCE(MAX(CASE
    WHEN ML.field_id = 'Kein Originalbon'
    THEN ML.field_text
    ELSE NULL
    END), '') AS no_original_receipt_text
FROM ldl_p_lew_mart_msi.v_ref_ejr_lp_md_translate AS ML
 INNER JOIN ldl_p_lew_mart_msi.v_ref_client AS CL ON TRUE
GROUP BY CL.client_id,
 ML.language_id;