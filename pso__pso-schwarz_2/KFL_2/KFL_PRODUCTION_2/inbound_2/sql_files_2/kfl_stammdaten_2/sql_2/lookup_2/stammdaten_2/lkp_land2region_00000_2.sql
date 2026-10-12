--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT r.mandant_id,
       r.land_id,
       r.region_id,
       r.sap_region_id 
FROM DBP_DATA.region_2 r 
JOIN DBP_DATA.land_2 l 
  ON r.mandant_id = l.mandant_id AND 
     r.land_id = l.land_id;

