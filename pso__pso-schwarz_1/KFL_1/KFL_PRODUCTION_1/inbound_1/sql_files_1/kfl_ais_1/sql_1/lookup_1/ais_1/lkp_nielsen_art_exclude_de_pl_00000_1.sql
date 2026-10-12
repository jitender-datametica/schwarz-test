SELECT 
mandant_id,
art_nielsen_id,
SUBSTRING(art_nielsen_tag,-40,40) as art_nielsen_tag,
art_nielsen_bez,
gtin_id 
FROM DBP_DATA.art_nielsen_1 
WHERE DAT_BIS='9999-12-31' and mandant_id NOT IN (1);
