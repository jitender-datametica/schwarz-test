 CREATE TABLE P_LEW_MART_LEAD.T_REF_PARAMETER_VT_1 COMMENT = 'Parameter Table for Reporting Team Solution VT'
 (
   param_id        INTEGER           COMMENT 'Parameter ID'
 , client_id       INTEGER           COMMENT 'Client ID to which the parameter should be applied. 7 = All'
 , val_int         INTEGER           COMMENT 'Integer parameter value'
 , val_date        DATE              COMMENT 'Date parameter value'
 , val_varchar     VARCHAR(10)       COMMENT 'Varchar parameter value'
 , comments        VARCHAR(100)      COMMENT 'Description of paramater and value'
 )
 ;