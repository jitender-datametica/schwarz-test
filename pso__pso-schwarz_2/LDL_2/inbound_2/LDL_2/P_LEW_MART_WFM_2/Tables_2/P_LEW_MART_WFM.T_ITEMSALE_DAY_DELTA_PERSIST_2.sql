/*
#----------------------------------------------------------------------------
# @ Schwarz IT KG - Enterprise Reporting VT-WG [LDL - DIV]
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.T_ITEMSALE_DAY_DELTA_PERSIST_2
#----------------------------------------------------------------------------
# History:
#  1.0  23.11.2022    Jana Mildorf      User Story 398511
#  1.1  07.03.2022    Jana Mildorf      User Story 448812
   1.2  24.07.2023    Olga Becker       User Story 499314
#----------------------------------------------------------------------------
*/
CREATE TABLE P_LEW_MART_WFM.T_ITEMSALE_DAY_DELTA_PERSIST_2 
CLUSTER BY (RECEIPTDATE)
(
    CLIENT_ID NUMBER(38,0)
    ,STORE NUMBER(38,0)
    ,ITEM_2 NUMBER(38,0)
    ,RECEIPTDATE DATE
    ,SUM_QTY_WEIGHT NUMBER(32,5)
    ,SUM_QTY_PIECE NUMBER(31,5)
    ,SUM_TURNOVER_NET NUMBER(31,5)
    ,TIMELASTSOLD TIME(9)
    ,DISCOUNT_VALUE_NET NUMBER(31,5)
    ,DISCOUNT_PIECES NUMBER(30,5)
    ,DISCOUNT_TURNOVER_NET NUMBER(31,5)
    ,DISCOUNT_WEIGHT_PIECE NUMBER(32,5)
    ,DISCOUNT_PIECES_TXJ NUMBER(30,5)
    ,DISCOUNT_PIECES_CASHPOINT NUMBER(30,5)
    ,DISCOUNT_PIECES_SFO NUMBER(38,10)
    ,DISCOUNT_UNITS NUMBER(30,5)
    ,DISCOUNT_LW NUMBER(30,5)
	,DISCOUNT_EJR NUMBER(30,5)
    ,LOAD_ID VARCHAR(16777216)
    ,LAST_PERSIST_TMSP TIMESTAMP_NTZ(9) DEFAULT CURRENT_TIMESTAMP
  
);