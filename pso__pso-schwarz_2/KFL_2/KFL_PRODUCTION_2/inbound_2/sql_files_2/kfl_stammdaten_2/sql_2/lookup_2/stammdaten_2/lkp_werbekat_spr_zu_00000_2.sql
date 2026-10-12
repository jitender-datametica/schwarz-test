SELECT 'KFL' as firma,trim(werbe_kat_bez) as werbe_kat_bez,mandant_id, min(werbe_kat_id) as werbe_kat_id from DBP_DATA.werbekat_spr_zu_2 WHERE spr_id = 22 GROUP BY 1,2,3;

