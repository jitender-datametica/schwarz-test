CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_REF_TRANSACTIONTYPE_2
  /*	
  #DescStart#	
  #$Revision: 6244 $, $LastChangedBy: hwieber $	
  #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
  #DescEnd#	
  */	
  (	
  transactiontype_id	
  , trans_desc	
  , trans_desc_en	
  , trans_ref	
  , language_id	
  )	
  AS	
     SELECT	
     transactiontype_id,	
     trans_desc,	
     'N/A' AS trans_desc_en,	
     trans_ref,	
     language_id	
 FROM p_lew_mart_msi.t_msi_ejr_ref_transactiontype_2;