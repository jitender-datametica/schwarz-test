--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT land_id, MAX(region_id) FROM DBP_DATA.region GROUP BY 1;

