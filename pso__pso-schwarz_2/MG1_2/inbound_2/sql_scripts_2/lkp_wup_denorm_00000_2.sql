--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT d.mandant_id as mandant_id, wup_id, gl_vertrieb_id,ma_vorname||' '||ma_name  as gl_name
FROM DBP_MSI_DATA.wup_denorm_2 d,DBP_DATA.ma_spr_zu_2 s 
WHERE gl_vertrieb_id = ma_id AND d.mandant_id in ( 3,7)  and gl_vertrieb_id >0 
GROUP BY 1,2,3,4;

