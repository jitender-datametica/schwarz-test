CREATE OR REPLACE FUNCTION LDL_PRODUCTION.P_LEW_MART_PIT.F_GETPRICERANGE(""P_MIN_PRICE"" NUMBER(38,0), ""P_MAX_PRICE"" NUMBER(38,0))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
STRICT
AS '
        IFF  ( round(p_min_price,2)=round(p_max_price,2) 
                    , trim(replace(replace(replace(to_char( p_max_price, ''999,999,990.00'' ),''.'',''_''),'','',''.''),''_'','',''))
		            , trim(replace(replace(replace(to_char( p_min_price, ''999,999,990.00'' ),''.'',''_''),'','',''.''),''_'','',''))
                        || '' – '' || 
                      trim(replace(replace(replace(to_char( p_max_price, ''999,999,990.00'' ),''.'',''_''),'','',''.''),''_'','',''))
             )
    ';