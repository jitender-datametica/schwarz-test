CREATE TABLE P_LEW_LOAD.T_LP_CUSTMAP_CONTENT_LOOKUP_HISTORY_LOYALTY_ID_2 (
   client_id VARCHAR(100),
   country_code VARCHAR(10),
   loyalty_cards_loyalty_id VARCHAR(100),
   loyalty_cards_type VARCHAR(50),
   contactnewloyalty_min_date TIMESTAMP(6),
   contactnewloyalty_max_date TIMESTAMP(6),
   ssoclientlegaltermsaccepted_ssoclientappid_min_date TIMESTAMP(6),
   ssoclientlegaltermsaccepted_ssoclientappid_min_country VARCHAR(10),
   ssoclientlegaltermsaccepted_ssoclientappid_max_date TIMESTAMP(6),
   ssoclientlegaltermsaccepted_ssoclientappid_max_country VARCHAR(10),   
   ssoclientlegaltermsdeclined_ssoclientappid_min_date TIMESTAMP(6),   
   ssoclientlegaltermsdeclined_ssoclientappid_min_country VARCHAR(10),
   ssoclientlegaltermsdeclined_ssoclientappid_max_date TIMESTAMP(6),
   ssoclientlegaltermsdeclined_ssoclientappid_max_country VARCHAR(10)   
);