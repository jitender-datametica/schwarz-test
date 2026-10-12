/* AW check 2021-05-17*/
DELETE FROM DBP_MSI_DATA.ek_user_art_zu_2;

INSERT INTO DBP_MSI_DATA.ek_user_art_zu_2 (mandant_id,
                                          user_id,
		  art_id)
SELECT u_r.mandant_id, 
       u_r.user_id,
       a_vhd.art_id
FROM (SELECT mandant_id
            ,user_id
            ,rolle_id
            ,rolle_bez
            ,zek_id
            ,wbl_id
            ,gf_id
      FROM DBP_SECURITY.user_rolle_ek_int_zu_2) u_r
      JOIN (SELECT a.mandant_id,
                   a.art_id,
                   a.zek_id,
                   ekl.wbl_id,
                   gf.gf_id 
            FROM DBP_DATA.art_2 a
            LEFT JOIN (SELECT mandant_id
                             ,zek_id
                             ,wbl_id
                       FROM DBP_SECURITY.zek_wbl_zu_2) ekl
              ON a.mandant_id = ekl.mandant_id AND 
                 a.zek_id = ekl.zek_id
            LEFT JOIN (SELECT mandant_id
                             ,wbl_id
                             ,gf_id
                       FROM DBP_SECURITY.wbl_gf_zu_2) gf_2
              ON ekl.mandant_id = gf.mandant_id AND 
                 ekl.wbl_id = gf.wbl_id) a_vhd
  ON u_r.mandant_id = a_vhd.mandant_id AND 
    (u_r.zek_id = a_vhd.zek_id OR 
     u_r.wbl_id = a_vhd.wbl_id OR 
     u_r.gf_id = a_vhd.gf_id)
WHERE u_r.rolle_id IN (1,2,3)
UNION
SELECT u_r.mandant_id, 
       u_r.user_id,
       a_vat.art_id
FROM (SELECT mandant_id
            ,user_id
            ,rolle_id
            ,rolle_bez
            ,zek_id
            ,wbl_id
            ,gf_id
      FROM DBP_SECURITY.user_rolle_ek_int_zu_2) u_r
JOIN (SELECT a.mandant_id, 
             a.art_id,
             a.zek_vat_id AS zek_id,
             ekl.wbl_id,
             gf.gf_id 
      FROM DBP_DATA.art_2 a
      LEFT JOIN(SELECT mandant_id
                      ,zek_id
                      ,wbl_id
                FROM DBP_SECURITY.zek_wbl_zu_2) ekl
        ON a.mandant_id = ekl.mandant_id AND 
           a.zek_vat_id = ekl.zek_id
      LEFT JOIN (SELECT mandant_id
                       ,wbl_id
                       ,gf_id
                 FROM DBP_SECURITY.wbl_gf_zu_2) gf_2
        ON ekl.mandant_id = gf.mandant_id AND 
           ekl.wbl_id = gf.wbl_id) a_vat
  ON u_r.mandant_id = a_vat.mandant_id AND 
    (u_r.zek_id = a_vat.zek_id OR 
     u_r.wbl_id = a_vat.wbl_id OR 
     u_r.gf_id = a_vat.gf_id)
WHERE u_r.rolle_id IN (1,2,3)
UNION
SELECT u_r.mandant_id, 
       u_r.user_id,
       art.art_id
FROM (SELECT mandant_id
            ,user_id
            ,rolle_id
            ,rolle_bez
            ,zek_id
            ,wbl_id
            ,gf_id
      FROM DBP_SECURITY.user_rolle_ek_int_zu_2) u_r
JOIN DBP_DATA.art_2 art_2
  ON u_r.mandant_id = art.mandant_id
WHERE u_r.rolle_id = 4
;

