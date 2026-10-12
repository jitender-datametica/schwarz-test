CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_REF_TRANSLINESTYPE_1
 (	
 translinestype_id	
 , transline_ref	
 , transline_desc	
 , transline_sdesc	
 , document_desc	
 , transline_desc_en	
 , transline_sdesc_en	
 , document_tlt_desc_en	
 , transline_xml_ref	
 , transline_comment	
 , language_id	
 )	
 AS	
    /*	
    #DescStart#	
    #$Revision: 6244 $, $LastChangedBy: hwieber $	
    #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
    #DescEnd#	
    */	
    SELECT	
    tlt.translinestype_id	
    ,tlt.transline_ref
    ,tlt.transline_desc	
    ,tlt.transline_sdesc	
    ,CASE	
    /* The numbers represent transactionlinetypes which are important for the view. 	
    From number 306 to 799 they are numbers which refer to discounts */	
    WHEN tlt.translinestype_id IN ('110', '210', '306', '307', '850', '855')	
    OR tlt.translinestype_id BETWEEN '400' AND '799'	
    THEN tlt.transline_sdesc	
    ELSE NULL	
    END AS document_desc	
    ,'N/A' AS transline_desc_en	
    ,'N/A' AS transline_sdesc_en	
    ,'N/A' AS document_tlt_desc_en	
    ,tlt.transline_xml_ref	
    ,tlt.transline_comment	
    ,tlt.language_id	
FROM p_lew_mart_msi.t_msi_ejr_ref_translinestype_1 tlt	
    UNION	
    SELECT	
    tty.transactiontype_id AS translinestype_id	
    ,tty.trans_ref AS transline_ref	
    ,tty.trans_desc AS transline_desc	
    ,tty.trans_desc AS transline_sdesc
    ,CASE	
/* The numbers represent transactiontypes which are important for the view. */	
WHEN tty.transactiontype_id IN ('400', '405', '410', '415', '420', '465')	
THEN tty.trans_desc	
ELSE NULL	
END AS document_desc	
    ,'N/A' AS trans_desc_en	
    ,'N/A' AS trans_sdesc_en	
    ,'N/A' AS document_tlt_desc_en	
    ,'N/A' AS transline_xml_ref	
    ,'N/A' AS transline_comment	
    ,tty.language_id	
FROM p_lew_mart_msi.t_msi_ejr_ref_transactiontype_1 AS tty	
    -- This condition ensures to get only one description.	
    -- If a header-transactiontype_id has lines having the same line-transactiontype_id,	
    -- this may be a problem for this view. This risk was calculated by the requestor.	
    WHERE NOT EXISTS (SELECT 1 FROM p_lew_mart_msi.t_msi_ejr_ref_translinestype_1 AS tlx	
    WHERE tty.transactiontype_id = tlx.translinestype_id);