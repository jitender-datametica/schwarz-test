CREATE  TABLE DBP_ETL.as_food_tmp_1  (
art_id INTEGER NOT NULL
,mandant_id BYTEINT NOT NULL
,nb_id SMALLINT NOT NULL 
,wup_id INTEGER NOT NULL
,dat_auslistung DATE NOT NULL
,gp_id INTEGER NOT NULL DEFAULT -1
,phase_status BYTEINT NOT NULL DEFAULT -1  
,erl_fg BYTEINT /*CHECK ( (erl_fg >=  0 ) AND  (erl_fg <=  1 ) )*/ NOT NULL DEFAULT 0  
,dat_final DATE
,menge_startbestand DECIMAL(18,3) NOT NULL DEFAULT 0.000
,vk_netto DECIMAL(18,4) NOT NULL DEFAULT 0.0000
,phase_id BYTEINT
,kjwo_kl INTEGER
,weeks INTEGER
,alweek INTEGER
,week01 INTEGER
,week02 INTEGER
,week03 INTEGER
,week04 INTEGER
,week05 INTEGER
,vknorm DECIMAL(9,2)
,vkpr01 DECIMAL(9,2)
,vkpr02 DECIMAL(9,2)
,vkpr03 DECIMAL(9,2)
,vkpr04 DECIMAL(9,2)
,vkpr05 DECIMAL(9,2)
,aedat DATE
,erl_kz CHAR(1) COLLATE 'de-ci'
,td_insert TIMESTAMP_LTZ(9)
) ;

