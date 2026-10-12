/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for SF Functions f_GetPriceRange PITonCloud
#-------------------------------------------------------------------------------
# Describtion: Preparing a display of the price range for the intraface
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-08-03 Nikolai Toknov    Initial version
#  1.1	2022-08-10 Nikolai Toknov	 Add round function
#-------------------------------------------------------------------------------
*/


/* 
---------------------------------------------------------------------
Function	:	f_GetPriceRange(p_min_price number, p_max_price number)
Input		:	p_min_price number
				p_max_price number
                
Return		:   Varchar 
Convert		: 	None 
Description	:	Preparing a display of the price range for the intraface. Used in the AGG-framework.
TYPE		:	SQL-Function - single scalar				
Example		:	select f_GetPriceRange (3.01, 5.02)
------------------------------------------------------------------------
*/

CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit.f_getpricerange(p_min_price numeric, p_max_price numeric)
RETURNS STRING
as (
    if(
        p_min_price is null or p_max_price is null,
        null,
        if(
            round(p_min_price,2) = round(p_max_price,2),
            trim(replace(replace(replace(format("%'.2f", p_max_price),'.','_'),',','.'),'_',',')),
            trim(replace(replace(replace(format("%'.2f", p_min_price),'.','_'),',','.'),'_',',')) 
            || ' – ' ||
            trim(replace(replace(replace(format("%'.2f", p_max_price),'.','_'),',','.'),'_',','))
        )
    )
);

-- select f_GetPriceRange (3.01, 5.02)
-- select f_GetPriceRange (3.01, 12345678.02)
-- select f_GetPriceRange (3.00, 300)
-- select f_GetPriceRange (0, 0.1)
-- select f_GetPriceRange (0, -0.1)
-- select f_GetPriceRange (9.989, 9.991)